from .catalogue_importer import ImportCatalogue

class FLiteColumns(object):
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
		
class FLiteFields(object):
	def set_product_fields(self, row):
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
			
		upc=row[self.column_map['upc']],
				description=row[self.column_map['description']],
				cost=row[self.column_map['cost']],
				retail=row[self.column_map['retail']],
				quantity=row[self.column_map['quantity']],
				
		"""
		upc=fields.parent_upc,
			description=fields.description,
			brand=fields.brand,
			color=fields.parent_color,
			material=fields.parent_material,
			size=fields.parent_size,
		parent=parent.product,
			upc=fields.upc,
			description=fields.description,
			cost=fields.cost,
			wholesale=fields.wholesale
			retail=fields.retail,
			quantity=row[self.column_map['quantity']],
			partner=self.partner,
			euro=self.currency_conversion,
			color=color,
			material=material,
			size=size,
		"""
		
		return fields

class ImportFLite(FLiteColumns, FLiteFields, ImportCatalogue):
	pass