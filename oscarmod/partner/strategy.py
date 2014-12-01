from collections import namedtuple
from decimal import Decimal as D

from oscar.apps.partner import availability, prices, strategy

PurchaseInfo = namedtuple(
    'PurchaseInfo', ['price', 'availability', 'stockrecord'])

# Override NoTax to add merchant tier pricing
class NoTaxTier(object):
	"""
	Pricing policy mixin for use with the ``Structured`` base strategy.
	This mixin will give reseller pricing to reseller users.
	"""
	def set_excl_tax(self, stockrecord, tier=0):
		if tier > 0 and stockrecord.price_reseller:
			return stockrecord.price_reseller
		
		return stockrecord.price_excl_tax

	def pricing_policy(self, product, stockrecord, tier=0):
		# Check stockrecord has the appropriate data
		if not stockrecord or stockrecord.price_excl_tax is None:
			return prices.Unavailable()
		
		return prices.FixedPrice(
			currency=stockrecord.price_currency,
			excl_tax=self.set_excl_tax(stockrecord, tier),
			tax=D('0.00'))

	def parent_pricing_policy(self, product, children_stock, tier=0):
		stockrecords = [x[1] for x in children_stock if x[1] is not None]
		if not stockrecords:
			return prices.Unavailable()
		# We take price from first record
		stockrecord = stockrecords[0]
		return prices.FixedPrice(
			currency=stockrecord.price_currency,
			excl_tax=self.set_excl_tax(stockrecord, tier),
			tax=D('0.00'))

# Override Structured class to add merchant tier pricing
class StructuredTier(strategy.Structured):
	def fetch_for_product(self, product, stockrecord=None):
		"""
		Return the appropriate ``PurchaseInfo`` instance.
		This method is not intended to be overridden.
		"""
		if stockrecord is None:
			stockrecord = self.select_stockrecord(product)
		return PurchaseInfo(
			price=self.pricing_policy(product, stockrecord, self.user.tier),
			availability=self.availability_policy(product, stockrecord),
			stockrecord=stockrecord)

	def fetch_for_parent(self, product):
		# Select children and associated stockrecords
		children_stock = self.select_children_stockrecords(product)
		return PurchaseInfo(
			price=self.parent_pricing_policy(product, children_stock, self.user.tier),
			availability=self.parent_availability_policy(
				product, children_stock),
			stockrecord=None)

# Default with reseller pricing options
class PricedByUser(strategy.UseFirstStockRecord, strategy.StockRequired,
	NoTaxTier, StructuredTier):
	"""
	Based on Default pricing stategy, but modified to allow 
	different prices to be displayed for resellers
	"""
	


class Selector(object):

	def strategy(self, request=None, user=None, **kwargs):
		return PricedByUser(request)

"""
NOTE.
You must modify the checkout process to calculate incl_tax
before using the US strategy

"""