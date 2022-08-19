from rest_framework import serializers
from django.shortcuts import get_object_or_404
from note.models import Note

class CreateNoteSerizlizer(serializers.ModelSerializer):
    class Meta:
        model = Note
        fields = "__all__"
    def create(self, validated_data):
            note = Note.objects.create(
                user = self.context['request'].user,
                **validated_data
            )
            note.save()
            return note
class NoteRetrieveUpdateDestroySerializer(serializers.ModelSerializer):
    class Meta:
        model = Note
        fields = "__all__"