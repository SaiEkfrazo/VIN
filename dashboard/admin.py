from django.contrib import admin

# Register your models here.
from .models import *

from import_export import resources
from import_export.admin import ImportExportModelAdmin

admin.site.register(CustomUser)

@admin.register(Machines)
class MachinesAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    search_fields = ('name',)

@admin.register(Defects)
class DefectsAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name', 'color_code', 'consecutive_count', 'last_occurrence_time')
    search_fields = ('name', 'color_code')

@admin.register(Alerts)
class AlertsAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    search_fields = ('name',)

@admin.register(Department)
class DepartmentAdmin(ImportExportModelAdmin):
    list_display = ('id', 'name')
    search_fields = ('name',)





from django.contrib import admin
from .models import Reports

class ReportsAdmin(admin.ModelAdmin):
    list_display = ('id', 'alert', 'defect', 'machine', 'department', 'recorded_date_time')
    search_fields = ('defect__name', 'recorded_date_time')  # Add search functionality by defect name and recorded_date_time
    
    # Define a custom action for deletion
    def delete_selected(self, request, queryset):
        for obj in queryset:
            obj.delete()
        self.message_user(request, "Selected reports were successfully deleted.")
    delete_selected.short_description = "Delete selected reports"  # Custom action label

    # Register the custom action
    actions = ['delete_selected']

admin.site.register(Reports, ReportsAdmin)


@admin.register(MachineParameters)
class DepartmentAdmin(ImportExportModelAdmin):
    list_display = ('id','parameter', 'color_code')

admin.site.register(MachineParametersGraph)

# some comment 