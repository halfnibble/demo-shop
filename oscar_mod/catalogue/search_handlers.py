from django.conf import settings
from django.views.generic.list import MultipleObjectMixin

from oscar.core.loading import get_class, get_model

BrowseCategoryForm = get_class('search.forms', 'BrowseCategoryForm')
SearchHandler = get_class('search.search_handlers', 'SearchHandler')
is_solr_supported = get_class('search.features', 'is_solr_supported')
Product = get_model('catalogue', 'Product')


def get_product_search_handler_class():
	"""
	Determine the search handler to use.
	Currently only Solr is supported as a search backend, so it falls
	back to rudimentary category browsing if that isn't enabled.
	"""
	# Use get_class to ensure overridability
	if is_solr_supported():
		return get_class('catalogue.search_handlers', 'ProductSearchHandler')
	else:
		return get_class(
			'catalogue.search_handlers', 'SimpleProductSearchHandler')


class ProductSearchHandler(SearchHandler):
	"""
	Search handler specialised for searching products.  Comes with optional
	category filtering.
	"""
	form_class = BrowseCategoryForm
	model_whitelist = [Product]
	paginate_by = settings.OSCAR_PRODUCTS_PER_PAGE

	def __init__(self, request_data, full_path, categories=None):
		self.categories = categories
		super(ProductSearchHandler, self).__init__(request_data, full_path)

	def get_search_queryset(self):
		sqs = super(ProductSearchHandler, self).get_search_queryset()
		if self.categories:
			# We use 'narrow' API to ensure Solr's 'fq' filtering is used as
			# opposed to filtering using 'q'.
			pattern = ' OR '.join([
				'"%s"' % c.full_name for c in self.categories])
			sqs = sqs.narrow('category_exact:(%s)' % pattern)
		return sqs


class SimpleProductSearchHandler(MultipleObjectMixin):
	"""
	A basic implementation of the full-featured SearchHandler that has no
	faceting support, but doesn't require a Haystack backend. It only
	supports category browsing.
	Note that is meant as a replacement search handler and not as a view
	mixin; the mixin just does most of what we need it to do.
	"""
	paginate_by = settings.OSCAR_PRODUCTS_PER_PAGE

	def __init__(self, request_data, full_path, categories=None, brand=None, activity=None):
		self.categories = categories
		self.brand = brand
		self.activity = activity
		self.kwargs = {'page': request_data.get('page', 1)}
		self.object_list = self.get_queryset()

	def get_queryset(self):
		qs = Product.browsable.base_queryset()
		if self.categories:
			qs = qs.filter(categories__in=self.categories).distinct()
		"""
		Add Activity and Brand Filters to search_context
		"""
		if self.brand is not None:
			# Add Brand filtering to products list
			qs = qs.filter(brand=self.brand)

		if self.activity is not None:
			# Add Activity filtering to products list
			qs = qs.filter(activity=self.activity)
		return qs

	def get_search_context_data(self, context_object_name):
		# Set the context_object_name instance property as it's needed
		# internally by MultipleObjectMixin
		self.context_object_name = context_object_name
		context = self.get_context_data(object_list=self.object_list)
		context[context_object_name] = context['page_obj'].object_list
		return context