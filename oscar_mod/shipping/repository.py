from decimal import Decimal as D
from oscar.apps.shipping import repository, methods, models
from oscar.core import prices

class Overnight(methods.Base):
	code = "overnight-shipping"
	name = "USPS Priority Mail"
	def get_charge(self):
		return D('24.90')
	
	def calculate(self, basket):
		charge = self.get_charge()
		return prices.Price(
			currency=basket.currency,
			excl_tax=charge,
			incl_tax=charge)
	
class Repository(repository.Repository):
	"""
	Repository class responsible for returning ShippingMethod
	objects for a given user, basket etc
	"""

	def get_available_shipping_methods(self, basket, user=None, shipping_addr=None, request=None, **kwargs):
		"""
		Return weight-based shipping methods and Overnight shipping.
		"""
		
		methods = list(models.WeightBased.objects.all())
		methods.extend([ Overnight(), ])
		
		return methods
