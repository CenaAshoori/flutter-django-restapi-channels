from django.urls import path
from .views import register,logout
from rest_framework.authtoken.views import  obtain_auth_token
urlpatterns = [
    path('register/', register),
    path('login/', obtain_auth_token),
    path('logout/', logout),
]
