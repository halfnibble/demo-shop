from django import template
from oscar.core.loading import get_model

register = template.Library()
ProductBrand = get_model('catalogue', 'ProductBrand')

# Since the category_tree template tag can be used multiple times in the same
# set of templates, we use a cache to avoid creating the node multile times.
NODE_CACHE = {}


@register.assignment_tag
def product_brands():
	brands = ProductBrand.objects.all()
	for brand in brands:
		brand.url = "brand/" + brand.slug

	return brands