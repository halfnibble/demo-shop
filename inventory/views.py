from django.views.generic import View, ListView, CreateView, UpdateView
from django.shortcuts import get_object_or_404
from django.contrib import messages

from oscarmod.catalogue.models import Product

from .models import ImportRecord
from .forms import ImportRecordForm

class ProductMixin(object):
    """
    This mixin handles product and title attributes of ImportRecord Views.
    """
    def dispatch(self, *args, **kwargs):
        parent_pk = self.kwargs['parent_pk']
        self.parent = get_object_or_404(Product, pk=parent_pk)
        return super(ProductMixin, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(ProductMixin, self).get_context_data(**kwargs)
        context['parent'] = self.parent
        context['title'] = self.get_page_title()
        return context

    def get_page_title(self):
        raise NotImplementedError("You must create a title method.")


class ProductFormMixin(object):
    """
    A simple mixin to add dynamic kwargs to the ModelForm instance named 
    ImportRecordForm. For generating dynamic field querysets. 
    """
    def get_form_kwargs(self):
        kwargs = super(ProductFormMixin, self).get_form_kwargs()
        kwargs['parent'] = self.parent
        return kwargs

class FormSaveMixin(object):
    """
    Redirect submitted form to self and display a message.
    """
    @property
    def submitted_msg(self):
        return "Your changes have been applied."

    def form_valid(self, form):
        self.object = form.save()
        messages.info(self.request, self.submitted_msg)
        return self.render_to_response(self.get_context_data(form=form))
        


class RecordListView(ProductMixin, ListView):
    model = ImportRecord
    context_object_name = 'records'
    
    def get_queryset(self):
        variants = self.parent.children.all()
        products = list(variants) + [self.parent]
        return ImportRecord.objects.filter(product__in=products).order_by(
            '-imported_date')
        
    def get_page_title(self):
        return u"Import Records for %s." % (self.parent.title)


class RecordCreateView(ProductMixin, ProductFormMixin,
    FormSaveMixin, CreateView):
    model = ImportRecord
    form_class = ImportRecordForm

    def get_page_title(self):
        return u"Create new record for \"%s.\"" % (self.parent.title)


class RecordUpdateView(ProductMixin, ProductFormMixin,
    FormSaveMixin, UpdateView):
    model = ImportRecord
    form_class = ImportRecordForm

    def get_page_title(self):
        return u"Update record for \"%s.\"" % (self.parent.title)

