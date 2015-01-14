from django.core.urlresolvers import reverse
from django.views.generic import View, ListView, CreateView, UpdateView
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.contrib import messages

from oscarmod.catalogue.models import Product
from oscarmod.partner.models import StockRecord

from .models import ImportRecord, Tariff
from .forms import ImportRecordForm

class ProductMixin(object):
    """
    This mixin handles product and title attributes of ImportRecord Views.
    """
    def dispatch(self, *args, **kwargs):
        parent_pk = self.kwargs['parent_pk']
        self.parent = get_object_or_404(Product, pk=parent_pk)
        self.variants = Product.objects.filter(parent=self.parent)
        self.stock_records = StockRecord.objects.select_related(
            'product').filter(product__in=self.variants)
        self.tariffs = Tariff.objects.all()
        return super(ProductMixin, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(ProductMixin, self).get_context_data(**kwargs)
        context['parent'] = self.parent
        context['variants'] = self.variants
        context['stock_records'] = self.stock_records
        context['tariffs'] = self.tariffs
        context['title'] = self.get_page_title()
        return context

    def get_page_title(self):
        raise NotImplementedError("You must create a title method.")


class ProductFormMixin(object):
    """
    A simple mixin to add dynamic kwargs to the ModelForm instance named 
    ImportRecordForm. For generating dynamic field querysets. 
    """
    def get_form_kwargs(self):
        kwargs = super(ProductFormMixin, self).get_form_kwargs()
        kwargs['parent'] = self.parent
        return kwargs

class FormSaveMixin(object):
    """
    Redirect submitted form to self and display a message.
    """
    @property
    def submitted_msg(self):
        return "Your changes have been applied."

    # Relate this record to a Tariff if None selected.
    def set_related_tariff(self, form):
        if form.instance.tariff_code is not None:
            try:
                tariff = Tariff.objects.get(code=form.instance.tariff_code)
            except:
                tariff = None
            form.instance.related_tariff = tariff
        return form

    def form_valid(self, form):
        if form.instance.related_tariff is None:
            form = self.set_related_tariff(form)
        self.object = form.save()
        messages.info(self.request, self.submitted_msg)
        # form = self.get_form(self.form_class)
        # attempting to re-render form fields.
        update_form = reverse('dashboard:update_record', kwargs={'parent_pk': self.parent.pk, 'pk': self.object.id })
        return HttpResponseRedirect(update_form)
        #self.render_to_response(self.get_context_data(form=form))
        


class RecordListView(ProductMixin, ListView):
    model = ImportRecord
    context_object_name = 'records'
    
    def get_queryset(self):
        variants = self.parent.children.all()
        products = list(variants) + [self.parent]
        return ImportRecord.objects.filter(product__in=products).order_by(
            '-imported_date')
        
    def get_page_title(self):
        return u"Import Records for %s." % (self.parent.title)


class RecordCreateView(ProductMixin, ProductFormMixin,
    FormSaveMixin, CreateView):
    model = ImportRecord
    form_class = ImportRecordForm

    def get_page_title(self):
        return u"Create new record for \"%s.\"" % (self.parent.title)


class RecordUpdateView(ProductMixin, ProductFormMixin,
    FormSaveMixin, UpdateView):
    model = ImportRecord
    form_class = ImportRecordForm

    def get_page_title(self):
        return u"Update record for \"%s.\"" % (self.parent.title)

