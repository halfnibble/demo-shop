from django.conf.urls import patterns, include, url
from apps.dashboard.inventory import views

urlpatterns = patterns('',
    url(regex=r'^records/(?P<parent_pk>\d+)/$',
        view=views.RecordListView.as_view(),
        name='record_list'),
    url(regex=r'^records/(?P<parent_pk>\d+)/add/$',
        view=views.RecordCreateView.as_view(),
        name='record_create'),
    url(regex=r'^records/(?P<parent_pk>\d+)/update/(?P<pk>\d+)/$',
        view=views.RecordUpdateView.as_view(),
        name='record_update'),
    url(regex=r'^tariffs/$',
        view=views.TariffListView.as_view(),
        name='tariff_list'),
    url(regex=r'^tariffs/add/$',
        view=views.TariffCreateView.as_view(),
        name='tariff_create'),
    url(regex=r'^tariffs/(?P<pk>[\w.]+)/$',
        view=views.TariffUpdateView.as_view(),
        name='tariff_update'),
)