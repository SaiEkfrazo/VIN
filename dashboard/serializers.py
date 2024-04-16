from rest_framework import serializers
from .models import *
from django.contrib.auth.hashers import make_password

class SignUpSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        return super().create(validated_data)

    class Meta:
        model = CustomUser
        fields = ['id', 'first_name', 'last_name', 'email', 'phone_number', 'password']



class SigninSerializer(serializers.Serializer):
    email_or_phone = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        login_identifier = data.get('email_or_phone')
        password = data.get('password')

        # Check if the login_identifier is either an email, username, or phone number
        user = CustomUser.objects.filter(username=login_identifier).first()
        if user is None:
            user = CustomUser.objects.filter(email=login_identifier).first()
            if user is None:
                user = CustomUser.objects.filter(phone_number=login_identifier).first()

        if user is None or not user.check_password(password):
            raise serializers.ValidationError("Invalid login credentials.")

        data['user'] = user
        return data


class ReportsSerializer(serializers.ModelSerializer):
    # Use StringRelatedField to include name instead of foreign key ID
    alert_name = serializers.StringRelatedField(source='alert.name')
    machine_name = serializers.StringRelatedField(source='machine.name')
    department_name = serializers.StringRelatedField(source='department.name')
    defect_name = serializers.StringRelatedField(source='defect.name')


    class Meta:
        model = Reports
        fields = ['id', 'alert', 'alert_name', 'defect','defect_name', 'machine', 'machine_name', 'department', 'department_name', 'recorded_date_time', 'image', 'image_b64']


class MachineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Machines
        fields='__all__'


class DepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Department
        fields='__all__'

class AlertSerializer(serializers.ModelSerializer):
    class Meta:
        model = Alerts
        fields='__all__'

class DefectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Defects
        fields = '__all__'