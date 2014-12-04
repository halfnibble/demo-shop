import re

from oscar.core.loading import get_class, get_classes
ProductClass, Product, Category, ProductCategory, ProductBrand, ProductActivity = get_classes('catalogue.models',
	('ProductClass', 'Product', 'Category', 'ProductCategory', 'ProductBrand', 'ProductActivity'))

from fixtures.catalogue_importer import ImportCatalogue, CreateParent, CreateVariant

class BaseFields(object):
	def set_product_fields(self, row):
		fields = {
			'parent_upc': row[self.column_map['parent_upc']],
			'upc': row[self.column_map['upc']],
			'product_class': self.global_product_class,
			'title': row[self.column_map['title']],
			'description': row[self.column_map['description']],
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
			'wholesale': row[self.column_map['wholesale']],
			'retail': row[self.column_map['retail']],
			'msrp': row[self.column_map['msrp']],
			'quantity': row[self.column_map['quantity']],
			'partner': self.partner,
			'currency_conversion': self.currency_conversion,
			'categories': None,
		}
					
		
		fields['brand'] = self.match_brand(row[self.column_map['brand']])
			
		fields['activity'] = self.match_activity(row[self.column_map['activity']])
		
		"""
		NOTE: 'color', 'size', and 'material' are custom attributes
		that we've added to our ProductClass 'Clothing'.
		"""
		unique_fields = row[self.column_map['unique']].split('/')
		
		# Set unqiue fields
		if 'style' in unique_fields:
			fields['color'] = row[self.column_map['style']]
			fields['parent_color'] = None
		else:
			fields['color'] = None
			fields['parent_color'] = row[self.column_map['style']]
		
		if 'material' in unique_fields:
			fields['material'] = row[self.column_map['material']]
			fields['parent_material'] = None
		else:
			fields['material'] = None
			fields['parent_material'] = row[self.column_map['material']]
			
		if 'size' in unique_fields:
			fields['size'] = row[self.column_map['size']]
			fields['parent_size'] = None
		else:
			fields['size'] = None
			fields['parent_size'] = row[self.column_map['size']]
		
		fields['categories'] = row[self.column_map['category']].split('/')
		
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


class ImportBase(BaseFields, ImportCatalogue):

	def set_global_product_class(self):
		self.global_product_class = ProductClass.objects.get(name='Clothing')
	
	def set_global_unique(self):
		self.global_unique = False
		
	# Override run() to skip first row. 
	def run(self):
		row_number = 1
		
		for row in self.import_list:
			if row_number == 1:
				row_number += 1
				continue
			
			print "Processing row: %s. UPC: %s" % (row_number, row[self.column_map['upc']])
			
			fields = self.set_product_fields(row)
			
			parent = CreateParent(fields)
			
			variant = CreateVariant(parent.product, fields)
			
			row_number += 1
			
		print "Import Completed. %s rows processed." % (row_number)


"""
Default Columns
===============
set_columns(self, parent_upc=1, upc=2, title=3, description=4, size=5,
		style=6, material=7, unique=8, brand=9, activity=10, category=11,
		cost=12, retail=13, msrp=14, wholesale=15, quantity=16)
"""
# For test purposes
BaseImport = ImportBase(file_path="fixtures/imports/generic_catalog.csv", partner=1, brand=False, currency_conversion=1.0)
BaseImport.set_columns()
BaseImport.run()
