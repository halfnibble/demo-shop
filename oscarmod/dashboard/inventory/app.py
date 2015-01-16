from django.conf.urls import patterns, url
from django.contrib.admin.views.decorators import staff_member_required

from oscar.core.application import Application

from oscarmod.dashboard.inventory.urls import urlpatterns as urls_urlpatterns


class InventoryDashboardApplication(Application):
    name = None

    def get_urls(self):
        urlpatterns = urls_urlpatterns
        return self.post_process_urls(urlpatterns)

    def get_url_decorator(self, url_name):
        return staff_member_required


application = InventoryDashboardApplication()