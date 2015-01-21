from django.utils.translation import ugettext_lazy as _

from oscar.core.loading import get_class
ReportGenerator = get_class('dashboard.reports.reports', 'ReportGenerator')
ReportCSVFormatter = get_class('dashboard.reports.reports',
                               'ReportCSVFormatter')
ReportHTMLFormatter = get_class('dashboard.reports.reports',
                                'ReportHTMLFormatter')


class ImportReportHTMLFormatter(ReportHTMLFormatter):
    filename_template = 'inventory/reports/import_records_report.html'


class ImportReportGenerator(ReportGenerator):
    code = 'import-records'
    description = _('Product Import Costs')

    formatters = {
        'HTML_formatter': ImportReportHTMLFormatter,
    }

    def generate(self):
        # Make the GET object easier to access
        params = self.request.GET

        """
        Override the generate() method to create report content based on the
        various GET params available for the custom form.
        """
        if params.get('test_feature') == 'yes':
            import_records = {
                'record 1': {
                    'parent_pk': 242,
                    'pk': 20,
                    'price': 'IT',
                    'profit': 'WORKS'
                },
                'record 2': {
                    'parent_pk': 242,
                    'pk': 19,
                    'price': 'IT',
                    'profit': 'WORkS'
                }
            }
        else:
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
