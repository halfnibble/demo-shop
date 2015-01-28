from django import forms
from django.shortcuts import get_object_or_404
from django.db.models import Q

from apps.catalogue.models import Product
from .models import ImportRecord

class ImportRecordForm(forms.ModelForm):
    def __init__(self, variants, *args, **kwargs):
        super(ImportRecordForm, self).__init__(*args, **kwargs)
        self.fields['product'].queryset = variants
    
    class Meta:
        model = ImportRecord
        exclude = ()
    
