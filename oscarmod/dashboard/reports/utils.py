from oscar.apps.dashboard.reports.utils import GeneratorRepository as \
    ParentGenerator
from inventory.reports import ImportReportGenerator

class GeneratorRepository(ParentGenerator):
    generators = ParentGenerator.generators + [
        ImportReportGenerator,
    ]

