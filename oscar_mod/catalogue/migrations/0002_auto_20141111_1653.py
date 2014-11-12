# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('catalogue', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='ProductActivity',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Product Activity')),
                ('slug', models.SlugField(default=b'slug-1')),
            ],
            options={
                'verbose_name_plural': 'Product Activities',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='ProductBrand',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Product Brand')),
                ('slug', models.SlugField(default=b'slug-1')),
            ],
            options={
                'verbose_name_plural': 'Product Brands',
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='product',
            name='activity',
            field=models.ForeignKey(blank=True, to='catalogue.ProductActivity', null=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='product',
            name='brand',
            field=models.ForeignKey(blank=True, to='catalogue.ProductBrand', null=True),
            preserve_default=True,
        ),
    ]
