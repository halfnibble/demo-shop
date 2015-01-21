from django import forms
from django.utils.translation import ugettext_lazy as _

from oscar.apps.dashboard.reports.forms import ReportForm as OriginalReportForm

class ReportForm(OriginalReportForm):
    """Just making the date range optional."""
    date_from = forms.DateField(label=_("Date from"), required=False)
    date_to = forms.DateField(label=_("Date to"),
        help_text=_("The report is inclusive of this"), required=False)
        