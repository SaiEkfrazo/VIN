from django.db import models
from django.contrib.auth.models import AbstractUser


class CustomUser(AbstractUser):
    first_name = models.CharField(max_length=100,blank=False,null=False)
    last_name = models.CharField(max_length=100,blank=False,null=False)
    password = models.CharField(max_length=100,blank=False,null=False)
    email = models.EmailField(blank=False,null=False,unique=True)
    phone_number = models.BigIntegerField(blank=True,null=True,unique=True)
    username = models.CharField(max_length=150, unique=True, null=True, blank=True)
    def __str__(self):
        return self.username if self.username else self.first_name
    
class Machines(models.Model):
    name = models.CharField(max_length=100,blank=False,null=False)

    def __str__(self):
        return self.name if self.name else ""
    
class Defects(models.Model):
    name = models.CharField(max_length=100,blank=False,null=False)
    color_code = models.CharField(max_length=100,blank=False,null=False)
    def __str__(self):
        return self.name if self.name else ""
    
class Alerts(models.Model):
    name = models.CharField(max_length=100,blank=False,null=False)

    def __str__(self):
        return self.name if self.name else ""
    

class Department(models.Model):
    name = models.CharField(max_length=100,blank=False,null=False)
    def __str__(self):
        return self.name if self.name else ""
    
class Reports(models.Model):
    alert = models.ForeignKey(Alerts,on_delete=models.SET_NULL,blank=True,null=True)
    defect = models.ForeignKey(Defects,on_delete=models.SET_NULL,blank=True,null=True)
    machine = models.ForeignKey(Machines,on_delete=models.SET_NULL,blank=True,null=True)
    department = models.ForeignKey(Department,on_delete=models.SET_NULL,blank=True,null=True)
    recorded_date_time = models.CharField(max_length=200,blank=True,null=True)
    image = models.ImageField(upload_to='results/',blank=True,null=True)
    image_b64 = models.ImageField(upload_to="results/",blank=True,null=True)

    # def __str__(self):
    #     return self.machine if self.machine else self.defect

class MachineTemperatures(models.Model):
    machine=models.ForeignKey(Machines,on_delete=models.CASCADE,blank=False,null=False)
    horizontal = models.CharField(max_length=100,blank=True,null=True)
    teeth= models.BooleanField(blank=True,null=True,default=False)
    coder = models.BooleanField(default=False,blank=True,null=True)
    vertical = models.CharField(max_length=10000,blank=True,null=True)
    recorded_date_time = models.DateTimeField(blank=True,null=True)