# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0004_auto_20141217_2350'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='tariff',
            name='id',
        ),
        migrations.AlterField(
            model_name='tariff',
            name='code',
            field=models.CharField(max_length=128, serialize=False, verbose_name='Tariff code', primary_key=True),
            preserve_default=True,
        ),
    ]
