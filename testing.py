class OneMixin(object):
	def set_data(self, data_obj):
		self.data = data_obj
		
class TwoMixin(object):
	def parse_data(self):
		return self.data.split(' ')[0] + " Josh!"
		
class ThreeMixin(object):
	def set_data(self, data_obj):
		self.data = data_obj[::-1]
		
class BaseObject(OneMixin, TwoMixin):
	def __init__(self, data_obj):
		self.set_data(data_obj)
		print self.parse_data()
		varyable = "It's broken. :,("
		print varyable
		
		
	
		
# bob = BaseObject('Hello World!')

class ExitObject(ThreeMixin, BaseObject):
	def __init__(self, data_obj):
		
		super(ExitObject, self).__init__(data_obj)
		varyable = "It works."


byebob = ExitObject('Hello World!')