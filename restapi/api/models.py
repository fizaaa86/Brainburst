from django.db import models
from django.contrib.auth.models import User


# Create your models here.
class VideosDb(models.Model):
    title = models.CharField(max_length=100)
    link = models.URLField(max_length=100)
    id = models.AutoField(primary_key=True)


class ProgressDb(models.Model):
    id = models.AutoField(primary_key=True)
    userid = models.ForeignKey(User, on_delete=models.CASCADE)
    videoId = models.ForeignKey(VideosDb, on_delete=models.CASCADE)
    watched = models.BooleanField(default=False)
