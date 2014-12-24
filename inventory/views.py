from django.views.generic import View, ListView, CreateView, UpdateView
from django.shortcuts import get_object_or_404

from oscarmod.catalogue.models import Product

from .models import ImportRecord
from .forms import ImportRecordForm

class ProductMixin(object):
    def dispatch(self, *args, **kwargs):
        product_pk = self.kwargs['product_pk']
        self.product = get_object_or_404(Product, pk=product_pk)
        return super(ProductMixin, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(ProductMixin, self).get_context_data(**kwargs)
        context['product'] = self.product
        context['title'] = self.get_page_title()
        return context

    def get_page_title(self):
        raise NotImplementedError("You must create a title")


class RecordListView(ProductMixin, ListView):
    model = ImportRecord
    context_object_name = 'records'
    
    def get_queryset(self):
       return ImportRecord.objects.filter(product=self.product)
        
    def get_page_title(self):
        return u"Import Records for %s." % (self.product.title)


class RecordCreateView(ProductMixin, CreateView):
    model = ImportRecord
    form_class = ImportRecordForm
    
    def get_page_title(self):
        return u"Create new record for \"%s.\"" % (self.product.title)


class RecordUpdateView(ProductMixin, UpdateView):
    model = ImportRecord
    form_class = ImportRecordForm
    
    def get_page_title(self):
        return u"Update record for \"%s.\"" % (self.product.title)

