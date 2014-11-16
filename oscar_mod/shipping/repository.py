from decimal import Decimal as D
from oscar.apps.shipping import repository, methods
from oscar_mod.shipping import models

class Express(methods.FixedPrice):
	code = "express"
	name = "USPS Priority Mail"
	charge_excl_tax = D('24.99')
	
class Repository(repository.Repository):
	"""
	Repository class responsible for returning ShippingMethod
	objects for a given user, basket etc
	"""

	def get_available_shipping_methods(self, basket, user=None, shipping_addr=None, request=None, **kwargs):
		"""
		Return a list of all applicable shipping method objects
		for a given basket.

		We default to returning the Method models that have been defined but
		this behaviour can easily be overridden by subclassing this class
		and overriding this method.
		"""
		methods = [Express()]
		
		methods.extend(list(models.WeightBased.objects.all()))
		
		return methods
		
	#def get_shipping_methods(self, user, basket, shipping_addr=None, **kwargs):
	#	methods = WeightBased.objects.all()
	#	return methods