from django.conf.urls import patterns, url
from django.views.generic import TemplateView

from pages import views

urlpatterns = patterns('',
	url(r'^$', TemplateView.as_view(template_name='pages/home.html')),
)
