from decimal import Decimal as D

from apps.catalogue.models import Product
from oscar.apps.partner.models import StockRecord
from apps.dashboard.inventory.models import Tariff


def update_catalogue_pricing():
    """
    Utility function to update the Oscar Catalog price fields
    for a selected Product.
    """

def update_product_stock(product, quantity=0):
    """
    Utility function to update a product's available stock 
    based on an import record.
    """

def udate_tariff_rate(tariff, rate=0.000):
    """
    Utility function to update a Tariff record rate.
    """
