import 'package:flutter/material.dart';
import 'package:flutterstreamsproduct/models/product.dart';
import 'package:flutterstreamsproduct/views/notes_list.dart';
import 'package:flutterstreamsproduct/views/products_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home:HomePage(),
    );
  }


}

class  HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Products List'),
      ),
      body: NotesList(),
    );
  }
}



