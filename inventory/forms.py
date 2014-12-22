from django import forms

from .models import ImportRecord

class ImportRecordForm(forms.ModelForm):
    class Meta:
        model = ImportRecord
        exclude = ()
    
