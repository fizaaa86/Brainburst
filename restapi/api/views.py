from django.http import HttpResponse, JsonResponse
from django.shortcuts import render
from .initiallize_watched import initialize_watched

from .models import VideosDb, ProgressDb
from .serializers import UserLogin, UserRegister, VideoSerializer,VideoProgressSerializer
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from django.contrib.auth import login as autologin, authenticate, get_user, logout
from django.core import serializers


from rest_framework.permissions import IsAuthenticated


class Register(APIView):

    @staticmethod
    def post(request):
        serializer = UserRegister(data=request.data)
        data = {}
        if serializer.is_valid():
            account = serializer.save()
            data['response'] = 'registered'
            data['username'] = account.username
            data['email'] = account.email
            token = Token.objects.get_or_create(user=account).key
            data['token'] = token
        else:
            data = serializer.errors
        return Response(data)


class Login(APIView):

    @staticmethod
    def post(request):
        serializer = UserLogin(data=request.data)
        data = {}
        print("request")
        if serializer.is_valid():
            username = serializer.validated_data['username']
            password = serializer.validated_data['password']
            print(username)
            user = authenticate(username=username, password=password)
            print(user)
            if user is not None:
                # print(user)
                autologin(request, user)
                data['response'] = 'logged in'
                data['username'] = user.username
                data['email'] = user.email
                token = Token.objects.get(user=user).key
                data['token'] = token
                # return render(request, 'index.html', data)
                print(data)
            else:
                data['response'] = 'invalid credentials'
        else:
            data = serializer.errors
        return Response(data)


class Welcome(APIView):
    permission_classes = (IsAuthenticated,)

    @staticmethod
    def get(request):
        content = {'user': str(request.user), 'userid': str(request.user.id)}
        return Response(content)


class Videos(APIView):

    @staticmethod
    def get(self):
        data = VideoSerializer(VideosDb.objects.all(), many=True).data
        return JsonResponse(data, safe=False)


def progress_view(request):

    initialize_watched()
    progress = ProgressDb.objects.filter(userid=get_user(request))
    return render(request, 'progress.html', {'Progress': progress})


class Progress(APIView):

    @staticmethod
    def get(request):
        user_id = request.GET.get('user_id')
        data = VideoProgressSerializer(ProgressDb.objects.filter(userid=user_id), many=True).data
        print(data)
        return JsonResponse(data, safe=False)


class UpdateProgress(APIView):

    @staticmethod
    def post(request):
        video_id = request.data.get('video_id')  # Assuming video_id is passed in the request data
        user_id = request.data.get('user_id')  # Assuming user_id is passed in the request data
        # user_id = request.user.id  # Assuming user_id is passed in the request data

        if video_id is None or user_id is None:
            return Response({'error': 'video_id and user_id are required'}, status=400)

        to_update = ProgressDb.objects.filter(userid=user_id, videoId=video_id).first()

        if to_update is None:
            return Response({'error': 'Progress not found for the given video_id and user_id'}, status=404)

        to_update.watched = True
        to_update.save()

        return Response({'success': 'Progress updated successfully'})


