# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0005_auto_20150114_2017'),
    ]

    operations = [
        migrations.AddField(
            model_name='importrecord',
            name='related_tariff',
            field=models.ForeignKey(verbose_name='Related Tariff', blank=True, to='inventory.Tariff', null=True),
            preserve_default=True,
        ),
    ]
