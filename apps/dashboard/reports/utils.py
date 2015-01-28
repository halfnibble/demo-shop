from oscar.apps.dashboard.reports.utils import GeneratorRepository as \
    ParentGenerator
from apps.dashboard.inventory.reports import ImportReportGenerator

class GeneratorRepository(ParentGenerator):
    generators = ParentGenerator.generators + [
        ImportReportGenerator,
    ]

