from django import forms
from django.shortcuts import get_object_or_404

from oscarmod.catalogue.models import Product
from .models import ImportRecord

class ImportRecordForm(forms.ModelForm):
    def __init__(self, parent, *args, **kwargs):
        super(ImportRecordForm, self).__init__(*args, **kwargs)
        self.fields['product'].queryset = parent.children.all()
    
    class Meta:
        model = ImportRecord
        exclude = ()
    
