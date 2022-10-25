// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Streams with Validator{

  //students-logib-register
  final _emailStream = BehaviorSubject<String>();
  final _passwordStream = BehaviorSubject<String>();
  final _nameStream = BehaviorSubject<String>();
  final _lastNameStream = BehaviorSubject<String>();
  //matter
  final _matterIdStream = BehaviorSubject<String>();
  final _matterNameStream = BehaviorSubject<String>();
  //activity
  final _activityNameStream = BehaviorSubject<String>();
  final _activityDescriptionStream = BehaviorSubject<String>();
  final _activityPercentStream = BehaviorSubject<String>();
  final _activityNoDaysRecordatoriesStream = BehaviorSubject<String>();
  final _activitySubmissionDateStream = BehaviorSubject<String>();
  final _activityTermStream = BehaviorSubject<String>();

  //streams whit validated
  //students-logib-register
  Stream<String> get emailStream => _emailStream.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordStream.stream.transform(validatePassword);
  Stream<bool> get buttonLoginStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p)=>true); //combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  Stream<String> get nameStream => _nameStream.stream.transform(validateName);
  Stream<String> get lastNameStream => _lastNameStream.stream.transform(validateLastName);
  Stream<bool> get buttonRegisterStream => CombineLatestStream.combine4(nameStream, lastNameStream, emailStream, passwordStream, (n, l, e, p) =>  true); //combina 4 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  //matter
  Stream<String> get matterIdStream => _matterIdStream.stream.transform(validateMatterId);
  Stream<String> get matterNameStream => _matterNameStream.stream.transform(validateMatterName);
  //activity
  Stream<String> get activityNameStream => _activityNameStream.stream.transform(validateActivityName);
  Stream<String> get activityDescriptionStream => _activityDescriptionStream.stream.transform(validateActivityDescription);
  Stream<String> get activityPercentStream => _activityPercentStream.stream.transform(validateActivityPercent);
  Stream<String> get activityNoDaysRecordatoriesStream => _activityNoDaysRecordatoriesStream.stream.transform(validateActivityNoDaysRecordatories);
  Stream<String> get activitySubmissionDateStream => _activitySubmissionDateStream.stream.transform(validateActivitySubmissionDateStream);
  Stream<String> get activityTermStream => _activityTermStream.stream.transform(validateActivityTerm);
  Stream<bool> get buttonCreateActivityStream => CombineLatestStream.combine5(activityNameStream, activityPercentStream, activityNoDaysRecordatoriesStream, activitySubmissionDateStream, activityTermStream, (n, p, nd, sd, t) =>  true);


  //add data to stream
  //students-logib-register
  Function(String) get changeEmail => _emailStream.sink.add;
  Function(String) get changePassword => _passwordStream.sink.add;
  Function(String) get changeName => _nameStream.sink.add;
  Function(String) get changeLastName => _lastNameStream.sink.add;
  //matter
  Function(String) get changeMatterId => _matterIdStream.sink.add;
  Function(String) get changeMatterName => _matterNameStream.sink.add;
  //activity
  Function(String) get changeActivityName => _activityNameStream.sink.add;
  Function(String) get changeActivityDescription => _activityDescriptionStream.sink.add;
  Function(String) get changeActivityPercent => _activityPercentStream.sink.add;
  Function(String) get changeActivityNoDaysRecordatories => _activityNoDaysRecordatoriesStream.sink.add;
  Function(String) get changeActivitySubmissionDate => _activitySubmissionDateStream.sink.add;
  Function(String) get changeActivityTerm => _activityTermStream.sink.add;

  //get lasted data on the stream
  //student-register-login
  String get name => _nameStream.value;
  String get lastName => _lastNameStream.value;
  String get email => _emailStream.value;
  String get password => _passwordStream.value;
  //matter
  String get matterId => _matterIdStream.value;
  String get matterName => _matterNameStream.value;
  //activity
  String get activityName => _activityNameStream.value;
  String get activityDescription => _activityDescriptionStream.value;
  String get activityPercent => _activityPercentStream.value;
  String get activityNoDaysRecordatories => _activityNoDaysRecordatoriesStream.value;
  String get activitySubmissionDate => _activitySubmissionDateStream.value;
  String get activityTerm => _activityTermStream.value;

  //reset stream
  //students-logib-register
  void resetName(){
    _nameStream.sink.add("");
    _nameStream.sink.addError("null");
  }
  void resetLastName(){
    _lastNameStream.sink.add("");
    _lastNameStream.sink.addError("null");
  }
  void resetEmail(){
    _emailStream.sink.add("");
    _emailStream.sink.addError("null");
  }
  void resetPassword(){
    _passwordStream.sink.add("");
    _passwordStream.sink.addError("null");
  }
  //matter
  void resetMatterId(){
    _matterIdStream.sink.add("");
    _matterIdStream.sink.addError("null");
  }
  void resetMatterName(){
    _matterNameStream.sink.add("");
    _matterNameStream.sink.addError("null");
  }
  //activity
  void resetActivityName(){
    _activityNameStream.sink.add("");
    _activityNameStream.sink.addError("null");
  }
  void resetActivityDescription(){
    _activityDescriptionStream.sink.add("");
    _activityDescriptionStream.sink.addError("null");
  }
  void resetActivityPercentn(){
    _activityPercentStream.sink.add("");
    _activityPercentStream.sink.addError("null");
  }
  void resetActivityNoDaysRecordatories(){
    _activityNoDaysRecordatoriesStream.sink.add("");
    _activityNoDaysRecordatoriesStream.sink.addError("null");
  }
  void resetActivitySubmissionDaten(){
    _activitySubmissionDateStream.sink.add("");
    _activitySubmissionDateStream.sink.addError("null");
  }
  void resetActivityTerm(){
    _activityTermStream.sink.add("");
    _activityTermStream.sink.addError("null");
  }

  dispose() {
    //student-login-register
    _emailStream.close();
    _passwordStream.close();
    _nameStream.close();
    _lastNameStream.close();
    //matter
    _matterNameStream.close();
    _matterIdStream.close();
    //activity
    _activityNameStream.close();
    _activityDescriptionStream.close();
    _activityPercentStream.close();
    _activityNoDaysRecordatoriesStream.close();
    _activitySubmissionDateStream.close();
    _activityTermStream.close();
  }

}