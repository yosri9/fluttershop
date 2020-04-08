import 'package:flutter/material.dart';
import 'package:stramsstreamscontroller/design_001.dart';
import 'package:stramsstreamscontroller/design_002.dart';
import 'package:stramsstreamscontroller/tiker_controller.dart';

void main() => runApp(StreamExample());

class StreamExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  StreamExampleHome(),
    );
  }
}

class StreamExampleHome extends StatefulWidget {
  @override
  _StreamExampleHomeState createState() => _StreamExampleHomeState();
}

class _StreamExampleHomeState extends State<StreamExampleHome> {
  final TickerController tickerController=TickerController();
 

  @override
  Widget build(BuildContext context) {
    return Design002(tickerController);
  }
}







