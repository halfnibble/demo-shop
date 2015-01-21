from oscar.apps.dashboard.reports import views

class IndexView(views.IndexView):
    """
    Override certain aspects of the IndexView view to add new features.
    """
    def get(self, request, *args, **kwargs):
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
                    context['description'] = generator.report_description()
                    return self.render_to_response(context)


