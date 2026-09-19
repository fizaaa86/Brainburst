from rest_framework import serializers
from django.contrib.auth import authenticate
from .models import VideosDb, ProgressDb
from django.contrib.auth import get_user_model

User = get_user_model()


class UserRegister(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['username', "password", "email"]

    def save(self):
        reg = User(
            email=self.validated_data['email'],
            username=self.validated_data['username'],
        )
        password = self.validated_data['password']
        reg.set_password(password)
        reg.save()
        return reg


class UserLogin(serializers.ModelSerializer):
    # Define the fields that will be used for login
    username = serializers.CharField()
    password = serializers.CharField()

    class Meta:
        model = User
        fields = ['username', 'password']

    def validate(self, data):
        # Validate the username and password
        username = data.get('username', None)
        password = data.get('password', None)
        # print(username)
        # print(password) 

        if username is None or password is None:
            raise serializers.ValidationError('Username and password are required')

        # Try to authenticate the user
        user = authenticate(username=username, password=password)

        if user is None:
            raise serializers.ValidationError('Invalid credentials')

        # Return the validated data
        return data


class VideoSerializer (serializers.ModelSerializer):
    class Meta:
        model = VideosDb
        fields = '__all__'


class VideoProgressSerializer (serializers.ModelSerializer):
    class Meta:
        # model = ProgressDb.objects.filter(userid=get_user_model())
        model = ProgressDb
        fields = '__all__'


