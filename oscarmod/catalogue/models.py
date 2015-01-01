from django.db import models
from decimal import Decimal as D

from oscar.apps.catalogue.abstract_models import AbstractProduct

class ProductBrand(models.Model):
    name = models.CharField("Product Brand", max_length=128)
    slug = models.SlugField(unique=False,default="slug-1")
    
    class Meta:
        verbose_name_plural = "Product Brands"

    def __str__(self):
        return self.name

class ProductActivity(models.Model):
    name = models.CharField("Product Activity", max_length=128)
    slug = models.SlugField(unique=False,default="slug-1")

    class Meta:
        verbose_name_plural = "Product Activities"

    def __str__(self):
        return self.name

class Product(AbstractProduct):
    brand = models.ForeignKey('catalogue.ProductBrand',blank=True,null=True)
    activity = models.ForeignKey('catalogue.ProductActivity',blank=True,null=True)
    """
    For now, must modify weight via attribute set.
    weight = models.DecimalField("Ship Weight",default=0.000,
        max_digits=10,decimal_places=3)
    """

from oscar.apps.catalogue.models import *