from decimal import Decimal
from django.db import models
from django.utils.translation import ugettext_lazy as _, pgettext_lazy

from oscar.core.utils import get_default_currency
from settings import AUTH_USER_MODEL
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
	product = models.ForeignKey(Product, related_name='stockrecords',
		verbose_name=_('Product'))
	# pending...
	# sku = models.CharField(_('Our SKU'), max_length=128)
	partner_sku = models.CharField(_('Partner SKU'), max_length=128)
	origin_currency = models.CharField(_('Origin currency code'), max_length=12, default='EUR')
	standard_export_price = models.DecimalField(_('Price in origin currency.'))
	partner_discount = models.DecimalField(
		_('Partner discount'), decimal_places=3, max_digits=6, default=0.000)
	
	@property
	def export_price(self):
		price = Decimal( self.standard_export_price * (1.000 - self.partner_discount) )
		return round(price, 2)
	
	currency_factor = models.DecimalField(
		_('Currency conversion'), decimal_places=3, max_digits=6, default=1.000)
	
	@property
	def import_price(self):
		price = Decimal( self.export_price * currency_factor )
		return round(price, 2)
	
	# Use these to update the related Tariff entry if update_tariff is set.
	tariff_code = models.CharField(_('Tariff code'), max_length=128)
	tariff_rate = models.DecimalField(
		_('Tariff rate'), decimal_places=3, max_digits=6, default=0.000)
	
	@property
	def tariff(self):
		cost = Decimal( self.import_price * (tariff_rate / 100.000) )
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
		else if self._shipping_cost is not None:
			return self._shipping_cost
		else:
			return Decimal(0.00)
	@shipping_cost.setter
	def shipping_cost(self, value):
		self._shipping_cost = value
		
	
	# Update related StockRecord if update_prices is set.
	cost_price = models.DecimalField(
		_('COGS (fully landed)'), decimal_places=2, max_digits=12, blank=True, null=True)
	
	origin_msrp = models.DecimalField(
		_('Origin MSRP'), decimal_places=2, max_digits=12, blank=True, null=True)
	msrp = models.DecimalField(
		_('MSRP in USD'), decimal_places=2, max_digits=12, blank=True, null=True)
	target_wholesale_gpm = models.DecimalField(
		_('Target wholesale GPM'), decimal_places=3, max_digits=6, blank=True, null=True)
	target_retail_factor = models.DecimalField(
		_('Target retail factor'), decimal_places=3, max_digits=6, blank=True, null=True)
	
	# Update related StockRecord if update_prices is set
	price_reseller = models.DecimalField(
		_('Final wholesale price'), decimal_places=2, max_digits=12, blank=True, null=True)
	price_retail = models.DecimalField(
		_('Final MSRP'), decimal_places=2, max_digits=12, blank=True, null=True)
		# Use for price_excl_tax field
	

	


