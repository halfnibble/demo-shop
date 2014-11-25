from decimal import Decimal as D
from oscar.apps.shipping import repository, methods, models
from oscar.core import prices

from usermod.models import UserTier

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
	
class TierOne(methods.Base):
	code = "tier_1"
	name = "Merchant Tier 1 Express"
	def get_charge(self):
		return D('8.50')
	
	def calculate(self, basket):
		charge = self.get_charge()
		return prices.Price(
			currency=basket.currency,
			excl_tax=charge,
			incl_tax=charge)

class TierTwo(methods.Base):
	code = "tier_2"
	name = "Merchant Tier 2 Express"
	def get_charge(self):
		return D('0.00')
	
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
		# For Users in Merchant Tiers
		if user is not None and user.tier:
			level_1 = UserTier.objects.get(pk=1)
			level_2 = UserTier.objects.get(pk=1)
			if user.tier == level_1:
				methods = [ TierOne(), ]
			elif user.tier == level_2:
				methods = [ TierTwo(), ]
			else:
				methods = [ Overnight(), ]
		# For Regular Users:	
		else:
			methods = list(models.WeightBased.objects.all())
			methods.extend([ Overnight(), ])
		
		return methods
