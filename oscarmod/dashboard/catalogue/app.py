from oscar.apps.dashboard.catalogue import app
from django.conf.urls import patterns, include, url
from inventory import views

class CatalogueApplication(app.CatalogueApplication):
	"""
	Add to /dashboard/catalogue/ URLconfig.
	+-------------------------------------+
	* inventory:list_records
	* inventory:add_record
	* inventory:update_record (doubles as view)
	+=====================================+
	To be implemented: del_record
	"""
	
	def get_urls(self):
		url_patterns = super(CatalogueApplication, self).get_urls()
		url_patterns += patterns('',
			url(regex=r'^records/(?P<parent_pk>\d+)/$',
				view=views.RecordListView.as_view(),
				name='list_records'),
			url(regex=r'^records/(?P<parent_pk>\d+)/add/$',
				view=views.RecordCreateView.as_view(),
				name='add_record'),
			url(regex=r'^records/(?P<parent_pk>\d+)/update/(?P<pk>\d+)/$',
				view=views.RecordUpdateView.as_view(),
				name='update_record'),
		)
		
		return self.post_process_urls(url_patterns)


application = CatalogueApplication()