import 'dart:async';

class CounterBloc {
  /// StreamController to handle event stream
  final _eventController = StreamController<CounterEvent>();
  Stream<CounterEvent> get eventStream => _eventController.stream;
  Sink<CounterEvent> get eventSink => _eventController.sink;

  /// StreamController to handle counter stream
  final _counterController = StreamController<int>();
  Stream<int> get counterStream => _counterController.stream;
  Sink<int> get counterSink => _counterController.sink;

  /// manage counter
  /// initial value of counter is 0
  int _counter = 0;

  CounterBloc();

  /// call this method to close all the streams
  /// call this method in dispose method of stateful widget
  /// always a good practice to close all the stream at the end
  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}

/// Events triggered from view 
enum CounterEvent {
/// Increment counter event
  Increment,
}