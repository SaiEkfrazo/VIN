from django.contrib import admin

# Register your models here.
from .models import *

admin.site.register(CustomUser)
admin.site.register(Machines)
admin.site.register(Defects)
admin.site.register(Alerts)
admin.site.register(Department)


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

