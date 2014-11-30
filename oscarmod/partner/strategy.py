from oscar.apps.partner import strategy

"""
You must modify the checkout process to calculate incl_tax
before using the US strategy
#########################################################
class Selector(object):

	def strategy(self, request=None, user=None, **kwargs):
		return strategy.US(request)
"""