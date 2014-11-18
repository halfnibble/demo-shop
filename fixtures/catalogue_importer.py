import os, re, csv, copy
from decimal import Decimal
from datetime import datetime

from oscar.core.loading import get_class, get_classes
from oscar.apps.catalogue.categories import create_from_breadcrumbs

"""
You can replace these with regular imports, but make sure you reference
the correct version (i.e. if you forked the app, use your local version)
"""
ImportingError = get_class('partner.exceptions', 'ImportingError')
Partner, StockRecord = get_classes('partner.models', ['Partner', 'StockRecord'])
ProductClass, Product, Category, ProductCategory, ProductBrand, ProductActivity = get_classes('catalogue.models',
	('ProductClass', 'Product', 'Category', 'ProductCategory', 'ProductBrand', 'ProductActivity'))

class ImportCatalogue(object):
	"""
	This is a manager class.
	The initialization will setup default attributes like which partner to use in stock record.
	> set_columns(...) will associate CSV columns with Product attributes.
	> run() will loop through each row and create Parent and Child Products as necessary.
	"""
	
	def __init__(self, file_path, partner=1, brand=False, unique=['size'], euro=1.3):
		# Required. File to import
		self.file_path = file_path
		
		# Required Partner ID/Name for import
		try:
			self.partner = self.match_partner(partner)
		except:
			print "Invalid Partner ID/Name entered."
			raise
		
		# Optional. Brand ID/Name for entire import
		if brand:
			try:
				self.brand = self.match_brand(brand)
			except:
				print "Invalid Global Brand ID/Name entered."
				raise
		else:
			self.brand = False
			
		# Set fields unique to child products
		self.unique = unique
		
		# Euro to USD conversion factor
		self.euro = euro
	
	# Find the import Partner by ID or Name
	def match_partner(self, partner):
		if isinstance(partner, (int, long)):
			return Partner.objects.get(pk=partner)
		else:
			Partners = Partner.objects.all()
			for result in Partners:
				if ( re.search(partner, result.name, re.IGNORECASE) ):
					return result
		return False
	
	""" 
	NOTE: Brand is an added Field in the Product object
	that we added.
	"""
	# Find the global Brand if applicable by ID or Name
	def match_brand(self, brand):
		if isinstance(brand, (int, long)):
			return ProductBrand.objects.get(pk=brand)
		else:
			Brands = ProductBrand.objects.all()
			for result in Brands:
				if ( re.search(brand, result.name, re.IGNORECASE) ):
					return result
		return False
	
	# Set column specifics, and loop through file to add products.
	def set_columns(self, parent_upc, upc, description, color, material, cost, retail, quantity):
		self.column_map = {
			'parent_upc': parent_upc,
			'upc': upc,
			'description': description,
			'color': color,
			'material': material,
			'cost': cost,
			'retail': retail,
			'quantity': quantity
		}
	
	# Open file and loop and add products. 
	def run(self):
		with open(self.file_path, 'rb') as import_file:
			reader = csv.reader(import_file)
			import_list = list(reader)
		
		row_number = 1
		
		for row in import_list:
			print "Processing row: %s. UPC: %s" % (row_number, row[self.column_map['upc']])
			row_number += 1
			
			"""
			NOTE: the follow lines related to UPC are specific to how our CSV file formats 
			the UPC code (It doesn't provide a parent UPC, so we create one).
			Our UPCs are formatted like "dd-dddd-d-dddddd"
			"""
			# For issues related to same UPC for men's and women's
			if row[self.column_map['upc']] == row[self.column_map['parent_upc']]:
				parent_upc = '-'.join(row[self.column_map['upc']].split('-')[0:3])
				# ^ this produces "dd-dddd-d" that is unique to gender models
			else:
				parent_upc = row[self.column_map['parent_upc']]
				
			"""
			NOTE: 'color', 'size', and 'material' are custom attributes
			that we've added to our Product class "Clothing"
			"""
			
			# Set unqiue fields
			if 'color' in self.unique:
				color = row[self.column_map['color']]
				parent_color = False
			else:
				color = False
				parent_color = row[self.column_map['color']]
			
			if 'material' in self.unique:
				material = row[self.column_map['material']]
				parent_material = False
			else:
				material = False
				parent_material = row[self.column_map['material']]
				
			if 'size' in self.unique:
				size = True
				parent_size = False
			else:
				size = False
				parent_size = True
				
			
			parent = CreateParentProduct(upc=parent_upc,
				description=row[self.column_map['description']],
				brand=self.brand,
				color=parent_color,
				material=parent_material,
				size=parent_size,
			)
			
			CreateChildProduct(parent=parent.product,
				upc=row[self.column_map['upc']],
				description=row[self.column_map['description']],
				cost=row[self.column_map['cost']],
				retail=row[self.column_map['retail']],
				quantity=row[self.column_map['quantity']],
				partner=self.partner,
				euro=self.euro,
				color=color,
				material=material,
				size=size,
			)
		
		print "Import Completed. %s rows processed." % (row_number)


class CreateProduct(object):
	def function():
		pass
	"""
	This is here to remind me to refactor and abstract out the common functions in 
	CreateParentProduct and CreateChildProduct once I have time to read up on 
	Python OOP and inheritance. 
	"""


class CreateParentProduct(object):
	"""
	Creates a Parent Product.
	"""
	
	def __init__(self, upc, description, brand, color, material, size):
		self.upc = upc
		self.title = description # Note: no title field. :,(
		self.description = description
		if color:
			self.color = color.title()
		else:
			self.color = False
		self.material = material
		self.brand = brand
		
		# If this parent already exists, return to caller
		if self.exists():
			return
		
		# Remove size attributes from description
		if size:
			self.size = self.filter_size()
		else:
			self.size = False
			self.filter_size()
			
		# Set brand name
		if not self.brand:
			self.brand = self.match_brand()
			
		# Set activity type (i.e. Ski, Running, etc.)
		self.activity = self.match_activity()
		
		self.create()
		
	# Determine if parent product has been created previously
	def exists(self):
		parent = False
		try:
			parent = Product.objects.get(upc=self.upc)
		except:
			pass
		
		if parent:
			self.product = parent
			return True
	
	# Filter size out of description and return it
	def filter_size(self):
		head, sep, tail = self.description.partition('/')
		self.description = head
		# Since there is no Title field
		t_head, t_sep, t_tail = self.title.partition('/')
		self.title = t_head
		
		return tail		
	
	# Find the product's Brand by regex
	def match_brand(self):
		Brands = ProductBrand.objects.all()
		self.brand = None
		
		for result in Brands:
			if ( re.search(result.name, self.description, re.IGNORECASE) ):
				return Brand
	
	# Find the product's Activity by description regex
	def match_activity(self):
		Activities = ProductActivity.objects.all()
		self.activity = None
		
		for result in Activities:
			if ( re.search(result.name, self.description, re.IGNORECASE) ):
				return result
	
	# Create Parent and save
	def create(self):
		parent = Product()
		
		"""
		Temporary fix
		"""
		product_class = ProductClass.objects.get(name="Clothing")
		
		parent.structure = 'parent'
		parent.upc = self.upc
		parent.title = self.title
		parent.description = self.description
		parent.product_class = product_class
		parent.brand = self.brand
		parent.activity = self.activity
		
		if self.color:
			setattr(parent.attr, 'color', self.color)
		if self.material:
			setattr(parent.attr, 'material', self.material)
		if self.size:
			setattr(parent.attr, 'size', self.size)
		
		parent.save()
		
		MatchCategories(parent, parent.description)
		
		print "Created Parent Product: " + parent.upc
		
		self.product = parent


class CreateChildProduct(object):
	"""
	Create a Product variant
	"""
	
	def __init__(self, parent, upc, description, cost, retail, quantity, partner, euro, color, material, size):
		self.parent = parent
		self.upc = upc
		self.description = description
		
		non_decimal = re.compile(r'[^\d.]+')
		self.cost = Decimal(non_decimal.sub('', cost))
		self.retail = Decimal(non_decimal.sub('', retail))
		self.quantity = int(quantity)
		self.partner = partner
		self.euro = Decimal(euro)
		if color:
			self.color = color.title()
		else:
			self.color = color
		self.material = material
		
		if size:
			self.size = self.filter_size()
		else:
			self.size = False
			self.filter_size()
			
		# If product already exists, update stock w/ quantity
		if self.exists():
			self.update_stock()
		else:
			self.create()
	
	# Determine if product already exists
	def exists(self):
		try:
			self.product = Product.objects.get(upc=self.upc)
			return True
		except:
			return False
	
	# Filter size out of description and return it
	def filter_size(self):
		head, sep, tail = self.description.partition('/')
		self.description = head
		
		return tail
	
	# Update stock quantity for existing product
	def update_stock(self):
		try:
			stock = StockRecord.objects.get(partner_sku=self.upc)
		except:
			self.create_stockrecord()
			return
			
		stock.num_in_stock += self.quantity
		stock.save()
	
	def create_stockrecord(self):

		stock = StockRecord()
		stock.product = self.product
		stock.partner = self.partner
		stock.partner_sku = self.upc
		stock.cost_price = self.cost * self.euro
		stock.price_excl_tax = self.retail * self.euro
		stock.price_retail = self.retail * self.euro
		stock.num_in_stock = self.quantity
		stock.save()
	
	# Create product and inventory
	def create(self):
		product = Product()
		
		product.structure = 'child'
		product.parent = self.parent
		product.upc = self.upc
		product.product_class = self.parent.product_class
		
		if self.color:
			setattr(product.attr, 'color', self.color)
		if self.material:
			setattr(product.attr, 'material', self.material)
		if self.size:
			setattr(product.attr, 'size', self.size)
		
		product.save()
		
		self.product = product
		self.create_stockrecord()
		
		print "Created Product: " + self.upc
		

class MatchCategories(object):
	"""
	The large convoluted class is a helper class to match a Product
	to a ProductCategory. It is specific to our needs, and likely 
	to change heavily as our store evolves.
	"""
	
	def __init__(self, product, description, product_class="Clothing"):
		self.product = product
		self.description = description
		self.product_class = product_class
		
		# Assume "clothing" for main category
		self.target_group = self.find_target()	
		self.product_type = self.find_type()
		self.results = self.match()
	
	def find_target(self):
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
	
	def find_type(self):
		# Create list of product types to search
		product_types = [
			# { 'name': 'accessory',   'terms': [] },
			{ 'name': 'tshirt',      'terms': ['tshirt', 't-shirt', 'short sleeve'] },
			{ 'name': 'longshirt',   'terms': ['longshirt','long shirt', 'long sleeve'] },
			{ 'name': 'tanktop',     'terms': ['tanktop', 'tank top'] },
			{ 'name': 'sweater',     'terms': ['sweater', 'sweatshirt'] },
			{ 'name': 'swim',        'terms': ['swim'] },
			{ 'name': 'shirt',       'terms': ['shirt', 'top'] },
			{ 'name': 'shorts',      'terms': ['shorts'] },
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
		
		category_names = category_list[self.target_group][self.product_type]
		
		for category_name in category_names:
			print "category: %s" % category_name
			leaf = create_from_breadcrumbs(category_name)
			categories.append(ProductCategory.objects.get_or_create(product=self.product, category=leaf))
		
		return categories


# F-Lite 2014 Oct 9th
FLiteImport = ImportCatalogue(file_path="fixtures/imports/F-Order-2014Oct09.csv", partner=1, brand="F-Lite", unique=['size'])
FLiteImport.set_columns(parent_upc=2, upc=2, description=3, color=4, material=5, cost=7, retail=8, quantity=9)
FLiteImport.run()

# HAD 2014 Oct 13th
HADImport = ImportCatalogue(file_path="fixtures/imports/HAD-Order-2014Oct13.csv", partner=1, brand="H.A.D.", unique=['color'])
HADImport.set_columns(parent_upc=2, upc=3, description=4, color=5, material=6, cost=10, retail=11, quantity=12)
HADImport.run()

# HAD 2014 Oct 9th
HADImport = ImportCatalogue(file_path="fixtures/imports/HAD-Order-2014Oct09.csv", partner=1, brand="H.A.D.", unique=['color'])
HADImport.set_columns(parent_upc=2, upc=3, description=4, color=5, material=6, cost=10, retail=11, quantity=12)
HADImport.run()
