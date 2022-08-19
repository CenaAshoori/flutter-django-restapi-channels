from cgitb import text
from channels.generic.websocket import WebsocketConsumer
from asgiref.sync import async_to_sync
import json


class EchoConsumer(WebsocketConsumer):
    def connect(self):
        # self.channel_layer.group_add()
        self.accept()
        # return super().connect()

    def disconnect(self, code):
        return super().disconnect(code)

    def receive(self, text_data=None, bytes_data=None):
        if text_data:
            self.send(text_data=text_data +
                      f" - {self.groups.__len__()} Sent By Server")
        elif bytes_data:
            self.send(bytes_data=bytes_data)

        # return super().receive(text_data, bytes_data)
    # def chat_message(self, event):
    #     message = event['message']
    #     self.send(text_data=message)


class CahtConsumer(WebsocketConsumer):
    def connect(self):
        self.username = self.scope['url_route']['kwargs']['username']
        self.group_name = f"chat_{self.username}"
        async_to_sync(self.channel_layer.group_add)(
            self.group_name,
            self.channel_name
        )
        print(self.groups)
        self.accept()
        # return super().connect()

    def disconnect(self, code):
        async_to_sync(self.channel_layer.group_discard)(
            self.group_name,
            self.channel_name
        )
        return super().disconnect(code)

    def receive(self, text_data=None, bytes_data=None):
        if text_data:
            text_data_json = json.loads(text_data)
            print(text_data_json)
            receiver = text_data_json['receiver']
            user_group_name = f'chat_{receiver}'

            async_to_sync(self.channel_layer.group_send)(
                user_group_name,
                {
                    'type': 'chat_message',
                    'message': text_data
                }
            )
        elif bytes_data:
            self.send(bytes_data=bytes_data)

        # return super().receive(text_data, bytes_data)
    def chat_message(self, event):
        message = event['message']
        self.send(text_data=message)
