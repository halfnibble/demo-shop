from oscar.apps.customer.forms import *  # noqa
from django.utils.translation import ugettext_lazy as _

class EmailUserCreationForm(EmailUserCreationForm):
    first_name = forms.CharField(label=_("First name"))
    last_name = forms.CharField(label=_("Last name"))
    
    class Meta:
        model = User
        fields = ['first_name','last_name','email',]