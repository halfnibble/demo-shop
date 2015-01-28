from django.contrib import admin
from .models import ImportRecord

class ImportRecordAdmin(admin.ModelAdmin):
	pass
		
admin.site.register(ImportRecord)
