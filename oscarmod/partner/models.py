from django.db import models
from django.utils.translation import ugettext_lazy as _
from oscar.apps.partner.abstract_models import AbstractStockRecord

class StockRecord(AbstractStockRecord):
	price_reseller = models.DecimalField(
		_("Wholesale Price"), decimal_places=2, max_digits=12,
		blank=True, null=True)


from oscar.apps.partner.models import *  # noqa
