from datetime import datetime
from decimal import Decimal as D
from math import ceil
from django.db import models
from django.utils.translation import ugettext_lazy as _, pgettext_lazy
from django.core.urlresolvers import reverse

from oscar.core.utils import get_default_currency
from demoshop.settings import AUTH_USER_MODEL
from oscar.apps.partner.exceptions import InvalidStockAdjustment

from oscarmod.catalogue.models import Product
from oscarmod.partner.models import StockRecord

"""
Utility money (M) and rate (R) format functions
"""
def M(value):
    return D('{0:.2f}'.format(D(value)))

def R(value):
    return D('{0:.3f}'.format(D(value)))


class Tariff(models.Model):
    """
    Global Tariff table useful for predicting future expenses.
    Can be updated when an ImportRecord is created.
    """
    code = models.CharField(_('Tariff code'), max_length=128, primary_key=True)
    rate = models.DecimalField(
        _('Tariff rate'), decimal_places=3, max_digits=6, default=0.000)
    updated = models.DateTimeField(_('Last modified'), auto_now=True)
    
    def apply(self, original_amount):
        taxed_amount = (
            M(original_amount) * (D('1.000') + R(self.rate) / D('100.000'))
        )
        return M(taxed_amount)
    
    def __unicode__(self):
        return u'No. %s, Rt. %s%%' % (self.code, self.rate)

    def get_absolute_url(self):
        """
        Show Tariff list on form submit
        """
        return reverse('dashboard:tariff_list', kwargs={})
        
    class Meta:
        verbose_name = _('Tariff')
        verbose_name_plural = _('Tariffs')


class ImportRecord(models.Model):
    """
    Product Import Details.
    """
    imported_date = models.DateTimeField(
        _('Date imported'), default=datetime.now)
    product = models.ForeignKey(Product, verbose_name=_('Product'))
    # pending...
    # sku = models.CharField(_('Our SKU'), max_length=128)
    partner_sku = models.CharField(_('Partner SKU'), max_length=128)
    quantity = models.PositiveIntegerField(
        _("Quantity imported"), blank=True, null=True)
    
    """
    Pricing and ERP data.
    """
    origin_currency = models.CharField(
        _('Origin currency code'), max_length=12, default='EUR')
    standard_export_price = models.DecimalField(
        _('Price in origin currency.'), decimal_places=2,
        max_digits=12, blank=True, null=True)
    partner_discount = models.DecimalField(
        _('Partner discount'), decimal_places=3, max_digits=6, default=0.000)
    
    @property
    def export_price(self):
        price = (
            M(self.standard_export_price) *
            (D('1.000') - R(self.partner_discount) / D('100.000'))
        )
        return M(price)
    
    currency_factor = models.DecimalField(
        _('Currency conversion'), decimal_places=3, max_digits=6, default=1.000)
    
    @property
    def import_price(self):
        price = M(self.export_price) * R(self.currency_factor)
        return M(price)
    
    # Use these to update the related Tariff entry if update_tariff is set.
    tariff_code = models.CharField(_('Tariff code'), max_length=128)
    tariff_rate = models.DecimalField(
        _('Tariff rate'), decimal_places=3, max_digits=6, default=0.000)

    related_tariff = models.ForeignKey(Tariff, null=True, blank=True,
        verbose_name=_('Related Tariff'))
    
    @property
    def tariff(self):
        cost = M(self.import_price) * (R(self.tariff_rate) / D('100.000'))
        return M(cost)
    
    # Update related ProductAttribute if update_weight is set.
    shipping_weight = models.FloatField(
        _('Shipping weight'), blank=True, null=True)
    
    shipping_factor = models.DecimalField(
        _('Shipping Factor'), decimal_places=3, max_digits=6,
        blank=True, null=True)
    
    _shipping_cost = models.DecimalField(
        _('Shipping expense'), decimal_places=2, max_digits=12,
        blank=True, null=True)

    @property
    def shipping_cost(self):
        if self._shipping_cost is not None:
            return M(self._shipping_cost)
        elif self.shipping_weight != None and self.shipping_factor != None:
            return M(R(self.shipping_weight) * R(self.shipping_factor))
        else:
            return M('0.00')
    
    @property
    def import_cost(self):
        cost = M(self.tariff) + M(self.shipping_cost)
        return cost
    
    # Update related StockRecord if update_prices is set.
    @property
    def cost_price(self):
        cost = M(self.import_price) + M(self.tariff) + M(self.shipping_cost)
        return cost
    
    origin_msrp = models.DecimalField(
        _('Origin MSRP'), decimal_places=2, max_digits=12,
        blank=True, null=True)
    
    @property
    def msrp(self):
        price = M(self.origin_msrp) * R(self.currency_factor)
        return M(price)
    
    target_wholesale_gpm = models.DecimalField(
        _('Target wholesale GPM'), decimal_places=3, max_digits=6,
        blank=True, null=True)
    
    @property
    def target_wholesale_price(self):
        price = (
            M(self.cost_price) *
            (D('100.000') + R(self.target_wholesale_gpm)) / D('100.000')
        )
        return M(price)
    
    @property
    def implied_retail_factor(self):
        factor = M(self.msrp) / M(self.target_wholesale_price)
        return M(factor)
        
    target_retail_factor = models.DecimalField(
        _('Target retail factor'), decimal_places=2, max_digits=6,
        blank=True, null=True)
    
    @property
    def implied_msrp(self):
        price = M(self.target_wholesale_price) * R(self.target_retail_factor)
        return M(price)
    
    @property
    def msrp_delta(self):
        price = M(self.implied_msrp) - M(self.msrp)
        return price
    
    @property
    def msrp_markup(self):
        rate = M(self.msrp_delta) / M(self.msrp) * D('100.000')
        return R(rate) 
    
    # Update related StockRecord if update_prices is set
    """
    Wholesale pricing & profit data.
    """
    _price_reseller = models.DecimalField(
        _('Final wholesale price'), decimal_places=2, max_digits=12,
        blank=True, null=True)

    @property
    def price_reseller(self):
        if self._price_reseller is not None:
            return M(self._price_reseller)
        else:
            # Round up to nearest tenth
            price =  D(
                ceil( M(self.target_wholesale_price) * D('10.00') )
            ) / D('10.00')
            return M(price)
    
    @property
    def wholesale_profit(self):
        price = M(self.price_reseller) - M(self.cost_price)
        return price
    
    @property
    def wholesale_gpm(self):
        rate = M(self.wholesale_profit) / M(self.cost_price) * D('100.000')
        return R(rate)
        
    """
    Retail pricing & profit data.
    """
    _price_retail = models.DecimalField(
        _('Final MSRP'), decimal_places=2, max_digits=12,
        blank=True, null=True)
        # Use for price_excl_tax field

    @property
    def price_retail(self):
        if self._price_retail is not None:
            return M(self._price_retail)
        else:
            # Round up to nearest tenth
            price =  M(ceil(self.implied_msrp)) - M('0.01')
            return price
    
    @property
    def retail_profit(self):
        profit = M(self.price_retail) - M(self.cost_price)
        return profit
    
    @property
    def retail_gpm(self):
        rate = M(self.retail_profit) / M(self.cost_price) * R('100.000')
        return R(rate)
    
    """
    Reseller's dataset.
    """
    @property
    def reseller_profit(self):
        profit = M(self.price_retail) - M(self.price_reseller)
        return profit
    
    @property
    def reseller_gpm(self):
        rate = M(self.reseller_profit) / M(self.price_reseller) * R('100.000')
        return R(rate)

    def __unicode__(self):
        return u"""
            Product: %s, MSRP: $%s, Retail: $%s, Wholesale: $%s, 
            Retail profit: $%s, Wholesale profit: $%s, 
            Retail GPM: %s%%, Wholesale GPM: %s%%, 
            Reseller profit: $%s, Reseller GPM: %s%%.
            """ % (
            self.partner_sku, self.msrp, self.price_retail, self.price_reseller,
            self.retail_profit, self.wholesale_profit,
            self.retail_gpm, self.wholesale_gpm,
            self.reseller_profit, self.reseller_gpm)
        
    def get_absolute_url(self):
        """
        This needs to be modified to show detail instead.
        """
        return reverse('dashboard:record_list',
            kwargs={'parent_pk': self.product.parent.pk})

