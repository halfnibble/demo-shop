from django.db import models
from oscar.apps.customer.abstract_models import AbstractUser

class UserTier(models.Model):
	name = models.CharField("Tier Name", max_length=128)
	description = models.CharField("Description", max_length=248)
	value = models.IntegerField("Value", default=0)
	
	class Meta:
		verbose_name_plural = "User Tiers"

	def __str__(self):
		return self.name

class User(AbstractUser):
	username = models.CharField("Username", max_length=128)
	"""
	Add a user tier to qualify merchants at various reseller levels.
	"""
	tier = models.ForeignKey(UserTier, blank=True, null=True)