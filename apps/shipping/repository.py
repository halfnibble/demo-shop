from oscar.apps.shipping import repository, models
from usermod.models import UserTier
from .methods import *


class Repository(repository.Repository):
    """
    Repository class responsible for returning ShippingMethod
    objects for a given user, basket etc
    """

    def get_available_shipping_methods(self, basket, user=None, shipping_addr=None, request=None, **kwargs):
        """
        Return weight-based shipping methods and Overnight shipping.
        """
        # For Users in Merchant Tiers
        if user and hasattr(user, 'tier'):
            level_1 = UserTier.objects.get(pk=1)
            level_2 = UserTier.objects.get(pk=1)
            if user.tier == level_1:
                methods = [ TierOne(), ]
                return methods
            elif user.tier == level_2:
                methods = [ TierTwo(), ]
                return methods
            else:
                pass
        # For Regular Users:    
        methods = list(models.WeightBased.objects.all())
        methods.extend([ Overnight(), ])
        
        return methods
