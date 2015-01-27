# Automate creation of super users.
from demoshop.secret import *
from usermod.models import User

# Superusers in secret.py in list format
for superuser in SUPERUSERS:
    user = User(username=superuser['username'])
    user.email = superuser['email']
    user.set_password(superuser['password'])
    user.is_superuser = True
    user.is_staff = True
    user.save()

