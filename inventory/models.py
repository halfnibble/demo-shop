from decimal import Decimal
from math import ceil
from django.db import models
from django.utils.translation import ugettext_lazy as _, pgettext_lazy

from oscar.core.utils import get_default_currency
from giggearme.settings import AUTH_USER_MODEL
from oscar.apps.partner.exceptions import InvalidStockAdjustment

from oscarmod.catalogue.models import Product
from oscarmod.partner.models import StockRecord


class Tariff(models.Model):
	"""
	Global Tariff table useful for predicting future expenses.
	Can be updated when an ImportRecord is created.
	"""
	code = models.CharField(_('Tariff code'), max_length=128)
	rate = models.DecimalField(
		_('Tariff rate'), decimal_places=3, max_digits=6, default=0.000)
	updated = models.DateTimeField(_('Last modified'), auto_now=True)
	
	def apply(self, original_amount):
		taxed_amount = Decimal( original_amount * (1.000 + (self.rate / 100.000)) )
		return round(taxed_amount,2)
	
	def __str__(self):
		return u'Tariff No. %s, rate: %s%.' % (self.code, self.rate)
		
	class Meta:
		verbose_name = _('Tariff')
		verbose_name_plural = _('Tariffs')


class ImportRecord(models.Model):
	product = models.ForeignKey(Product, verbose_name=_('Product'))
	# pending...
	# sku = models.CharField(_('Our SKU'), max_length=128)
	partner_sku = models.CharField(_('Partner SKU'), max_length=128)
	origin_currency = models.CharField(_('Origin currency code'), max_length=12, default='EUR')
	standard_export_price = models.DecimalField(
		_('Price in origin currency.'), decimal_places=2, max_digits=12, blank=True, null=True)
	partner_discount = models.DecimalField(
		_('Partner discount'), decimal_places=3, max_digits=6, default=0.000)
	
	@property
	def export_price(self):
		price = Decimal( self.standard_export_price * (1.000 - (self.partner_discount / 100.000)) )
		return round(price, 2)
	
	currency_factor = models.DecimalField(
		_('Currency conversion'), decimal_places=3, max_digits=6, default=1.000)
	
	@property
	def import_price(self):
		price = Decimal( self.export_price * self.currency_factor )
		return round(price, 2)
	
	# Use these to update the related Tariff entry if update_tariff is set.
	tariff_code = models.CharField(_('Tariff code'), max_length=128)
	tariff_rate = models.DecimalField(
		_('Tariff rate'), decimal_places=3, max_digits=6, default=0.000)
	
	@property
	def tariff(self):
		cost = Decimal( self.import_price * (self.tariff_rate / 100.000) )
		return round(cost, 2)
	
	# Update related ProductAttribute if update_weight is set.
	shipping_weight = models.FloatField(_('Float'), blank=True, null=True)
	
	shipping_factor = models.DecimalField(
		_('Shipping Factor'), decimal_places=3, max_digits=6, blank=True, null=True)
	
	_shipping_cost = models.DecimalField(
		_('Shipping expense'), decimal_places=2, max_digits=12, blank=True, null=True)
	@property
	def shipping_cost(self):
		if self.shipping_weight is not None and self.shipping_factor is not None:
			return round( Decimal(self.shipping_weight * self.shipping_factor), 2 )
		elif self._shipping_cost is not None:
			return self._shipping_cost
		else:
			return Decimal(0.00)
	@shipping_cost.setter
	def shipping_cost(self, value):
		self._shipping_cost = value
	
	@property
	def import_cost(self):
		cost = Decimal( self.tariff + self.shipping_cost )
		return round(cost, 2)
	
	# Update related StockRecord if update_prices is set.
	@property
	def cost_price(self):
		cost = Decimal( self.import_price + self.tariff + self.shipping_cost )
		return round(cost, 2)
	
	origin_msrp = models.DecimalField(
		_('Origin MSRP'), decimal_places=2, max_digits=12, blank=True, null=True)
	"""
	DELETE: After verification
	msrp = models.DecimalField(
		_('MSRP in USD'), decimal_places=2, max_digits=12, blank=True, null=True)
	"""
	@property
	def msrp(self):
		price = Decimal( self.origin_msrp * self.currency_factor )
		return round(price, 2)
	
	target_wholesale_gpm = models.DecimalField(
		_('Target wholesale GPM'), decimal_places=3, max_digits=6, blank=True, null=True)
	
	@property
	def target_wholesale_price(self):
		price = Decimal( self.cost_price * ( 100.000 + self.target_wholesale_gpm) / 100.000 )
		return round(price, 2)
	
	@property
	def implied_retail_factor(self):
		factor = Decimal( self.msrp / self.target_wholesale_price )
		return round(factor, 3)
		
	target_retail_factor = models.DecimalField(
		_('Target retail factor'), decimal_places=3, max_digits=6, blank=True, null=True)
	
	@property
	def implied_msrp(self):
		price = Decimal( self.target_wholesale_price * self.target_retail_factor )
		return round(price, 2)
	
	@property
	def msrp_delta(self):
		return Decimal( self.implied_msrp - self.msrp )
	
	@property
	def msrp_markup(self):
		rate = Decimal( (self.msrp_delta / self.msrp) * 100.000 )
		return round(rate, 3)	
	
	# Update related StockRecord if update_prices is set
	"""
	Wholesale pricing & profit data.
	"""
	_price_reseller = models.DecimalField(
		_('Final wholesale price'), decimal_places=2, max_digits=12, blank=True, null=True)
	@property
	def price_reseller(self):
		if self._price_reseller is not None:
			return self._price_reseller
		else:
			# Round up to nearest tenth
			price =  Decimal( ceil(self.target_wholesale_price * 10.00) / 10.00 )
			return round(price, 2)
	@price_reseller.setter
	def price_reseller(self, value):
		self._price_reseller = value
	
	@property
	def wholesale_profit(self):
		return Decimal( self.price_reseller - self.cost_price )
	
	@property
	def wholesale_gpm(self):
		rate = Decimal( (self.wholesale_profit / self.cost_price) * 100.000 )
		return round(rate, 3)
		
	"""
	Retail pricing & profit data.
	"""
	_price_retail = models.DecimalField(
		_('Final MSRP'), decimal_places=2, max_digits=12, blank=True, null=True)
		# Use for price_excl_tax field
	@property
	def price_retail(self):
		if self._price_retail is not None:
			return self._price_retail
		else:
			# Round up to nearest tenth
			price =  Decimal( ceil(self.implied_msrp) - 0.01 )
			return round(price, 2)
	@price_retail.setter
	def price_retail(self, value):
		self._price_retail = value
	
	@property
	def retail_profit(self):
		return Decimal( self.price_retail - self.cost_price )
	
	@property
	def retail_gpm(self):
		rate = Decimal( (self.retail_profit / self.cost_price) * 100.000 )
		return round(rate, 3)
	
	"""
	Reseller's dataset.
	"""
	@property
	def reseller_profit(self):
		return Decimal( self.price_retail - self.price_reseller )
	
	@property
	def reseller_gpm(self):
		rate = Decimal( (self.reseller_profit / self.price_reseller) * 100.000 )
		return round(rate, 3)
	
	def __str__(self):
		return u('Product: %s, MSRP: $%s, Retail: $%s, Wholesale: $%s, '
			'Retail profit: $%s, Wholesale profit: $%s, '
			'Retail GPM: %s%, Wholesale GPM: %s%, '
			'Reseller profit: $%s, Reseller GPM: %s%.') % (
			self.partner_sku, self.msrp, self.price_retail, self.price_reseller,
			self.retail_profit, self.wholesale_profit,
			self.retail_gpm, self.wholesale_gpm,
			self.reseller_profit, self.reseller_gpm)

	
