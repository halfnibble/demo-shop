import re, copy

from oscar.core.loading import get_class, get_classes
from oscar.apps.catalogue.categories import create_from_breadcrumbs

"""
You can replace these with regular imports, but make sure you reference
the correct version (i.e. if you forked the app, use your local version)
"""
ImportingError = get_class('partner.exceptions', 'ImportingError')
ProductClass, Product, Category, ProductCategory = get_classes('catalogue.models',
	('ProductClass', 'Product', 'Category', 'ProductCategory'))

class MatchCategories(object):
	"""
	The large convoluted class is a helper class to match a Product
	to a ProductCategory. It is specific to our needs, and likely 
	to change heavily as our store evolves.
	"""
	def __init__(self,  description=None, target_group=None, product_type=None,):
		if description is not None:
			self.description = description
		
		if target_group is not None:
			self.target_group = target_group
		else:
			self.target_group = self.find_target_group()
			
		if product_type is not None:
			self.product_type = product_type
		else:
			self.product_type = self.find_product_type()
		
		# Assume "Clothing" for product type
		self.results = self.match()
	
	def find_target_group(self):
		# Create target lists to search subcategories
		mens = ["men", "man", "male"]
		womens = ["women", "woman", "female", "ladies"]
		kids = ["kid", "child", "junior"]
		
		for term in womens:
			if ( re.search(term, self.description, re.IGNORECASE) ):
				return "womens"
		
		for term in mens:
			if ( re.search(term, self.description, re.IGNORECASE) ):
				return "mens"
				
		for term in kids:
			if ( re.search(term, self.description, re.IGNORECASE) ):
				return "kids"
		
		return "adults" # Assume target is adult
	
	def find_product_type(self):
		# Create list of product types to search
		product_types = [
			# { 'name': 'accessory',   'terms': [] },
			{ 'name': 'tshirt',      'terms': ['tshirt', 't-shirt', 'short sleeve'] },
			{ 'name': 'longshirt',   'terms': ['longshirt','long shirt', 'long sleeve'] },
			{ 'name': 'tanktop',     'terms': ['tanktop', 'tank top'] },
			{ 'name': 'sweater',     'terms': ['sweater', 'sweatshirt'] },
			{ 'name': 'swim',        'terms': ['swim'] },
			{ 'name': 'shirt',       'terms': ['shirt', 'top'] },
			{ 'name': 'shorts',      'terms': ['short'] },
			{ 'name': 'pants',       'terms': ['pants', 'jeans', 'slacks'] },
			{ 'name': 'tights',      'terms': ['tights'] },
			{ 'name': 'coat',        'terms': ['coat', 'jacket'] },
			{ 'name': 'base',        'terms': ['base', 'layer'] },
			{ 'name': 'dress_skirt', 'terms': ['dress', 'skirt',] },
		]
		
		for row in product_types:
			for term in row['terms']:
				if ( re.search(term, self.description, re.IGNORECASE) ):
					return row['name']
		
		return "accessory"
	
	# Create an array of categories to associate with the product
	def match(self):
		categories = []
		category_list = {
			'mens': {
				'accessory':   ["Clothing > Men's Clothing > Accessories"],
				'tshirt':      ["Clothing > Men's Clothing > Shirts > T-Shirt"],
				'longshirt':   ["Clothing > Men's Clothing > Shirts > Longshirt"],
				'tanktop':     ["Clothing > Men's Clothing > Shirts > Tanktop"],
				'shirt':       ["Clothing > Men's Clothing > Shirts"],
				'shorts':      ["Clothing > Men's Clothing > Shorts"],
				'pants':       ["Clothing > Men's Clothing > Pants"],
				'tights':      ["Clothing > Men's Clothing > Pants",
									"Clothing > Men's Clothing > Base Layer"],
				'coat':        ["Clothing > Men's Clothing > Jackets & Coats"],
				'base':        ["Clothing > Men's Clothing > Base Layer"],
				'sweater':     ["Clothing > Men's Clothing > Sweathirts"],
				'swim':        ["Clothing > Men's Clothing > Swimwear"],
			},
			'womens': {
				'accessory':   ["Clothing > Women's Clothing > Accessories"],
				'tshirt':      ["Clothing > Women's Clothing > Shirts & Tops > T-Shirt"],
				'longshirt':   ["Clothing > Women's Clothing > Shirts & Tops > Longshirt"],
				'tanktop':     ["Clothing > Women's Clothing > Shirts & Tops > Tanktop"],
				'shirt':       ["Clothing > Women's Clothing > Shirts & Tops"],
				'shorts':      ["Clothing > Women's Clothing > Shorts"],
				'pants':       ["Clothing > Women's Clothing > Pants"],
				'tights':      ["Clothing > Women's Clothing > Pants",
									"Clothing > Women's Clothing > Base Layer"],
				'coat':        ["Clothing > Women's Clothing > Jackets & Coats"],
				'base':        ["Clothing > Women's Clothing > Base Layer"],
				'sweater':     ["Clothing > Women's Clothing > Sweathirts"],
				'swim':        ["Clothing > Women's Clothing > Swimsuits"],
				'dress_skirt': ["Clothing > Women's Clothing > Dresses & Skirts"],
			},
			'kids': {
				'accessory':   ["Clothing > Kid's Clothing > Accessories"],
				'tshirt':      ["Clothing > Kid's Clothing > Boy's Shirts > T-Shirt",
									"Clothing > Kid's Clothing > Girl's Shirts> T-Shirt"],
				'longshirt':   ["Clothing > Kid's Clothing > Boy's Shirts > Longshirt",
									"Clothing > Kid's Clothing > Girl's Shirts > Longshirt"],
				'tanktop':     ["Clothing > Kid's Clothing > Boy's Shirts > Tanktop",
									"Clothing > Kid's Clothing > Girl's Shirts > Tanktop"],
				'shirt':       ["Clothing > Kid's Clothing > Boy's Shirts",
									"Clothing > Kid's Clothing > Girl's Shirts"],
				'shorts':      ["Clothing > Kid's Clothing > Boy's Pants & Shorts",
									"Clothing > Kid's Clothing > Girl's Pants & Shorts"],
				'pants':       ["Clothing > Kid's Clothing > Boy's Pants & Shorts",
									"Clothing > Kid's Clothing > Girl's Pants & Shorts"],
				'tights':      ["Clothing > Kid's Clothing > Boy's Pants & Shorts",
									"Clothing > Kid's Clothing > Girl's Pants & Shorts"],
				'coat':        ["Clothing > Kid's Clothing > Boy's Jackets & Coats",
									"Clothing > Kid's Clothing > Girl's Jackets & Coats"],
				'base':        ["Clothing > Kid's Clothing > Boy's Jackets & Coats",
									"Clothing > Kid's Clothing > Girl's Jackets & Coats"],
				'sweater':     ["Clothing > Kid's Clothing > Boy's Jackets & Coats",
									"Clothing > Kid's Clothing > Girl's Jackets & Coats",
									"Clothing > Kid's Clothing > Boy's Shirts > Longshirt",
									"Clothing > Kid's Clothing > Girl's Shirts > Longshirt"],
				'swim':        ["Clothing > Kid's Clothing > Boy's Swimwear",
									"Clothing > Kid's Clothing > Girl's Swimwear"],
				'dress_skirt': ["Clothing > Kid's Clothing > Girl's Dresses & Skirts"],
			},
		}
		
		category_list['adults'] = copy.deepcopy(category_list['mens'])
		
		for key, array in category_list['womens'].iteritems():
			try:
				category_list['adults'][key].extend(array)
			except:
				category_list['adults'][key] = array
		
		# The value is always a list for the product_type key.
		categories = category_list[self.target_group][self.product_type]
		
		return categories
	
def assign_categories(product, category_list):
	results = []	
	for category_name in category_list:
		print "Assigning category: %s." % category_name
		leaf = create_from_breadcrumbs(category_name)
		results.append(ProductCategory.objects.get_or_create(product=product, category=leaf))
	
	return results