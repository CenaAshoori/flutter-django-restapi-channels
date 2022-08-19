from django.urls import path
from echo import views

urlpatterns = [
    path('', views.mainview),
    path('chat/<str:username>/', views.join_chat, name='join_chat'),
    path('chat_new/<str:username>/', views.new_chat, name='new_chat'),
]
