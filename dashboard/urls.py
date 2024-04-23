from django.urls import path
from .views import *


urlpatterns = [
    path('register/',SignupView.as_view(),name='signup'),
    path('login/',SigninView.as_view(),name='signin'),
    path('signup/',signup,name='signup'),
    path('signin/',signin,name='signin'),
    path('dashboard/',dashboard,name='dashboard'),
    path('reports/',ReportsAPIView.as_view(),name='reports'),
    path('report/',reports,name='report'),
    path('machine/',GetMachineList.as_view(),name='machinelist'),
    path('department/',GetDepartmentList.as_view(),name='departmentlist'),
    path('alerts/',GetAlertList.as_view(),name='alerts'),
    path('aismart/<int:defect_id>/', DefectImageView.as_view(), name='smartview'),
    path('defect/',GetDefectList.as_view(),name='Defects'),
    path('all_reports/',ReportsGet.as_view(),name='Reports all'),
    path('machine_temprature/',MachineTemperaturesAPIView.as_view(),name='Machine Temperature'),
    path('machine_temp_graph/',MachineTemperatureGraphView.as_view(),name='MachineGraph')
]