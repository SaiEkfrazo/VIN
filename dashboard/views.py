from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from .serializers import *
from django.utils import timezone
from django.shortcuts import render
from rest_framework import generics
from django.db.models import F
from django.utils.dateparse import parse_datetime
from datetime import timedelta


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
from django.utils.timezone import make_aware
from datetime import datetime
from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer

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

        # Calculate the default date range (last seven days)
        today = datetime.today().date()
        seven_days_ago = today - timedelta(days=7)

        if from_date and to_date:
            # Convert string dates to datetime objects
            from_date = make_aware(parse_datetime(from_date))
            to_date = make_aware(parse_datetime(to_date))

            # Adjust to_date to the end of the day
            to_date = to_date + timedelta(days=1) - timedelta(seconds=1)
        else:
            # Use the default date range
            from_date = make_aware(datetime.combine(seven_days_ago, datetime.min.time()))
            to_date = make_aware(datetime.combine(today, datetime.max.time()))

        # Apply filters
        if machine:
            queryset = queryset.filter(machine=machine)
        if defect:
            queryset = queryset.filter(defect=defect)
        if alert:
            queryset = queryset.filter(alert=alert)
        if department:
            queryset = queryset.filter(department=department)
        
        # Filter based on the date range
        queryset = queryset.filter(
            recorded_date_time__gte=from_date.strftime('%Y-%m-%d %H:%M:%S'),
            recorded_date_time__lte=to_date.strftime('%Y-%m-%d %H:%M:%S')
        )

        # Order queryset by recorded_date_time
        queryset = queryset.order_by('recorded_date_time')

        return queryset

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

            # Increment params_count in MachineParametersGraph
            recorded_date_time = serializer.data['recorded_date_time'][:10]

            machine_parameter = MachineParameters.objects.filter(parameter="Reject Counter").first()
            if machine_parameter:
                machine_params_obj, created = MachineParametersGraph.objects.get_or_create(
                    date_time=recorded_date_time,
                    machine_parameter=machine_parameter,
                )
                if not created:
                    machine_params_obj.params_count = F('params_count') + 1
                    machine_params_obj.save()
                else:
                    machine_params_obj.params_count = 1
                    machine_params_obj.save()

            current_defect = serializer.instance.defect
            last_three_reports = Reports.objects.order_by('-id')[:3]

            if last_three_reports.count() == 3:
                defects = [report.defect for report in last_three_reports]
                defects_match = all(defect == current_defect for defect in defects)

                if defects_match:
                    DefectNotification.objects.create(
                        defect=current_defect,
                        notification_text=f"Defect '{current_defect.name}' has occurred three times consecutively."
                    )

                    # Send the notification via WebSockets
                    channel_layer = get_channel_layer()
                    async_to_sync(channel_layer.group_send)(
                        'notifications',
                        {
                            'type': 'send_notification',
                            'notification': f"Defect '{current_defect.name}' has occurred three times consecutively."
                        }
                    )

            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    # def get(self, request):
    #     queryset = self.get_queryset()
    #     serializer = ReportsSerializer(queryset, many=True, context={'request': request})
    #     # Modify image_b64 field to include the correct absolute URL with port
    #     # base_url = f"http://127.0.0.1:{settings.PORT}"  # Assuming PORT is set in your settings
    #     for item in serializer.data:
    #         if item['image_b64']:
    #             item['image_b64'] = {item['image_b64']}  # Construct absolute URL with port
    #     return Response(serializer.data)

    def get(self, request):
        queryset = self.get_queryset()
        
        # Initialize result dictionary
        results = {}

        # Iterate over queryset to populate results dictionary
        for report in queryset:
            # Handle recorded_date_time being either a string or a datetime object
            recorded_date_time = report.recorded_date_time
            if isinstance(recorded_date_time, str):
                # Extract date from recorded date time string (assuming 'YYYY-MM-DD' format)
                recorded_date_str = recorded_date_time[:10]
                try:
                    recorded_date = datetime.strptime(recorded_date_str, '%Y-%m-%d').date()
                except ValueError:
                    continue  # Skip this report if date parsing fails
            elif isinstance(recorded_date_time, datetime):
                recorded_date = recorded_date_time.date()
            else:
                continue  # Skip this report if recorded_date_time is neither str nor datetime

            recorded_date_str = recorded_date.strftime('%Y-%m-%d')  # Convert date to string

            if recorded_date_str not in results:
                results[recorded_date_str] = {}

            defect_name = report.defect.name if report.defect else "No Defect"
            # Increment defect count for the date
            results[recorded_date_str][defect_name] = results[recorded_date_str].get(defect_name, 0) + 1

        # Return response
        return Response(results)

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
                        recorded_date_time = report.recorded_date_time if report.recorded_date_time else None

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




class ReportsGet(APIView):
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
            # Parse datetime strings into datetime objects
            from_date = parse_datetime(from_date)
            to_date = parse_datetime(to_date) + timedelta(days=1)  # Add one day to include the end of the day
            # Filter queryset by date range
            queryset = queryset.filter(recorded_date_time__range=(from_date, to_date))
            print('queryset',queryset)
        # Order queryset by recorded_date_time
        queryset = queryset.order_by('-id')
        
        return queryset

    def get(self, request):
        queryset = self.get_queryset()
        serializer = ReportsSerializer(queryset, many=True, context={'request': request})
        data = serializer.data
        # Add base URL to image_b64 field
        for report in data:
            if 'image_b64' in report:
                report['image_b64'] = request.build_absolute_uri(report['image_b64'])
        return Response(data)
class MachineTemperaturesAPIView(APIView):
    def get(self, request):
        try:
            # Get all distinct machine IDs
            machine_ids = MachineTemperatures.objects.values_list('machine_id', flat=True).distinct()

            latest_records = []
            for machine_id in machine_ids:
                # Get the latest record for the current machine ID
                latest_record = MachineTemperatures.objects.filter(machine_id=machine_id).latest('recorded_date_time')
                serializer = MachineTemperaturesSerializer(latest_record)
                latest_records.append(serializer.data)

            return Response(latest_records)
        except MachineTemperatures.DoesNotExist:
            return Response({"message": "No machine records found."}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    def post(self, request):
        serializer = MachineTemperaturesSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class MachineTemperatureGraphView(APIView):
    def get(self, request):
        machine_id = request.query_params.get('machine_id')

        if machine_id:
            all_records = MachineTemperatures.objects.filter(machine_id=machine_id)
        else:
            all_records = MachineTemperatures.objects.all()

        serializer = MachineTemperaturesSerializer(all_records, many=True)
        return Response(serializer.data)


from datetime import datetime
from collections import defaultdict

class MachineParametersGraphView(APIView):
    def get_date_only(self, date_time_str):
        # Convert the date_time string to a datetime object
        date_time = datetime.fromisoformat(date_time_str)
        # Extract the date part from the datetime object
        date_only = date_time.date()
        # Convert the date part back to a string
        date_only_str = date_only.isoformat()
        return date_only_str

    def get(self, request):
        # Retrieve all MachineParametersGraph objects
        parameters_graph = MachineParametersGraph.objects.all()

        # Aggregating counts per day
        date_aggregates = defaultdict(lambda: {'defect_count': 0, 'total_production_count': 0})

        for graph in parameters_graph:
            date_only_str = graph.date_time[:10]  # Extracting date part
            if graph.machine_parameter.parameter == "Reject Counter":
                date_aggregates[date_only_str]['defect_count'] += int(graph.params_count)
            elif graph.machine_parameter.parameter in ["Program Counter", "Machine Counter"]:
                date_aggregates[date_only_str]['total_production_count'] += int(graph.params_count)

        data = []
        for date_only_str, counts in date_aggregates.items():
            defect_count = counts['defect_count']
            total_production_count = counts['total_production_count']

            if total_production_count > 0:
                defect_percentage = (defect_count / total_production_count) * 100
            else:
                defect_percentage = 0

            data.append({
                "date_time": date_only_str,
                "defect_percentage": round(defect_percentage, 2)
            })

        # Order the data by date
        data = sorted(data, key=lambda x: datetime.fromisoformat(x['date_time']))

        return Response({"results": data}, status=status.HTTP_200_OK)

    def post(self, request):
        # Extract relevant data from the request and create or update a MachineParametersGraph object
        params_count = request.data.get('params_count')
        date_time_str = request.data.get('date_time')
        parameter_id = request.data.get('parameter')  # Assuming parameter_id is provided
        try:
            # Fetch the MachineParameters instance corresponding to the provided parameter_id
            parameter = MachineParameters.objects.get(pk=parameter_id)
            # Convert the given date_time to date only
            date_only_str = self.get_date_only(date_time_str)
            # Retrieve the existing record with the same date and parameter
            existing_graph = MachineParametersGraph.objects.filter(date_time__startswith=date_only_str, machine_parameter=parameter).first()
            if existing_graph:
                # Update the existing record's params_count by adding the new value to the existing value
                existing_graph.params_count = F('params_count') + params_count
                existing_graph.save()
                return Response({'message': 'MachineParametersGraph updated successfully'}, status=status.HTTP_200_OK)
            else:
                # Create a new MachineParametersGraph object
                graph = MachineParametersGraph.objects.create(
                    machine_parameter=parameter,
                    params_count=params_count,
                    date_time=date_time_str
                )
                return Response({'message': 'MachineParametersGraph created successfully'}, status=status.HTTP_201_CREATED)
        except MachineParameters.DoesNotExist:
            return Response({'error': 'MachineParameters not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
        

class DefectNotificationAPIView(generics.ListCreateAPIView):
    queryset = DefectNotification.objects.all()
    serializer_class = DefectNotificationSerializer