import datetime
import json
from django.http import response
from django.shortcuts import render
from rest_framework.permissions import IsAuthenticated
from rest_framework.status import HTTP_404_NOT_FOUND
from .serializers import CreateNoteSerizlizer, NoteRetrieveUpdateDestroySerializer
from rest_framework.generics import CreateAPIView, DestroyAPIView, ListAPIView, RetrieveUpdateDestroyAPIView
from django.db.models.query import QuerySet
from django.shortcuts import get_object_or_404
from note.models import Note

# Create your views here.


class CreateNodeView(CreateAPIView):
    permission_classes = (IsAuthenticated, )
    serializer_class = CreateNoteSerizlizer
    
create_note = CreateNodeView.as_view()


class CRUDView(RetrieveUpdateDestroyAPIView):
    permission_classes = (IsAuthenticated, )
    serializer_class = NoteRetrieveUpdateDestroySerializer
    queryset = Note.objects.all()


CRUD_Notes = CRUDView.as_view()


class ReviewAllCards(ListAPIView):
    permission_classes = (IsAuthenticated, )
    serializer_class = NoteRetrieveUpdateDestroySerializer
    queryset = Note.objects.all()

    def get_queryset(self):
        user = self.request.user
        return Note.objects.filter(user=user)

review_all_notes = ReviewAllCards.as_view()
