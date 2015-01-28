from django.core.management.base import BaseCommand, CommandError

from optparse import make_option

class Command(BaseCommand):
    args = '<production> <fresh> <mysql_user> <mysql_password>'
    help = 'Upgrades or installs the demo shop.'
    option_list = BaseCommand.option_list + (
        make_option('--optionarg'
            action='no_idea-> store_true ?',
            dest='delete',
            default=False,
            help='Yada yada.'
        ),
    )

    def handle(self, *args, **options):
        """Review docs here:
        https://docs.djangoproject.com/en/1.7/howto/custom-management-commands/
        """
        self.stdout.write("Command 'upgrade' was run.")
        