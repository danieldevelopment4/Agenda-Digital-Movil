import 'dart:async';

import 'package:agenda_movil/src/Logic/API/LogingRequest.dart';
import 'package:agenda_movil/src/Logic/API/RegisterRequest.dart';
import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Management with Validator {
  //Streams
  //login
  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  //register
  final _nameStream = BehaviorSubject<String>();
  final _lastNameStream = BehaviorSubject<String>();
  //subject
  final _subjectId = BehaviorSubject<String>();
  final _subjectName = BehaviorSubject<String>();

  //streams whit validated
  //login
  Stream<String> get emailStream => _emailStream.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStream.stream.transform(validatePassword);
  Stream<bool> get buttonLoginStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p)=>true); //combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //register
  Stream<String> get nameStream => _nameStream.stream.transform(validateName);
  Stream<String> get lastNameStream => _lastNameStream.stream.transform(validateLastName);
  Stream<bool> get buttonRegisterStream => CombineLatestStream.combine4(nameStream, lastNameStream, emailStream, passwordStream, (n, l, e, p) =>  true); //combina 4 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //subject
  Stream<String> get subjectIdStream => _subjectId.stream.transform(validateSubjectId);
  Stream<String> get subjectNameStream => _subjectName.stream.transform(validateSubjectName);

  //add data to stream
  //login
  Function(String) get changeEmail => _emailStream.sink.add;
  Function(String) get changePassword => _passwordStream.sink.add;
  //register
  Function(String) get changeName => _nameStream.sink.add;
  Function(String) get changeLastName => _lastNameStream.sink.add;
  //subject
  Function(String) get changeSubjectId => _subjectId.sink.add;
  Function(String) get changeSubjectName => _subjectName.sink.add;

  //get lasted data on the stream
  //register
  String get name => _nameStream.value;
  String get lastName => _lastNameStream.value;
  String get email => _emailStream.value;
  String get password => _passwordStream.value;

  dispose() {
    _emailStream.close();
    _passwordStream.close();
    _nameStream.close();
    _subjectName.close();
    _subjectId.close();
    _subjectName.close();
  }

//BottonMenuBar
  int _currentIndex = 0;

  int get getIndex {
    return _currentIndex;
  }

  set setIndex(int index) {
    _currentIndex = index;
  }

  Future<Map<String, dynamic>> logingRequest(Map<String, String> body) {
    return LogingRequest().loggin(body);
  }

  Future<Map<String, dynamic>> registerRequest(Map<String, String> body) {
    return RegisterRequest().register(body);
  }
}
