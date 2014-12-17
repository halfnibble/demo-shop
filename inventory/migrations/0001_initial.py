# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('catalogue', '0002_auto_20141111_1653'),
    ]

    operations = [
        migrations.CreateModel(
            name='ImportRecord',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('partner_sku', models.CharField(max_length=128, verbose_name='Partner SKU')),
                ('origin_currency', models.CharField(default=b'EUR', max_length=12, verbose_name='Origin currency code')),
                ('standard_export_price', models.DecimalField(null=True, verbose_name='Price in origin currency.', max_digits=12, decimal_places=2, blank=True)),
                ('partner_discount', models.DecimalField(default=0.0, verbose_name='Partner discount', max_digits=6, decimal_places=3)),
                ('currency_factor', models.DecimalField(default=1.0, verbose_name='Currency conversion', max_digits=6, decimal_places=3)),
                ('tariff_code', models.CharField(max_length=128, verbose_name='Tariff code')),
                ('tariff_rate', models.DecimalField(default=0.0, verbose_name='Tariff rate', max_digits=6, decimal_places=3)),
                ('shipping_weight', models.FloatField(null=True, verbose_name='Float', blank=True)),
                ('shipping_factor', models.DecimalField(null=True, verbose_name='Shipping Factor', max_digits=6, decimal_places=3, blank=True)),
                ('_shipping_cost', models.DecimalField(null=True, verbose_name='Shipping expense', max_digits=12, decimal_places=2, blank=True)),
                ('origin_msrp', models.DecimalField(null=True, verbose_name='Origin MSRP', max_digits=12, decimal_places=2, blank=True)),
                ('target_wholesale_gpm', models.DecimalField(null=True, verbose_name='Target wholesale GPM', max_digits=6, decimal_places=3, blank=True)),
                ('target_retail_factor', models.DecimalField(null=True, verbose_name='Target retail factor', max_digits=6, decimal_places=3, blank=True)),
                ('_price_reseller', models.DecimalField(null=True, verbose_name='Final wholesale price', max_digits=12, decimal_places=2, blank=True)),
                ('_price_retail', models.DecimalField(null=True, verbose_name='Final MSRP', max_digits=12, decimal_places=2, blank=True)),
                ('product', models.ForeignKey(verbose_name='Product', to='catalogue.Product')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Tariff',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('code', models.CharField(max_length=128, verbose_name='Tariff code')),
                ('rate', models.DecimalField(default=0.0, verbose_name='Tariff rate', max_digits=6, decimal_places=3)),
                ('updated', models.DateTimeField(auto_now=True, verbose_name='Last modified')),
            ],
            options={
                'verbose_name': 'Tariff',
                'verbose_name_plural': 'Tariffs',
            },
            bases=(models.Model,),
        ),
    ]
