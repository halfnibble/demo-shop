from oscar.apps.dashboard.catalogue import app
from django.conf.urls import patterns, include, url
from inventory import views

class CatalogueApplication(app.CatalogueApplication):
	my_view = views.MyCustomView
	
	def get_urls(self):
		url_patterns = super(CatalogueApplication, self).get_urls()
		url_patterns += patterns('',
			url(r'^import-records/(?P<product_pk>\d+)/$',
				self.my_view.as_view(),
				name='import-records'))
		
		return self.post_process_urls(url_patterns)


application = CatalogueApplication()