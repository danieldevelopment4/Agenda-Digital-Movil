// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Streams with Validator{

  //login
  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  //register
  final _nameStream = BehaviorSubject<String>();
  final _lastNameStream = BehaviorSubject<String>();
  //matter
  final _matterIdStream = BehaviorSubject<String>();
  final _matterNameStream = BehaviorSubject<String>();

  //streams whit validated
  //login
  Stream<String> get emailStream => _emailStream.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStream.stream.transform(validatePassword);
  Stream<bool> get buttonLoginStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p)=>true); //combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //register
  Stream<String> get nameStream => _nameStream.stream.transform(validateName);
  Stream<String> get lastNameStream => _lastNameStream.stream.transform(validateLastName);
  Stream<bool> get buttonRegisterStream => CombineLatestStream.combine4(nameStream, lastNameStream, emailStream, passwordStream, (n, l, e, p) =>  true); //combina 4 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //matter
  Stream<String> get matterIdStream => _matterIdStream.stream.transform(validateMatterId);
  Stream<String> get matterNameStream => _matterNameStream.stream.transform(validateMatterName);

  //add data to stream
  //login
  Function(String) get changeEmail => _emailStream.sink.add;
  Function(String) get changePassword => _passwordStream.sink.add;
  //register
  Function(String) get changeName => _nameStream.sink.add;
  Function(String) get changeLastName => _lastNameStream.sink.add;
  //matter
  Function(String) get changeMatterId => _matterIdStream.sink.add;
  Function(String) get changeMatterName => _matterNameStream.sink.add;

  //get lasted data on the stream
  //register
  String get name => _nameStream.value;
  String get lastName => _lastNameStream.value;
  String get email => _emailStream.value;
  String get password => _passwordStream.value;
  //matter
  String get matterId => _matterIdStream.value;
  String get matterName => _matterNameStream.value;

  //reset stream
  //matter
  void resetMatterId(){
    _matterIdStream.sink.add("");
    _matterIdStream.sink.addError("null");
  }
  void resetMatterName(){
    _matterNameStream.sink.add("");
    _matterNameStream.sink.addError("null");
  }

  dispose() {
    _emailStream.close();
    _passwordStream.close();
    _nameStream.close();
    _matterNameStream.close();
    _matterIdStream.close();
    _matterNameStream.close();
  }

}