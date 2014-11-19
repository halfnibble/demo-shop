#!/usr/bin/env python
import subprocess, sys, os

print "Running install script v0.1"

type_install = raw_input("Do you want to do a clean install? (Y/n) ")

if type_install.lower() != 'y':
	print "No other install methods supported at this time. Goodbye."
	sys.exit()

print "Continuing installation."

def getScriptPath():
	return os.path.dirname(os.path.realpath(sys.argv[0]))

script_path = getScriptPath()


test_path = os.path.join(script_path, 'media', 'apched')

ln_output = subprocess.call(['ln', '-s', '/var/log/apache2', test_path])

if ln_output == 0:
	print "it was true."
else:
	print "it was false."
