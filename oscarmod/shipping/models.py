from oscar.apps.shipping.models import *

"""
Note: Must set default shipping weight to 0.001 or higher
due to '0' bug in abstract_models > WeightBased > get_charge
"""