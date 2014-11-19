#!/usr/bin/env python
import subprocess, sys, os
from giggearme.secret import *
from giggearme.settings import DATABASES


"""
Utility functions
"""
def getOscarPath(virtual_env_path):
	return os.path.join(virtual_env_path,'lib','python2.7','site-packages','oscar')

def getAdminPath(virtual_env_path):
	return os.path.join(virtual_env_path,'lib','python2.7','site-packages','django',
		'contrib','admin')

def getLocalPath(add_to_path):
	local_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
	return os.path.join(local_dir, add_to_path)
	
def runSQL(sql):
	print "Executing %s\nPlease enter password." % (sql)
	return subprocess.call(['mysql','-u',mysql_user,'-p','-e',sql])

"""
Begin installation
"""
print "Running install script v0.1"

clean_install = raw_input("Do you want to do a clean install? (Y/n) ")
production = raw_input("Is this setup for production? (Y/n) ")

if clean_install.lower() != 'y':
	clean_install = False
	print "No other install methods supported at this time. Goodbye."
	sys.exit()
else:
	clean_install = True
	
if production.lower() != 'y':
	production = False
else:
	production = True
	
print "Continuing installation."

print "Installing dependencies."

pip_output = subprocess.call(['pip','install','-r','requirements.txt'])

if pip_output != 0:
	print "ERROR in 'pip install' command"
	
# Drop and re-add database
if clean_install == True:
	print "Dropping database."
	
	mysql_user = raw_input("MySQL username: ")
	# mysql_password = raw_input("MySQL password: ")
	db_name = DATABASES['default']['NAME']
	
	sql = "DROP DATABASE "+db_name
	drop_output = runSQL(sql)
	
	sql = "CREATE DATABASE "+db_name
	create_output = runSQL(sql)
	
	sql = "GRANT ALL ON "+db_name+".* TO '"+DB_USER+"'@'localhost'"
	grant_output = runSQL(sql)
	
	if drop_output != 0 or create_output != 0 or grant_output != 0:
		print "ERROR: Dropping and creating database."

# Run migrations
print "Running database migrations."
migrate_output = subprocess.call(['python','manage.py','migrate'])

if migrate_output != 0:
	print "ERROR: Migrating database."
	
# Import fixtures
fixture_list = ['us_countries.json', 'product_classes.json',
	'product_brands.json', 'product_attributes.json',
	'product_activities.json', 'partner_partners.json']

for fixture in fixture_list:
	import_output = subprocess.call(['python','manage.py','loaddata','fixtures/'+fixture])
	if import_output != 0:
		print "ERROR: Importing fixture: " + fixture + "."

category_output = subprocess.call('python manage.py shell < fixtures/category_importer.py',shell=True)
if category_output != 0:
	print "ERROR: Importing category_importer.py."

catalogue_output = subprocess.call('python manage.py shell < fixtures/catalogue_importer.py',shell=True)
if catalogue_output != 0:
	print "ERROR: Importing catalogue_importer.py."

# Create symbolic link for production
if production:
	searching = True
	while (searching):
		venv_location = raw_input("Enter location of VirtualEnv: ")
		try:
			oscar_static_path = os.path.join(getOscarPath(venv_location),'static','oscar')
			admin_static_path = os.path.join(getAdminPath(venv_location),'static','admin')
			
			if not os.path.isdir(oscar_static_path):
				raise Exception("This is not a valid directory: "+oscar_static_path)
			if not os.path.isdir(admin_static_path):
				raise Exception("This is not a valid directory: "+admin_static_path)
				
			ln_oscar_output = subprocess.call(['ln','-s',oscar_static_path,'static/oscar'])
			ln_admin_output = subprocess.call(['ln','-s',admin_static_path,'static/admin'])
			
			if ln_oscar_output == 0 or ln_admin_output:
				print "Oscar and Admin dirs found. Continuing."
				searching = False
			else:
				print "ERROR: While creating symbolic links to "+oscar_static_path+", and/or "+admin_static_path+"."
		except:
			print "Unable to create symbolic links. Check the directory and try again."
				
	

# Set folder owner for 'static' and 'media' on production
if production:
	chown_static_output = subprocess.call(['chown','-R','www-data','static'])
	chown_media_output = subprocess.call(['chown','-R','www-data','media'])
	
	if chown_static_output != 0:
		print "ERROR: Setting owner for static folder."
	if chown_media_output != 0:
		print "ERROR: Setting owner for media folder."

# Set folder permission on production
if production:
	chmod_static_output = subprocess.call(['chmod','-R','0664','static'])
	chmod_media_output = subprocess.call(['chmod','-R','0764','media'])
	
	if chmod_static_output != 0:
		print "ERROR: Setting permissions for static folder."
	if chmod_media_output != 0:
		print "ERROR: Setting permissions for media folder."
		
# Create Super Users.

# Create Shipping and Bands.

