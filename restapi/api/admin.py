from django.contrib import admin

# Register your models here.
from .models import VideosDb
from .models import ProgressDb

admin.site.register(VideosDb)
admin.site.register(ProgressDb)

