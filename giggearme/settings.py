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
	os.path.join(BASE_DIR, 'templates', 'oscar'),
#	location('templates'),
#	OSCAR_MAIN_TEMPLATE_DIR,
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
    'south',
    'compressor',
] + get_core_apps()

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
	'oscar.apps.customer.auth_backends.Emailbackend',
	'django.contrib.auth.backends.ModelBackend',
)

ROOT_URLCONF = 'giggearme.urls'

WSGI_APPLICATION = 'giggearme.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.6/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'giggearme',
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
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

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

