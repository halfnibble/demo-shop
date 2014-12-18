from oscar.apps.dashboard.catalogue.forms import ProductForm as CoreProductForm

class ProductForm(CoreProductForm):
	
	class Meta(CoreProductForm.Meta):
		fields = [
			'title', 'upc', 'description', 'brand', 'activity', 'is_discountable', 'structure']
	
	def delete_non_child_fields(self):
		"""
		Deletes any fields not needed for child products. Override this if
		you want to e.g. keep the description field.
		"""
		for field_name in ['description', 'is_discountable', 'brand', 'activity',]:
			if field_name in self.fields:
				del self.fields[field_name]

	