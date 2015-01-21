from django.utils.translation import ugettext_lazy as _

from oscar.core.loading import get_class
ReportGenerator = get_class('dashboard.reports.reports', 'ReportGenerator')
ReportCSVFormatter = get_class('dashboard.reports.reports',
                               'ReportCSVFormatter')
ReportHTMLFormatter = get_class('dashboard.reports.reports',
                                'ReportHTMLFormatter')

from .models import ImportRecord


class ImportReportHTMLFormatter(ReportHTMLFormatter):
    filename_template = 'inventory/reports/import_records_report.html'


class ImportReportGenerator(ReportGenerator):
    code = 'import-records'
    description = _('Product Import Costs')
    date_range_field_name = None

    formatters = {
        'HTML_formatter': ImportReportHTMLFormatter,
    }

    def generate(self):
        queryset = ImportRecord.objects.select_related('product').all()

        # Make the GET object easier to access
        params = self.request.GET

        product_pk = params.get('product')

        if product_pk:
            queryset = queryset.filter(product=product_pk) | queryset.filter(
                product__parent=product_pk)

        # Do finaly manipulations
        if len(queryset) > 0:
            queryset = list(queryset)
            queryset[0].fields = {
                field: value for field, value in params.iteritems()
            }
        return self.formatter.generate_response(queryset)

