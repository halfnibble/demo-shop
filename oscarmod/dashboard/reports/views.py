from django.http import HttpResponseForbidden, Http404
from django.template.response import TemplateResponse
from django.utils.translation import ugettext_lazy as _
from django import forms

from oscar.apps.dashboard.reports import views
from oscarmod.catalogue.models import Product


class ProductForm(forms.Form):
    def __init__(self, request, *args, **kwargs):
        super(ProductForm, self).__init__(*args, **kwargs)
        self.report_type = request.GET.get('report_type')

    product = forms.ModelChoiceField(label=_("Select Product"),
        queryset=Product.objects.select_related('stockrecord').all())


class IndexView(views.IndexView):
    """
    Override certain aspects of the IndexView view to add new features.
    """
    def get(self, request, *args, **kwargs):
        # Added for Import Records report
        product_form = ProductForm(request)

        if 'report_type' in request.GET:
            form = self.report_form_class(request.GET)
            if form.is_valid():
                generator = self._get_generator(form)
                if not generator.is_available_to(request.user):
                    return HttpResponseForbidden(_("You do not have access to"
                                                   " this report"))

                # Add 'request' to generator
                generator.request = request

                report = generator.generate()

                if form.cleaned_data['download']:
                    return report
                else:
                    self.set_list_view_attrs(generator, report)
                    context = self.get_context_data(object_list=self.queryset)
                    context['form'] = form
                    context['product_form'] = product_form
                    context['description'] = generator.report_description()
                    return self.render_to_response(context)
        else:
            form = self.report_form_class()
         
        return TemplateResponse(request, self.template_name,
            {'form': form, 'product_form': product_form})


