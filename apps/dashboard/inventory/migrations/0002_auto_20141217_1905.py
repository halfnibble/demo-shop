# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='importrecord',
            name='imported_date',
            field=models.DateTimeField(default=datetime.datetime.now, verbose_name='Date imported'),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='importrecord',
            name='quantity',
            field=models.PositiveIntegerField(null=True, verbose_name='Number in stock', blank=True),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='importrecord',
            name='target_retail_factor',
            field=models.DecimalField(null=True, verbose_name='Target retail factor', max_digits=6, decimal_places=2, blank=True),
            preserve_default=True,
        ),
    ]
