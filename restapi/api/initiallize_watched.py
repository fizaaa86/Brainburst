from .models import User, VideosDb, ProgressDb


def initialize_watched():
    users = User.objects.all()
    videos = VideosDb.objects.all()
    progresses = ProgressDb.objects.all()

    for user in users:
        if not ProgressDb.objects.filter(userid=user).exists():
            for video in videos:
                ProgressDb.objects.create(userid=user, videoId=video, watched=False)

    for progress in progresses:
        if progress.userid not in users:
            ProgressDb.objects.filter(userid=progress.userid).delete()


def update_watched(video_id, user_id):
    to_update = ProgressDb.objects.filter(userid=user_id,videoId=video_id).first()
    to_update.watched = True
