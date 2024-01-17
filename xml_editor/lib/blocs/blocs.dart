import 'dart:async';

class Bloc {
  final sourcesController = StreamController<String>.broadcast();
  final errorcontroller = StreamController<String>.broadcast();

  Function(String) get updatecontent => sourcesController.sink.add;

  Stream<String> get content => sourcesController.stream;

  Function(String) get updateerror => errorcontroller.sink.add;

  Stream<String> get error => errorcontroller.stream;
}
