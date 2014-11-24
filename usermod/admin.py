from django.contrib import admin
from .models import User, UserTier

admin.site.register(User)
admin.site.register(UserTier)