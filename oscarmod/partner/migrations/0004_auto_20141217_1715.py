# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('partner', '0003_stockrecord_price_reseller'),
    ]

    operations = [
        migrations.AlterField(
            model_name='stockrecord',
            name='price_reseller',
            field=models.DecimalField(null=True, verbose_name='Wholesale Price', max_digits=12, decimal_places=2, blank=True),
            preserve_default=True,
        ),
    ]
