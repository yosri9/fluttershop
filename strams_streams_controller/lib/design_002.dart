import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stramsstreamscontroller/tiker_controller.dart';

class Design002 extends StatefulWidget {

  TickerController tickerController;


  Design002(this.tickerController);

  @override
  _Design002State createState() => _Design002State();
}

class _Design002State extends State<Design002> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Example'),
      ),
      body:StreamBuilder(
          stream: widget.tickerController.tickerStream,
          builder:(BuildContext context ,AsyncSnapshot<int> snapshot){
            if (snapshot.hasError){
              return Text('Error');
            }else if (!snapshot.hasData){
              return Text('Error');
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data.toString(),
                    style: TextStyle(
                        fontSize: 28
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(onPressed: (){
                        widget.tickerController.increment.add(snapshot.data);
                      } , child: Icon(Icons.add),),
                      RaisedButton(onPressed: (){
                        widget.tickerController.decrement.add(snapshot.data);
                      },child: Icon(Icons.remove),)
                    ],
                  )
                ],
              ),
            );
          }

      ) ,
    );
  }
}
