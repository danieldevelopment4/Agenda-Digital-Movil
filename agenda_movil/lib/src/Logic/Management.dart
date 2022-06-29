import 'dart:async';

import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Management with Validator{

  //Streams
  //login
  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  //register
  final _passwordConfirmationStream = BehaviorSubject<String>();
  //subject
  final _subjectId = BehaviorSubject<String>();
  final _subjectName = BehaviorSubject<String>();


  //streams whit validated
  //login
  Stream<String> get emailStream => _emailStream.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStream.stream.transform(validatePassword);
  Stream<bool> get buttonLoginStream =>  CombineLatestStream.combine2(emailStream, passwordStream, (e, p){return (e==p)?true:false;});//combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //register
  Stream<String> get passwordConfirmationStream => _passwordConfirmationStream.stream.transform(validatePassword);
  Stream<bool> get buttonRegisterStream =>  CombineLatestStream.combine3(emailStream, passwordStream, passwordConfirmationStream, (e, p, pc)=>true);//combina 3 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //subject
  Stream<String> get subjectIdStream => _subjectId.stream.transform(validateSubjectId);
  Stream<String> get subjectNameStream => _subjectName.stream.transform(validateSubjectName);

  //add data to stream
  //login
  Function(String) get changeEmail => _emailStream.sink.add;
  Function(String) get changePassword => _passwordStream.sink.add;
  //register
  Function(String) get changePasswordConfirmation => _passwordConfirmationStream.sink.add;
  //subject
  Function(String) get changeSubjectId => _subjectId.sink.add;
  Function(String) get changeSubjectName => _subjectName.sink.add;

  //get lasted data on the stream
  // String get email => _emailStream.value;
  // String get password => _passwordStream.value;

  dispose(){
    _emailStream.close();
    _passwordStream.close();
    _passwordConfirmationStream.close();
    _subjectId.close();
    _subjectName.close();
  }
//BottonMenuBar
  int _currentIndex = -1;

  int get getIndex{
    return _currentIndex;
  }

  set setIndex(int index){
    _currentIndex = index;
  }

}