from decimal import Decimal as D
from oscar.apps.shipping import methods, models
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
    
"""
Merchant User Tiers
TierOne
TierTwo
"""
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
    