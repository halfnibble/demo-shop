import string
import random

from django import forms
from django.conf import settings
from django.contrib.auth import forms as auth_forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.sites.models import get_current_site
from django.core.exceptions import ValidationError
from django.utils.http import is_safe_url
from django.utils.translation import ugettext_lazy as _
from django.utils.translation import pgettext_lazy

from oscar.core.loading import get_profile_class, get_class, get_model
from oscar.core.compat import get_user_model, existing_user_fields
from oscar.apps.customer.utils import get_password_reset_url, normalise_email
from oscar.core.validators import password_validators


Dispatcher = get_class('customer.utils', 'Dispatcher')
CommunicationEventType = get_model('customer', 'communicationeventtype')
ProductAlert = get_model('customer', 'ProductAlert')
User = get_user_model()

# My imports
from oscar.apps.customer import forms as customer_forms

class EmailUserCreationForm(customer_forms.EmailUserCreationForm):
	first_name = forms.CharField(label=_("First name"))
	last_name = forms.CharField(label=_("First name"))
	
from oscar.apps.customer.forms import *  # noqa