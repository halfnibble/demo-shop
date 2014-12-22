from django.views.generic import ListView, CreateView, UpdateView
from django.shortcuts import get_object_or_404

from oscarmod.catalogue.models import Product

from .models import ImportRecord
from .forms import ImportRecordForm

class RecordListView(ListView):
    model = ImportRecord
    context_object_name = 'records'
    
    def get_queryset(self):
        product_pk = self.kwargs['product_pk']
        self.product = get_object_or_404(Product, pk=product_pk)
        return ImportRecord.objects.filter(product=self.product)
    
    def get_context_data(self, **kwargs):
        context = super(RecordListView, self).get_context_data(**kwargs)
        context['product'] = self.product
        context['title'] = self.get_page_title()
        return context
    
    def get_page_title(self):
        return u"Import Records for %s." % (
            self.product.title)


class RecordCreateView(CreateView):
    model = ImportRecord
    form_class = ImportRecordForm
    

class RecordUpdateView(UpdateView):
    model = ImportRecord
    form_class = ImportRecordForm
    

