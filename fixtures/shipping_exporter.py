from django.core.serializers import serialize
from oscar_mod.shipping import models

with open('fixtures/weight_shipping.json', 'w') as out:
	weight_shipping_data = serialize('json', models.WeightBased.objects.all())
	out.write(weight_shipping_data)

with open('fixtures/weight_bands.json', 'w') as out:
	weight_bands_data = serialize('json', models.WeightBand.objects.all())
	out.write(weight_bands_data)




