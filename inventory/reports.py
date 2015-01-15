from django.utils.translation import ugettext_lazy as _

from oscar.core.loading import get_class
ReportGenerator = get_class('dashboard.reports.reports', 'ReportGenerator')
ReportCSVFormatter = get_class('dashboard.reports.reports',
                               'ReportCSVFormatter')
ReportHTMLFormatter = get_class('dashboard.reports.reports',
                                'ReportHTMLFormatter')


class OfferReportHTMLFormatter(ReportHTMLFormatter):
    filename_template = 'inventory/reports/import_records_report.html'
    # 'dashboard/reports/partials/offer_report.html'


class ImportReportGenerator(ReportGenerator):
    code = 'import-records'
    description = _('Product import records')

    formatters = {
        'HTML_formatter': OfferReportHTMLFormatter,
    }

    def generate(self):
        import_records = {
            'record 1': {
                'parent_pk': 242,
                'pk': 20,
                'price': 'HIGH',
                'profit': 'HIGH'
            },
            'record 2': {
                'parent_pk': 242,
                'pk': 19,
                'price': 'LOW',
                'profit': 'LOW'
            }
        }

        return self.formatter.generate_response(import_records.values())