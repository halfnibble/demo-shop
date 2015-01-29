from decimal import Decimal as D

from django.core.exceptions import ValidationError

from oscar.apps.partner.models import Partner, StockRecord
from apps.catalogue.models import Product
from apps.dashboard.inventory.models import Tariff


def update_catalogue_pricing(product, cost_price, price_retail, price_reseller):
    """
    Utility function to update the Oscar Catalog price fields
    for a selected Product.
    """
    if product.structure == 'parent':
        variants = Product.objects.filter(parent=product)
        records = StockRecord.objects.filter(product__in=variants)
    else:
        records = StockRecord.objects.filter(product=product)

    number_of_records = records.count()

    if number_of_records < 1:
        create_stockrecord(product, cost_price, price_retail, price_reseller,
            quantity=0)
    else:
        for record in records:
            record.cost_price = cost_price
            record.price_retail = price_retail
            record.price_excl_tax = price_retail # Same for our purposes
            record.price_reseller = price_reseller
            record.save()

def update_product_stock(product, quantity=0):
    """
    Utility function to update a product's available stock 
    based on an import record.
    """
    if product.structure == 'parent':
        raise ValidationError(
            "Cannot set stock quantities for 'parent' products.")




def udate_tariff_rate(tariff, rate=0.000):
    """
    Utility function to update a Tariff record rate.
    """


def create_stockrecord(product, cost_price, price_retail, price_reseller,
    quantity=0):
    pass