import 'dart:async';

class TickerController {
  int _ticker;

  final StreamController<int>_tickerController=StreamController<int>();
  Stream<int> get tickerStream=>_tickerController.stream;
  StreamSink<int> get tickerSink =>_tickerController.sink ;

  final StreamController<int> _incrementController=StreamController<int>();
  StreamSink<int> get increment => _incrementController.sink;

  final StreamController<int> _decrementController=StreamController<int>();
  StreamSink<int> get decrement=>_decrementController.sink;


  TickerController(){
    _ticker=0;
    _tickerController.add(_ticker);
    _incrementController.stream.listen(_incrementTicker);
    _decrementController.stream.listen(_decrementTicker);

  }

  void _incrementTicker(int ticker){
    ticker++;
    tickerSink.add(ticker);
  }

  void _decrementTicker(int ticker){
    ticker--;
    tickerSink.add(ticker) ;
  }

  void dispose(){
    _decrementController.close();
    _incrementController.close();
    _tickerController.close();
  }
}