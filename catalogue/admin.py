from django.contrib import admin
from .models import ProductBrand, ProductActivity, Product
# Keep Oscar Admin integrity
import oscar.apps.catalogue.admin



admin.site.register(ProductBrand)
admin.site.register(ProductActivity)
