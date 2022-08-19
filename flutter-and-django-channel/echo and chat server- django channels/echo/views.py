from curses.ascii import HT
from django.shortcuts import render, HttpResponse
from django.utils.safestring import mark_safe
import json
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
# Create your views here.


def mainview(request):
    return render(request, 'echo/index.html')


def join_chat(request, username):
    return render(request, 'echo/join_chat.html', {'username_json': mark_safe(json.dumps(username))})


def new_chat(request, username):
    channel = get_channel_layer()
    text = request.GET['text']
    receiver = request.GET['receiver']
    group_name = f'chat_{receiver}'
    async_to_sync(channel.group_send)(
        group_name,
        {
            'type': 'chat_message',
            'message': json.dumps({
                'sender': username,
                'receiver': receiver,
                'text': text
            })
        }
    )
    return HttpResponse("Done")
