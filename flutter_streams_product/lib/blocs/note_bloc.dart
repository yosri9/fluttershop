import 'dart:async';

import 'package:flutterstreamsproduct/contracts/disposable.dart';
import 'package:flutterstreamsproduct/models/note.dart';

class NoteBloc implements Disposable{
List<Note> notes;

final StreamController <List<Note>> _notesController =StreamController<List<Note>>();
Stream <List<Note>> get notesStream =>_notesController.stream;
StreamSink <List<Note>> get notesSink =>_notesController.sink ;

final StreamController<Note> _noteController= StreamController<Note>();
StreamSink <Note> get addNewNote=> _noteController.sink;


NoteBloc(){
 notes=[];
 _notesController.add(notes);
 _noteController.stream.listen(_addNote);

}

void _addNote(Note note){
  notes.add(note);
  notesSink.add(notes);
}

@override
  void dispose() {
    _notesController.close();
    _noteController.close();
  }

}