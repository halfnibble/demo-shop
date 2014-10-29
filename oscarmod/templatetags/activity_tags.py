from django import template
from oscar.core.loading import get_model

register = template.Library()
ProductActivity = get_model('catalogue', 'ProductActivity')

# Since the category_tree template tag can be used multiple times in the same
# set of templates, we use a cache to avoid creating the node multile times.
NODE_CACHE = {}


@register.assignment_tag  # noqa (too complex (14))
def product_activities():
	activities = ProductActivity.objects.all()
	for activity in activities:
		activity.url = "activity/" + activity.slug

	return activities