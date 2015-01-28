from oscar.apps.dashboard.catalogue import app
from django.conf.urls import patterns, include, url

class CatalogueApplication(app.CatalogueApplication):
    """
    Add to /dashboard/catalogue/ URLconfig.
    +-------------------------------------+
    * 
    +=====================================+
    To be implemented: 
    """
    
    def get_urls(self):
        url_patterns = super(CatalogueApplication, self).get_urls()
        url_patterns += patterns('',
            # Add inventory app urls to dashboard
            # url(r'^inventory/', include('apps.dashboard.inventory.urls')),
        )
        
        return self.post_process_urls(url_patterns)


application = CatalogueApplication()