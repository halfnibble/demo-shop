from django.conf import settings
from django.conf.urls import patterns, include, url
from django.conf.urls.static import static
from oscar.app import application
from paypal.express.dashboard.app import application as paypal
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'giggearme.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
    
    # PayPal integration
    url(r'^checkout/paypal/', include('paypal.express.urls')),
    url(r'^dashboard/paypal/express/', include(paypal.urls)),

    # oscar URLS
    url(r'^i18n', include('django.conf.urls.i18n')),
    url(r'', include('pages.urls', namespace='pages')),
    url(r'', include(application.urls)),
    
    
    # admin
    url(r'^admin/', include(admin.site.urls)),
)

if settings.DEBUG:
    # Server statics and uploaded media
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
