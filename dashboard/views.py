from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import *
from django.utils import timezone
from django.shortcuts import render
from rest_framework import generics

class SignupView(APIView):
    def post(self, request, format=None):
        serializer = SignUpSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message":"User signup successfully"}, status=status.HTTP_201_CREATED)
        return Response({"message":serializer.errors}, status=status.HTTP_400_BAD_REQUEST)



class SigninView(APIView):
    def post(self, request, format=None):
        serializer = SigninSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data['user']
            
            user.last_login = timezone.now()
            user.save()

            return Response({"message": "LoggedIn Successfully"}, status=status.HTTP_200_OK)
        return Response({'message':serializer.errors}, status=status.HTTP_401_UNAUTHORIZED)
    

def signup(request):
    return render(request,'signup.html')

def signin(request):
    return render(request,'signin.html')

def dashboard(request):
    return render(request,'dashboard.html')


import base64
from django.core.files.base import ContentFile
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Reports
from .serializers import ReportsSerializer
import uuid
from django.utils.dateparse import parse_datetime
from django.utils.timezone import make_aware

from django.core.mail import send_mail
from django.template.loader import render_to_string
from django.utils.html import strip_tags

class ReportsAPIView(APIView):
    serializer_class = ReportsSerializer

    def get_queryset(self):
        queryset = Reports.objects.all()

        machine = self.request.query_params.get('machine')
        defect = self.request.query_params.get('defect')
        alert = self.request.query_params.get('alert')
        department = self.request.query_params.get('department')
        from_date = self.request.query_params.get('from_date')
        to_date = self.request.query_params.get('to_date')

        if machine:
            queryset = queryset.filter(machine=machine)
        if defect:
            queryset = queryset.filter(defect=defect)
        if alert:
            queryset = queryset.filter(alert=alert)
        if department:
            queryset = queryset.filter(department=department)
        if from_date and to_date:
            from_date = make_aware(parse_datetime(from_date))
            to_date = make_aware(parse_datetime(to_date))
            queryset = queryset.filter(recorded_date_time__range=(from_date, to_date))

        # Order queryset by recorded_date_time
        queryset = queryset.order_by('recorded_date_time')

        return queryset.order_by('-id')

    def post(self, request):
        data = request.data
        if 'image_b64' in data:
            image_data = data.pop('image_b64')
            image_data = base64.b64decode(image_data)
            unique_filename = str(uuid.uuid4()) + '.jpg'
            data['image_b64'] = ContentFile(image_data, name=unique_filename)

        serializer = ReportsSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            
            # # Send email
            # subject = 'New Report Submitted'
            # recipient_email = 'saithimma@ekfrazo.in' 
            # sender_email = 'saitreddy06@gmail.com' 
            
            # # Append base URL to the image link
            # base_url = 'http://127.0.0.1:8000'  # Replace 'example.com' with your actual base URL
            # image_link = base_url + serializer.data['image_b64']
            
            # # Render email template
            # context = {
            #     'alert_name': serializer.data['alert_name'],
            #     'defect_name': serializer.data['defect_name'],
            #     'department_name': serializer.data['department_name'],
            #     'image_link': image_link,
            #     'recorded_date_time': serializer.data['recorded_date_time'],
            # }
            # html_message = render_to_string('email_template.html', context)
            # plain_message = strip_tags(html_message)  # Strip HTML tags for plain text version
            
            # # Send email
            # send_mail(
            #     subject,
            #     plain_message,
            #     sender_email,
            #     [recipient_email],
            #     html_message=html_message,
            # )
            
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    


    def get(self, request):
        queryset = self.get_queryset()
        serializer = ReportsSerializer(queryset, many=True, context={'request': request})
        # Modify image_b64 field to include the correct absolute URL with port
        # base_url = f"http://127.0.0.1:{settings.PORT}"  # Assuming PORT is set in your settings
        for item in serializer.data:
            if item['image_b64']:
                item['image_b64'] = {item['image_b64']}  # Construct absolute URL with port
        return Response(serializer.data)

    

def reports(request):
    return render(request,'reports.html')


class GetMachineList(generics.ListCreateAPIView):
    queryset= Machines.objects.all()
    serializer_class = MachineSerializer


class GetDepartmentList(generics.ListCreateAPIView):
    queryset = Department.objects.all()
    serializer_class = DepartmentSerializer

class GetDefectList(generics.ListCreateAPIView):
    queryset = Defects.objects.all()
    serializer_class = DefectSerializer  

class GetAlertList(generics.ListCreateAPIView):
    queryset = Alerts.objects.all()
    serializer_class = AlertSerializer

from django.http import JsonResponse
from django.conf import settings

# class DefectImageView(APIView):
#     def get(self, request, defect_id):
#         try:
#             # Retrieve all reports with the specified defect_id
#             reports = Reports.objects.filter(defect_id=defect_id)

#             # Check if any reports are found
#             if reports.exists():
#                 # Construct base URL
#                 base_url = request.build_absolute_uri('/')[:-1]
                
#                 # Return a list of image URLs with base URL attached
#                 image_urls = [base_url + report.image_b64.url for report in reports if report.image_b64]
#                 return JsonResponse({'defect_images': image_urls})
#             else:
#                 # Return 404 if no reports are found
#                 return Response({"message":'No Reports Found For This Defect'})
#         except Reports.DoesNotExist:
#             return Response(status=status.HTTP_404_NOT_FOUND)


from django.utils import timezone

class DefectImageView(APIView):
    def get(self, request, defect_id):
        try:
            # Retrieve all reports with the specified defect_id, ordered by recorded date-time in descending order
            reports = Reports.objects.filter(defect_id=defect_id).order_by('-id')

            # Check if any reports are found
            if reports.exists():
                # Construct base URL
                base_url = request.build_absolute_uri('/')[:-1]
                
                # Initialize a list to store the response data
                response_data = []

                # Iterate over each report
                for report in reports:
                    # Check if the report has an image
                    if report.image_b64:
                        # Construct the image URL
                        image_url = base_url + report.image_b64.url

                        # Extract machine name and recorded date-time
                        machine_name = report.machine.name if report.machine else None
                        recorded_date_time = report.recorded_date_time.strftime("%Y-%m-%d %H:%M:%S") if report.recorded_date_time else None

                        # Create a dictionary with image URL, machine name, and recorded date-time
                        image_data = {
                            "image_url": image_url,
                            "machine_name": machine_name,
                            "recorded_date_time": recorded_date_time
                        }

                        # Append the image data to the response list
                        response_data.append(image_data)

                # Return the response data as JSON
                return JsonResponse({'defect_images': response_data})
            else:
                # Return 404 if no reports are found
                return Response({"message":'No Reports Found For This Defect'}, status=status.HTTP_404_NOT_FOUND)
        except Reports.DoesNotExist:
            return Response(status=status.HTTP_404_NOT_FOUND)

