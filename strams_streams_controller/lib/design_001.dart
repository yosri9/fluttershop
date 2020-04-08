import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stramsstreamscontroller/tiker_controller.dart';

class Design001 extends StatefulWidget {
 final TickerController tickerController;


  Design001(this.tickerController);

  @override
  _Design001State createState() => _Design001State();
}

class _Design001State extends State<Design001> {

  @override
  void dispose() {
  widget.tickerController.dispose();
super.dispose();
  }
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
                  Row(
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
