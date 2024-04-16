from django.contrib import admin

# Register your models here.
from .models import *

admin.site.register(CustomUser)
admin.site.register(Machines)
admin.site.register(Defects)
admin.site.register(Alerts)
admin.site.register(Department)
admin.site.register(Reports)
