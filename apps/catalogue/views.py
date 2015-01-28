from django.contrib import messages
from django.core.paginator import InvalidPage
from django.utils.http import urlquote
from django.http import HttpResponsePermanentRedirect
from django.shortcuts import get_object_or_404, redirect
from django.views.generic import DetailView, TemplateView
from django.utils.translation import ugettext_lazy as _

from oscar.core.loading import get_class, get_model
from oscar.apps.catalogue.signals import product_viewed

Product = get_model('catalogue', 'Product')
ProductActivity = get_model('catalogue', 'ProductActivity')
ProductBrand = get_model('catalogue', 'ProductBrand')
ProductReview = get_model('reviews', 'ProductReview')
Category = get_model('catalogue', 'Category')
ProductAlert = get_model('customer', 'ProductAlert')
ProductAlertForm = get_class('customer.forms', 'ProductAlertForm')
get_product_search_handler_class = get_class(
    'catalogue.search_handlers', 'get_product_search_handler_class')


class ProductDetailView(DetailView):
    context_object_name = 'product'
    model = Product
    view_signal = product_viewed
    template_folder = "catalogue"

    # Whether to redirect to the URL with the right path
    enforce_paths = True

    # Whether to redirect child products to their parent's URL
    enforce_parent = True

    def get(self, request, **kwargs):
        """
        Ensures that the correct URL is used before rendering a response
        """
        self.object = product = self.get_object()

        redirect = self.redirect_if_necessary(request.path, product)
        if redirect is not None:
            return redirect

        response = super(ProductDetailView, self).get(request, **kwargs)
        self.send_signal(request, response, product)
        return response

    def get_object(self, queryset=None):
        # Check if self.object is already set to prevent unnecessary DB calls
        if hasattr(self, 'object'):
            return self.object
        else:
            return super(ProductDetailView, self).get_object(queryset)

    def redirect_if_necessary(self, current_path, product):
        if self.enforce_parent and product.is_child:
            return HttpResponsePermanentRedirect(
                product.parent.get_absolute_url())

        if self.enforce_paths:
            expected_path = product.get_absolute_url()
            if expected_path != urlquote(current_path):
                return HttpResponsePermanentRedirect(expected_path)

    def get_context_data(self, **kwargs):
        ctx = super(ProductDetailView, self).get_context_data(**kwargs)
        ctx['reviews'] = self.get_reviews()
        ctx['alert_form'] = self.get_alert_form()
        ctx['has_active_alert'] = self.get_alert_status()
        return ctx

    def get_alert_status(self):
        # Check if this user already have an alert for this product
        has_alert = False
        if self.request.user.is_authenticated():
            alerts = ProductAlert.objects.filter(
                product=self.object, user=self.request.user,
                status=ProductAlert.ACTIVE)
            has_alert = alerts.exists()
        return has_alert

    def get_alert_form(self):
        return ProductAlertForm(
            user=self.request.user, product=self.object)

    def get_reviews(self):
        return self.object.reviews.filter(status=ProductReview.APPROVED)

    def send_signal(self, request, response, product):
        self.view_signal.send(
            sender=self, product=product, user=request.user, request=request,
            response=response)

    def get_template_names(self):
        """
        Return a list of possible templates.
        If an overriding class sets a template name, we use that. Otherwise,
        we try 2 options before defaulting to catalogue/detail.html:
            1). detail-for-upc-<upc>.html
            2). detail-for-class-<classname>.html
        This allows alternative templates to be provided for a per-product
        and a per-item-class basis.
        """
        if self.template_name:
            return [self.template_name]

        return [
            '%s/detail-for-upc-%s.html' % (
                self.template_folder, self.object.upc),
            '%s/detail-for-class-%s.html' % (
                self.template_folder, self.object.get_product_class().slug),
            '%s/detail.html' % (self.template_folder)]


class CatalogueView(TemplateView):
    """
    Browse all products in the catalogue
    """
    context_object_name = "products"
    template_name = 'catalogue/browse.html'
    
    # For filtering by Brand and Activity
    def get_filters(self):
        if 'brand' in self.kwargs:
            self.brand = get_object_or_404(ProductBrand, slug=self.kwargs['brand'])
        else:
            self.brand = None

        if 'activity' in self.kwargs:
            self.activity = get_object_or_404(ProductActivity, slug=self.kwargs['activity'])
        else:
            self.activity = None

    def get(self, request, *args, **kwargs):
        self.get_filters()
        try:
            self.search_handler = self.get_search_handler(
                self.request.GET, request.get_full_path(), [],
                self.brand, self.activity)
        except InvalidPage:
            # Redirect to page one.
            messages.error(request, _('The given page number was invalid.'))
            return redirect('catalogue:index')
        return super(CatalogueView, self).get(request, *args, **kwargs)

    def get_search_handler(self, *args, **kwargs):
        return get_product_search_handler_class()(*args, **kwargs)

    def get_context_data(self, **kwargs):
        ctx = {}
        ctx['summary'] = _("All products")
        ctx['brand'] = self.brand
        ctx['activity'] = self.activity
        search_context = self.search_handler.get_search_context_data(
            self.context_object_name)
        ctx.update(search_context)
        return ctx


class ProductCategoryView(TemplateView):
    """
    Browse products in a given category
    """
    context_object_name = "products"
    template_name = 'catalogue/category.html'
    enforce_paths = False
    
    # For filtering by Brand and Activity
    def get_filters(self):
        if 'brand' in self.kwargs:
            self.brand = get_object_or_404(ProductBrand, slug=self.kwargs['brand'])
        else:
            self.brand = None

        if 'activity' in self.kwargs:
            self.activity = get_object_or_404(ProductActivity, slug=self.kwargs['activity'])
        else:
            self.activity = None

    def get(self, request, *args, **kwargs):
        # Fetch the category; return 404 or redirect as needed
        self.get_filters()
        self.category = self.get_category()

        potential_redirect = self.redirect_if_necessary(
            request.path, self.category)
        if potential_redirect is not None:
            return potential_redirect

        try:
            self.search_handler = self.get_search_handler(
                request.GET, request.get_full_path(), self.get_categories(),
                self.brand, self.activity)
        except InvalidPage:
            messages.error(request, _('The given page number was invalid.'))
            return redirect(self.category.get_absolute_url())

        return super(ProductCategoryView, self).get(request, *args, **kwargs)

    def get_category(self):
        if 'pk' in self.kwargs:
            # Usual way to reach a category page. We just look at the primary
            # key in case the slug changed. If it did, get() will redirect
            # appropriately
            filters = {'pk': self.kwargs['pk']}
        else:
            # For SEO reasons, we allow chopping off bits of the URL. If that
            # happened, no primary key will be available.
            filters = {'slug': self.kwargs['category_slug']}

        
        return get_object_or_404(Category, **filters)

    def redirect_if_necessary(self, current_path, category):
        if self.enforce_paths:
            # Categories are fetched by primary key to allow slug changes.
            # If the slug has changed, issue a redirect.
            expected_path = category.get_absolute_url()
            if expected_path != urlquote(current_path):
                return HttpResponsePermanentRedirect(expected_path)

    def get_search_handler(self, *args, **kwargs):
        return get_product_search_handler_class()(*args, **kwargs)

    def get_categories(self):
        """
        Return a list of the current category and its ancestors
        """
        return self.category.get_descendants_and_self()

    def get_context_data(self, **kwargs):
        context = super(ProductCategoryView, self).get_context_data(**kwargs)
        context['category'] = self.category
        context['brand'] = self.brand
        context['activity'] = self.activity
        search_context = self.search_handler.get_search_context_data(
            self.context_object_name)
                    
        context.update(search_context)
        return context