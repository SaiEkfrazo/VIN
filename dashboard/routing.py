from django.urls import path
from .consumer import *

websocket_urlpatterns = [
    path('ws/notifications/', NotificationConsumer.as_asgi()),
]
