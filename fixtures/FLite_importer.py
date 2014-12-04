import re
from decimal import Decimal
from oscar.core.loading import get_class, get_classes

ImportingError = get_class('partner.exceptions', 'ImportingError')
ProductClass, Product, Category, ProductCategory, ProductBrand, ProductActivity = get_classes('catalogue.models',
	('ProductClass', 'Product', 'Category', 'ProductCategory', 'ProductBrand', 'ProductActivity'))

from fixtures.catalogue_importer import ImportCatalogue
from fixtures.category_utils import MatchCategories


class FLiteColumns(object):
	def set_columns(self, parent_upc=2, upc=2, description=3, 
		style=4, material=5, cost=7, retail=8, quantity=9):
		self.column_map = {
			'parent_upc': parent_upc,
			'upc': upc,
			'title': description,
			'description': description,
			'style': style,
			'material': material,
			'cost': cost,
			'retail': retail,
			'msrp': retail,
			'quantity': quantity
		}


class FLiteFields(object):
	def set_product_fields(self, row):
		fields = {
			'parent_upc': None,
			'upc': row[self.column_map['upc']],
			'product_class': self.global_product_class,
			'title': None,
			'description': None,
			'brand': None,
			'activity': None,
			'parent_color': None,
			'color': None,
			'parent_material': None,
			'material': None,
			'parent_size': None,
			'size': None,
			'parent_image': None,
			'images': None,
			'cost': row[self.column_map['cost']],
			'wholesale': None,
			'retail': row[self.column_map['retail']],
			'msrp': row[self.column_map['msrp']],
			'quantity': row[self.column_map['quantity']],
			'partner': self.partner,
			'currency_conversion': self.currency_conversion,
			'categories': None,
		}
		"""
		NOTE: the follow lines related to UPC are specific to how our CSV file formats 
		the UPC code (It doesn't provide a parent UPC, so we create one).
		Our UPCs are formatted like "dd-dddd-d-d-dddd"
		"""
		fields['parent_upc'] = '-'.join(row[self.column_map['upc']].split('-')[0:3])
		target_group_code = int(row[self.column_map['upc']].split('-')[2])
			
		head, sep, tail = row[self.column_map['description']].partition('/')
		fields['description'] = head
		
		# Since there is no Title field
		fields['title'] = head
		# Use for parent_size or size
		size_value = tail
		
		if self.brand:
			fields['brand'] = self.brand
		else:
			fields['brand'] = self.match_brand(fields['description'])
			
		fields['activity'] = self.match_activity(fields['description'])
		
		"""
		NOTE: 'color', 'size', and 'material' are custom attributes
		that we've added to our ProductClass 'Clothing'.
		"""
		# Set unqiue fields
		if 'style' in self.global_unique:
			fields['color'] = row[self.column_map['style']]
			fields['parent_color'] = None
		else:
			fields['color'] = None
			fields['parent_color'] = row[self.column_map['style']]
		
		if 'material' in self.global_unique:
			fields['material'] = row[self.column_map['material']]
			fields['parent_material'] = None
		else:
			fields['material'] = None
			fields['parent_material'] = row[self.column_map['material']]
			
		if 'size' in self.global_unique:
			fields['size'] = size_value
			fields['parent_size'] = None
		else:
			fields['size'] = None
			fields['parent_size'] = size_value
		
		# Define target_group for MatchCategories()		
		if target_group_code == 7:
			target_group = 'womens'
		elif target_group_code == 8:
			target_group = 'mens'
		elif target_group_code == 9:
			target_group = 'kids'
		else:
			target_group = 'adults'
		
		match_categories = MatchCategories(target_group=target_group, description=fields['description'])
		fields['categories'] = match_categories.results
		
		# Set wholesale, but return it as a string.
		non_decimal = re.compile(r'[^\d.]+')
		
		retail = Decimal(non_decimal.sub('', fields['retail']))
		cost = Decimal(non_decimal.sub('', fields['cost']))
		
		fields['wholesale'] = str((retail - cost) / 2 + cost)
		
		# The 'fields' dict used for Product creation
		return fields
	
	# Find the product's Brand by description regex
	def match_brand(self, description):
		Brands = ProductBrand.objects.all()
		
		for result in Brands:
			if ( re.search(result.name, description, re.IGNORECASE) ):
				return result
	
	# Find the product's Activity by description regex
	def match_activity(self, description):
		Activities = ProductActivity.objects.all()
		
		for result in Activities:
			if ( re.search(result.name, description, re.IGNORECASE) ):
				return result


class ImportFLite(FLiteColumns, FLiteFields, ImportCatalogue):

	def set_global_product_class(self):
		self.global_product_class = ProductClass.objects.get(name='Clothing')
	
	def set_global_unique(self):
		self.global_unique = ['size','style']


"""
Default Columns
===============
set_columns(self, parent_upc=2, upc=2, description=3, 
	style=4, material=5, cost=7, retail=8, quantity=9)
"""
FLiteImport = ImportFLite(file_path="fixtures/imports/F-Order-2014Oct09.csv", partner=1, brand="F-Lite", currency_conversion=1.3)
FLiteImport.set_columns()
FLiteImport.run()