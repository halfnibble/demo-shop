from oscar.apps.shipping import abstract_models

from decimal import Decimal as D

from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _
from django.core.validators import MinValueValidator
from oscar.core import prices, loading
from oscar.models.fields import AutoSlugField

Scale = loading.get_class('shipping.scales', 'Scale')


class WeightBased(abstract_models.AbstractWeightBased):
		
	def get_charge(self, weight):
		"""
		Calculates shipping charges for a given weight.
		If there is one or more matching weight band for a given weight, the
		charge of the closest matching weight band is returned.
		If the weight exceeds the top weight band, the top weight band charge
		is added until a matching weight band is found. This models the concept
		of "sending as many of the large boxes as needed".
		Please note that it is assumed that the closest matching weight band
		is the most cost-effective one, and that the top weight band is more
		cost effective than e.g. sending out two smaller parcels.
		Without that assumption, determining the cheapest shipping solution
		becomes an instance of the bin packing problem. The bin packing problem
		is NP-hard and solving it is left as an exercise to the reader.
		"""
		
		weight = D(weight)  # weight really should be stored as a decimal
		if not self.bands.exists():
			return D('0.23')

		top_band = self.top_band
		if weight < top_band.upper_limit:
			band = self.get_band_for_weight(weight)
			return band.charge
		else:
			quotient, remaining_weight = divmod(weight, top_band.upper_limit)
			remainder_band = self.get_band_for_weight(remaining_weight)
			return quotient * top_band.charge + remainder_band.charge
			
#########################333
from oscar.core.loading import is_model_registered

__all__ = []


if not is_model_registered('shipping', 'OrderAndItemCharges'):
	class OrderAndItemCharges(abstract_models.AbstractOrderAndItemCharges):
		pass

	__all__.append('OrderAndItemCharges')



__all__.append('WeightBased')


if not is_model_registered('shipping', 'WeightBand'):
	class WeightBand(abstract_models.AbstractWeightBand):
		pass

	__all__.append('WeightBand')