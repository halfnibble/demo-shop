# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0002_auto_20141217_1905'),
    ]

    operations = [
        migrations.AlterField(
            model_name='importrecord',
            name='quantity',
            field=models.PositiveIntegerField(null=True, verbose_name='Quantity imported', blank=True),
            preserve_default=True,
        ),
    ]
