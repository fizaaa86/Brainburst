from django.contrib import admin
from django.urls import path
from api import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('register', views.Register.as_view(), name='register'),
    path('login', views.Login.as_view(), name='login'),
    path('welcome', views.Welcome.as_view(), name='welcome'),
    path('videos', views.Videos.as_view(), name='videos'),
    path('progress', views.Progress.as_view(), name='progress'),
    path('uprogress', views.UpdateProgress.as_view(), name='update_progress'),

    path('', views.progress_view, name='progress')

]
