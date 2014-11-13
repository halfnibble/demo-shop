"""
Django settings for giggearme project.

For more information on this file, see
https://docs.djangoproject.com/en/1.6/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.6/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))
location = lambda x: os.path.join(
	os.path.dirname(os.path.realpath(__file__)), x)

from django.utils.translation import ugettext_lazy as _

# Secret Setting in .gitignore
from .secret import *

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.6/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = SECRET_KEY_VAR

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []

# Template Contexts

TEMPLATE_CONTEXT_PROCESSORS = (
	"django.contrib.auth.context_processors.auth",
	"django.core.context_processors.request",
	"django.core.context_processors.debug",
	"django.core.context_processors.i18n",
	"django.core.context_processors.media",
	"django.core.context_processors.static",
	"django.core.context_processors.tz",
	"django.contrib.messages.context_processors.messages",
	'oscar.apps.search.context_processors.search_form',
	'oscar.apps.promotions.context_processors.promotions',
	'oscar.apps.checkout.context_processors.checkout',
	'oscar.apps.customer.notifications.context_processors.notifications',
	'oscar.core.context_processors.metadata',
)

# Template Dirs

from oscar import OSCAR_MAIN_TEMPLATE_DIR
TEMPLATE_DIRS = (
	# location('templates'),
	os.path.join(BASE_DIR, 'oscar_mod', 'templates', 'oscar'),
	OSCAR_MAIN_TEMPLATE_DIR,
)

# Application definition
from oscar import get_core_apps

INSTALLED_APPS = [
	'django.contrib.admin',
	'django.contrib.auth',
	'django.contrib.contenttypes',
	'django.contrib.sessions',
	'django.contrib.messages',
	'django.contrib.staticfiles',
	# Add for Oscar
	'django.contrib.sites',
	'django.contrib.flatpages',
	'compressor',
	# Add for Oscar customization
	'oscar_mod',
	'pages',
	# Payment
	'paypal',
] + get_core_apps(['oscar_mod.catalogue', 'oscar_mod.dashboard.catalogue'])

MIDDLEWARE_CLASSES = (
	'django.contrib.sessions.middleware.SessionMiddleware',
	'django.middleware.common.CommonMiddleware',
	'django.middleware.csrf.CsrfViewMiddleware',
	'django.contrib.auth.middleware.AuthenticationMiddleware',
	'django.contrib.messages.middleware.MessageMiddleware',
	'django.middleware.clickjacking.XFrameOptionsMiddleware',
	# Add for Oscar
	'oscar.apps.basket.middleware.BasketMiddleware',
	'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
)

AUTHENTICATION_BACKENDS = (
	'oscar.apps.customer.auth_backends.EmailBackend',
	'django.contrib.auth.backends.ModelBackend',
)

ROOT_URLCONF = 'giggearme.urls'

WSGI_APPLICATION = 'giggearme.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
	'default': {
		'ENGINE': 'django.db.backends.mysql',
		'NAME': 'giggearme2',
		'USER': DB_USER,
		'PASSWORD': DB_PASSWORD,
		'HOST': '',
		'PORT': '',
		'ATOMIC_REQUESTS': True
	}
}


# Search backend settings

HAYSTACK_CONNECTIONS = {
	'default': {
		'ENGINE': 'haystack.backends.simple_backend.SimpleEngine',
	},
}

# Site Settings

SITE_ID = 1

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'America/Chicago'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.6/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR)
STATICFILES_DIRS = (
	os.path.join(BASE_DIR, 'static'),
)

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')

# ==============
# Oscar settings
#===============

#import detaults
from oscar.defaults import *

# Meta

OSCAR_SHOP_NAME = 'GigGearMe'
OSCAR_SHOP_TAGLINE = 'Global Innovative Gear'
OSCAR_DEFAULT_CURRENCY = 'USD'
OSCAR_CURRENCY_LOCALE = 'en_US'

# PayPal Settings
#================

# Taken from PayPal's documentation - these should always work in the sandbox
PAYPAL_SANDBOX_MODE = True
PAYPAL_CALLBACK_HTTPS = False
PAYPAL_CURRENCY = 'USD'
PAYPAL_API_VERSION = '88.0'
PAYPAL_SOLUTION_TYPE = 'Sole' # Note: May have to make account 
							  # creation optional in PayPal.com settings.

# Dashboard Custimizations
OSCAR_DASHBOARD_NAVIGATION += [
	{
		'label': _('Shipping charges'),
		'icon': 'icon-truck',
		'url_name': 'dashboard:shipping-method-list',
	},
	{
		'label': _('PayPal'),
		'icon': 'icon-globe',
		'children': [
			{
				'label': _('PayFlow transactions'),
				'url_name': 'paypal-payflow-list',
			},
			{
				'label': _('Express transactions'),
				'url_name': 'paypal-express-list',
			},
		]
	},
]

# Order pipeline
# ==============

OSCAR_INITIAL_ORDER_STATUS = 'Pending'
OSCAR_INITIAL_LINE_STATUS = 'Pending'
OSCAR_ORDER_STATUS_PIPELINE = {
	'Pending': ('Being processed', 'Cancelled',),
	'Being processed': ('Processed', 'Cancelled',),
	'Cancelled': (),
}

# Logging
# =======

LOG_ROOT = location('logs')
# Ensure log root exists
if not os.path.exists(LOG_ROOT):
	os.mkdir(LOG_ROOT)

LOGGING = {
	'version': 1,
	'disable_existing_loggers': False,
	'handlers': {
		# Include the default Django email handler for errors
		# This is what you'd get without configuring logging at all.
		'mail_admins': {
			'class': 'django.utils.log.AdminEmailHandler',
			'level': 'ERROR',
			 # But the emails are plain text by default - HTML is nicer
			'include_html': True,
		},
		# Log to a text file that can be rotated by logrotate
		'logfile': {
			'class': 'logging.handlers.WatchedFileHandler',
			'filename': os.path.join(LOG_ROOT,'giggearme.log')
		},
	},
	'loggers': {
		# Again, default Django configuration to email unhandled exceptions
		'django.request': {
			'handlers': ['mail_admins'],
			'level': 'ERROR',
			'propagate': True,
		},
		# Might as well log any errors anywhere else in Django
		'django': {
			'handlers': ['logfile'],
			'level': 'ERROR',
			'propagate': False,
		},
		# Your own app - this assumes all your logger names start with "myapp."
		'myapp': {
			'handlers': ['logfile'],
			'level': 'WARNING', # Or maybe INFO or DEBUG
			'propagate': False
		},
		'paypal.express': {
			'handlers': ['logfile'],
			'level': 'ERROR',
			'propagate': False
		},
	},
}