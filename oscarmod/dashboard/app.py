from django.conf.urls import patterns, include, url

from oscar.apps.dashboard import app
from oscar.core.application import Application
from oscar.core.loading import get_class

# Import inventory/app.py => application
from oscarmod.dashboard.inventory.app import application as inventory_app

class DashboardApplication(app.DashboardApplication):
    """
    Add to /dashboard/inventory/ URLconfig.
    +-------------------------------------+
    * dashboard:record_list
    * dashboard:record_create
    * dashboard:record_update (doubles as view)
    * dashboard:tariff_list
    * dashboard:tariff_update (doubles as view)
    +=====================================+
    To be implemented: record_delete, tariff_delete
    """

    def get_urls(self):
        url_patterns = super(DashboardApplication, self).get_urls()
        url_patterns += patterns('',
            # Add inventory app urls to dashboard
            url(r'^inventory/', include(inventory_app.urls)),
        )
        
        return self.post_process_urls(url_patterns)


application = DashboardApplication()