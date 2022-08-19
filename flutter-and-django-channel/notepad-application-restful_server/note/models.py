from django.db import models
from account.models import MyUser
# Create your models here.

class Note(models.Model):
    user = models.ForeignKey(MyUser, models.DO_NOTHING, blank=True, null=True)       
    title = models.CharField(max_length=255, blank=True, null=True)
    text = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'note'