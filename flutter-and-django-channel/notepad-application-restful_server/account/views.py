from rest_framework.generics import CreateAPIView
from rest_framework import permissions, status
from rest_framework.views import APIView
from .models import MyUser
from rest_framework.views import Response
# Create your views here.

from .serializers import UserSerializer


class CreateUserView(CreateAPIView):
    model = MyUser
    permission_classes = [
        permissions.AllowAny  # Or anon users can't register
    ]
    serializer_class = UserSerializer


register = CreateUserView.as_view()


class LogoutUserView(APIView):
    permission_classes = (permissions.IsAuthenticated, )

    def get(self, request):
        request.user.auth_token.delete()
        return Response(status=status.HTTP_200_OK)


logout = LogoutUserView.as_view()