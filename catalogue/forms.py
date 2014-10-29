from django import forms
from django.utils.text import slugify

class BrandForm(forms.ModelForm):
	class Meta:
		model = ProductBrand
		fields = (
			'name',
		)

	def save(self):
		instance = super(BrandForm, self).save(commit=False)
		instance.slug = slugify(instance.name)
		instance.save()

		return instance

class ActivityForm(forms.ModelForm):
	class Meta:
		model = ActivityBrand
		fields = (
			'name',
		)

	def save(self):
		instance = super(ActivityForm, self).save(commit=False)
		instance.slug = slugify(instance.name)
		instance.save()

		return instance