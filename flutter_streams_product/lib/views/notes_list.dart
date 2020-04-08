import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstreamsproduct/blocs/note_bloc.dart';
import 'package:flutterstreamsproduct/models/note.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NoteBloc noteBloc =NoteBloc();
  TextEditingController _textEditingController=TextEditingController();

  @override
  void dispose() {
  noteBloc.dispose();
  _textEditingController.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: noteBloc.notesStream,
      // ignore: missing_return
      builder:(BuildContext context,AsyncSnapshot snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
            // ignore: missing_return
          );
          case ConnectionState.active:

          case ConnectionState.done:

            if(snapshot.hasError){
              return Text('Error!');
            }else{
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,position){
                           return ListTile(
                             title: Text(snapshot.data[position].content),
                           );
                          }),
                    ),
                    TextFormField(
                      controller:_textEditingController ,
                    ),
                    RaisedButton(
                        child: Text('ADD NEW'),
                        onPressed: (){
                          String content=_textEditingController.text;
                          Note note=Note(content);
                          noteBloc.addNewNote.add(note);
                        }
                    )
                  ],
                ),
              );
            }
            break;
        }
      } ,
    );
  }
}
