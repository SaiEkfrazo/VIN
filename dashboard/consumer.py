import json
from channels.generic.websocket import AsyncWebsocketConsumer

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.room_group_name = 'notifications'

        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        print('connetcted')
        await self.accept()

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        pass

    async def send_notification(self, event):
        notification = event['notification']

        await self.send(text_data=json.dumps({
            'notification': notification
        }))
