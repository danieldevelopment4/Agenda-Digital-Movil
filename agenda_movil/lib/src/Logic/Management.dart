import 'dart:async';

import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Management with Validator{

  //Streams
  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  final _passwordConfirmationStream = BehaviorSubject<String>();
  final _subjectId = BehaviorSubject<String>();

  //streams whit validated
  //login
  Stream<String> get emailStream => _emailStream.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStream.stream.transform(validatePassword);
  Stream<bool> get buttonLoginStream =>  CombineLatestStream.combine2(emailStream, passwordStream, (e, p)=>true);//combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //register
  Stream<String> get passwordConfirmationStream => _passwordConfirmationStream.stream.transform(validatePassword);
  Stream<bool> get buttonRegisterStream =>  CombineLatestStream.combine3(emailStream, passwordStream, passwordConfirmationStream, (e, p, pc)=>true);//combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //subject
  Stream<String> get subjectIdStream => _subjectId.stream.transform(validateSubjectId);

  //add data to stream
  //login
  Function(String) get changeEmail => _emailStream.sink.add;
  Function(String) get changePassword => _passwordStream.sink.add;
  //register
  Function(String) get changePasswordConfirmation => _passwordConfirmationStream.sink.add;
  //subject
  Function(String) get changeSubjectId => _subjectId.sink.add;

  //get lasted data on the stream
  // String get email => _emailStream.value;
  // String get password => _passwordStream.value;

  dispose(){
    _emailStream.close();
    _passwordStream.close();
    _passwordConfirmationStream.close();
    _subjectId.close();
  }

  int _currentIndex = 0;

  int get getIndex{
    return _currentIndex;
  }

  set setIndex(int index){
    _currentIndex = index;
  }

}