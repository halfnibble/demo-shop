# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0003_auto_20141217_1910'),
    ]

    operations = [
        migrations.AlterField(
            model_name='importrecord',
            name='shipping_weight',
            field=models.FloatField(null=True, verbose_name='Shipping weight', blank=True),
            preserve_default=True,
        ),
    ]
