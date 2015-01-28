# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('partner', '0002_auto_20141007_2032'),
    ]

    operations = [
        migrations.AddField(
            model_name='stockrecord',
            name='price_reseller',
            field=models.DecimalField(null=True, verbose_name='Reseller Price', max_digits=12, decimal_places=2, blank=True),
            preserve_default=True,
        ),
    ]
