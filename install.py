#!/usr/bin/env python
import subprocess, sys, os
from secret import *
from settings import DATABASES


"""
Utility functions
"""
def getLocalPath(add_to_path):
	local_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
	return os.path.join(local_dir, add_to_path)
	
def runSQL(sql):
	return subprocess.call(['mysql','-u',mysql_user,'-p',mysql_password,'-e',sql])

"""
Begin installation
"""
print "Running install script v0.1"

type_install = raw_input("Do you want to do a clean install? (Y/n) ")

if type_install.lower() != 'y':
	clean_install = False
	print "No other install methods supported at this time. Goodbye."
	sys.exit()
else:
	clean_install = True
	
print "Continuing installation."

print "Installing dependencies."

pip_output = subprocess.call(['pip','install','-r','requirements.txt'])

if pip_output != 0:
	print "ERROR in 'pip install' command"
	
# Drop and re-add database
if clean_install == True:
	print "Dropping database:"
	
	mysql_user = raw_input("MySQL username: ")
	mysql_password = raw_input("MySQL password: ")
	db_name = DATABASES['default']['NAME']
	
	sql = "DROP DATABASE "+db_name
	drop_output = runSQL(sql)
	
	sql = "CREATE DATABASE "+db_name
	create_output = runSQL(sql)
	
	sql = "GRANT ALL ON "+db_name+".* TO '"+DB_USER+"'@'localhost'"
	grant_output = runSQL(sql)
	
	if drop_output != 0 || create_output != 0 || grant_output != 0:
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
	import_output = subprocess.call(['python','manage.py','loaddata',fixture])
	if import_output != 0:
		print "ERROR: Importing fixture: " + fixture + "."

category_output = subprocess.call(['python','manage.py','shell','<','category_importer.py'])
if category_output != 0:
	print "ERROR: Importing category_importer.py."

catalogue_output = subprocess.call(['python','manage.py','shell','<','catalogue_importer.py'])
if catalogue_importer != 0:
	print "ERROR: Importing catalogue_importer.py."

# Create symbolic link for production

# Set folder owner for 'static' and 'media' on production

# Set folder permission on production
#test_path = os.path.join(script_path, 'media', 'apched')

#ln_output = subprocess.call(['ln', '-s', '/var/log/apache2', test_path])
