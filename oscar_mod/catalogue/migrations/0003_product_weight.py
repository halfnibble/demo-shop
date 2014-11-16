# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('catalogue', '0002_auto_20141111_1653'),
    ]

    operations = [
        migrations.AddField(
            model_name='product',
            name='weight',
            field=models.DecimalField(default=0.0, verbose_name=b'Ship Weight', max_digits=10, decimal_places=3),
            preserve_default=True,
        ),
    ]
