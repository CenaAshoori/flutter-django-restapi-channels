from rest_framework import serializers
from .models import MyUser


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = MyUser
        fields = [
            "username",
            "password",
        ]

    def create(self, validated_data):
        user = MyUser.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password'],
        )

        user.save()
        return user