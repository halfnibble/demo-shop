from collections import namedtuple
from decimal import Decimal as D

from oscar.apps.partner import prices, strategy

PurchaseInfo = namedtuple(
    'PurchaseInfo', ['price', 'availability', 'stockrecord'])

# Override NoTax to add merchant tier pricing
class ResellerPrice(object):
    """
    Pricing policy mixin for use with the ``Structured`` base strategy.
    This mixin will give reseller pricing to reseller users.
    """
    def set_excl_tax(self, stockrecord):
        # Modify for multiple tiers:
        if self.user.tier > 0 and stockrecord.price_reseller:
            return stockrecord.price_reseller
        
        return stockrecord.price_excl_tax

    def pricing_policy(self, product, stockrecord, tier=0):
        # Check stockrecord has the appropriate data
        if not stockrecord or stockrecord.price_excl_tax is None:
            return prices.Unavailable()
        
        return prices.FixedPrice(
            currency=stockrecord.price_currency,
            excl_tax=self.set_excl_tax(stockrecord),
            tax=D('0.00'))

    def parent_pricing_policy(self, product, children_stock, tier=0):
        stockrecords = [x[1] for x in children_stock if x[1] is not None]
        if not stockrecords:
            return prices.Unavailable()
        # We take price from first record
        stockrecord = stockrecords[0]
        return prices.FixedPrice(
            currency=stockrecord.price_currency,
            excl_tax=self.set_excl_tax(stockrecord),
            tax=D('0.00'))


# Default with reseller pricing options
class ResellerStrategy(strategy.UseFirstStockRecord, strategy.StockRequired,
    ResellerPrice, strategy.Structured):
    """
    Based on Default pricing stategy, but modified to allow 
    different prices to be displayed for resellers
    """
    

class Selector(object):

    def strategy(self, request=None, user=None, **kwargs):
        if user and hasattr(user, 'tier'):
            return ResellerStrategy(request)
        else:
            return strategy.Default(request)

"""
NOTE.
You must modify the checkout process to calculate incl_tax
before using the US strategy

"""