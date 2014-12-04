import os, re, csv
from decimal import Decimal
from datetime import datetime

from oscar.core.loading import get_class, get_classes
"""
You can replace these with regular imports, but make sure you reference
the correct version (i.e. if you forked the app, use your local version)
"""
ImportingError = get_class('partner.exceptions', 'ImportingError')
Partner, StockRecord = get_classes('partner.models', ['Partner', 'StockRecord'])
ProductClass, Product, Category, ProductCategory, ProductBrand, ProductActivity = get_classes('catalogue.models',
	('ProductClass', 'Product', 'Category', 'ProductCategory', 'ProductBrand', 'ProductActivity'))

from fixtures.category_utils import assign_categories


class OpenFile(object):
	"""
	This mixin contains functionality to open a file.
	Override for different file types.
	"""
	def set_import_list(self, file_path):
		self.import_list = []
		with open(file_path, 'rb') as import_file:
			reader = csv.reader(import_file)
			self.import_list = list(reader)


class ParseColumns(object):
	"""
	This mixin takes imported file data and parses out the required fields.
	Override for different vendors.
	"""
	def set_columns(self, parent_upc=1, upc=2, title=3, description=4, size=5,
		style=6, material=7, unique=8, brand=9, activity=10, category=11,
		cost=12, retail=13, msrp=14, wholesale=15, quantity=16):
		self.column_map = {
			'parent_upc': parent_upc,
			'upc': upc,
			'title': title,
			'description': description,
			'size': size,
			'style': style,
			'material': material,
			'unique': unique,
			'brand': brand,
			'activity': activity,
			'category': category,
			'cost': cost,
			'retail': retail,
			'msrp': msrp,
			'wholesale': wholesale,
			'quantity': quantity
		}


class ImportCatalogue(OpenFile, ParseColumns):
	"""
	This is a manager mixin.
	The initialization will setup default attributes like which partner to use in stock record.
	> set_columns() will set column_map to file_path data.
	> run() will loop through each row and create Parent and Variant products as necessary.
	"""
	
	def __init__(self, file_path, partner=1, brand=False, currency_conversion=1.0):
		# Requried: Import data from file_path
		try:
			self.set_import_list(file_path)
		except:
			raise IOError("Unable to import file: " + file_path + ".")
		
		# Set global ProductClass
		self.set_global_product_class()
		
		# Required: Partner ID/Name for import
		try:
			self.partner = self.match_global_partner(partner)
		except:
			raise StandardError("Invalid Partner ID/Name entered.")
		
		# Optional: Brand ID/Name for entire import
		if brand:
			try:
				self.brand = self.match_global_brand(brand)
			except:
				raise StandardError("Invalid Global Brand ID/Name entered.")
		else:
			self.brand = False
			
		# Set fields unique to child products
		self.set_global_unique()
		
		# Set currency conversion factor
		self.currency_conversion = currency_conversion
	
	"""
	Implement a method to set a global ProductClass.
	Override for different import lists.
	"""
	def set_global_product_class(self):
		raise NotImplementedError(
			'Must override set_global_product_class in catalogue_importer!!')
		
	"""
	Implement a method to set global unique Variant attributes.
	Override for different import lists.
	"""
	def set_global_unique(self):
		self.global_unique = []
	
	"""
	Set product fields based on unqiue vendor algorithm.
	Override for different vendors.
	"""
	def set_product_fields(self):
		raise NotImplementedError(
			'Must override set_product_fields in catalogue_importer.py!!')
	
	# Find the import Partner by ID or Name
	def match_global_partner(self, partner):
		if isinstance(partner, (int, long)):
			return Partner.objects.get(pk=partner)
		else:
			Partners = Partner.objects.all()
			for result in Partners:
				if ( re.search(partner, result.name, re.IGNORECASE) ):
					return result
		return False
	
	# Find the global Brand if applicable by ID or Name
	def match_global_brand(self, brand):
		if isinstance(brand, (int, long)):
			return ProductBrand.objects.get(pk=brand)
		else:
			Brands = ProductBrand.objects.all()
			for result in Brands:
				if ( re.search(brand, result.name, re.IGNORECASE) ):
					return result
		return False
	
	
	# Open file and loop and add products. 
	def run(self):
		row_number = 1
		
		for row in self.import_list:
			print "Processing row: %s. UPC: %s" % (row_number, row[self.column_map['upc']])
			row_number += 1

			fields = self.set_product_fields(row)
			
			parent = CreateParent(fields)
			
			variant = CreateVariant(parent.product, fields)
			
		print "Import Completed. %s rows processed." % (row_number)



class CreateParent(object):
	"""
	Creates a Parent Product.
	"""	
	def __init__(self, fields):
		self.fields = fields
		
		# If this parent already exists, return to caller
		if self.exists():
			return
		
		self.create()
	
	# Return parent product if created previously
	def exists(self):
		try:
			self.product = Product.objects.get(upc=self.fields['parent_upc'])
			return True
		except:
			pass
		
		return False
	
	# Create parent Product and save
	def create(self):
		parent = Product()
		
		parent.structure = 'parent'
		parent.upc = self.fields['parent_upc']
		parent.title = self.fields['title']
		parent.description = self.fields['description']
		parent.product_class = self.fields['product_class']
		parent.brand = self.fields['brand']
		parent.activity = self.fields['activity']
		if self.fields['parent_color'] is not None:
			parent.attr.color = self.fields['parent_color'].title()
		if self.fields['parent_material'] is not None:
			parent.attr.material = self.fields['parent_material']
		if self.fields['parent_size'] is not None:
			parent.attr.size = self.fields['parent_size']
		"""
		In future, implement 'parent_image' field
		"""
		
		parent.save()
		
		product_categories = assign_categories(parent, self.fields['categories'])
		
		print "Created Parent Product: %s." % (parent.upc)
		
		self.product = parent


class CreateVariant(object):
	"""
	Create a Variant Product
	"""	
	def __init__(self, parent, fields):
		self.parent = parent
		self.fields = fields
		
		# Perform some basic Number type validations & conversions
		non_decimal = re.compile(r'[^\d.]+')
		decimal_fields = ['cost','wholesale','retail','msrp']
		for field in decimal_fields:
			self.fields[field] = Decimal(non_decimal.sub('', fields[field]))

		self.fields['quantity'] = int(fields['quantity'])

		self.fields['currency_conversion'] = Decimal(fields['currency_conversion'])
		
		# If product already exists, update stock w/ quantity
		if self.exists():
			self.update_stock()
		else:
			self.create()
	
	# Determine if product already exists
	def exists(self):
		try:
			self.product = Product.objects.get(upc=self.fields['upc'])
			return True
		except:
			return False
	
	
	# Update stock quantity for existing product
	def update_stock(self):
		try:
			stock = StockRecord.objects.get(partner_sku=self.fields['upc'])
		except:
			self.create_stockrecord()
			return
			
		stock.num_in_stock += self.fields['quantity']
		stock.save()
	
	def create_stockrecord(self):

		stock = StockRecord()
		stock.product = self.product
		stock.partner = self.fields['partner']
		stock.partner_sku = self.fields['upc']
		stock.cost_price = self.fields['cost'] * self.fields['currency_conversion']
		stock.price_excl_tax = self.fields['retail'] * self.fields['currency_conversion']
		stock.price_retail = self.fields['msrp'] * self.fields['currency_conversion']
		stock.price_reseller = self.fields['wholesale'] * self.fields['currency_conversion']
		stock.num_in_stock = self.fields['quantity']
		stock.save()
	
	# Create product and inventory
	def create(self):
		product = Product()
		
		product.structure = 'child'
		product.parent = self.parent
		product.upc = self.fields['upc']
		
		if self.fields['color'] is not None:
			product.attr.color = self.fields['color'].title()
		if self.fields['material'] is not None:
			product.attr.material = self.fields['material']
		if self.fields['size'] is not None:
			product.attr.size = self.fields['size']
		
		product.save()
		
		self.product = product
		self.create_stockrecord()
		
		print "Created Product: %s." % (self.fields['upc'])
		



"""
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
"""