import 'dart:async';

import 'package:generalsop/contracts/contracts.dart';

class DotsStream implements Disposable{
  int currentDot;
  StreamController<int> _dotsStreamController = StreamController<int>.broadcast();
  Stream<int> get dots =>_dotsStreamController.stream;
  StreamSink<int> get dotsSink => _dotsStreamController.sink;


  DotsStream(){
   _dotsStreamController.add(currentDot);
   _dotsStreamController.stream.listen( _indexChange ) ;
  }
  void _indexChange( int newIndex){
    print("loaded2");
    currentDot = newIndex;
    _dotsStreamController.add(currentDot);
  }

  @override
  void dispose() {
    _dotsStreamController.close();
  }
}