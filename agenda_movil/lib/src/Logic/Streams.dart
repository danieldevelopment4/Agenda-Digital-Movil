// ignore_for_file: file_names

import 'package:agenda_movil/src/Logic/Validator.dart';
import 'package:rxdart/rxdart.dart';

class Streams with Validator{

  //students-logib-register
  final _studentEmailStream = BehaviorSubject<String>();
  final _studentPasswordStream = BehaviorSubject<String>();
  final _studentNameStream = BehaviorSubject<String>();
  final _studentLastNameStream = BehaviorSubject<String>();
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
  //submit
  final _submitNoteStream = BehaviorSubject<String>();
  final _submitStateStream = BehaviorSubject<String>();
  
  //teacher
  final _teacherIdStream = BehaviorSubject<String>();
  final _teacherNameStream = BehaviorSubject<String>();
  final _teacherLastNameStream = BehaviorSubject<String>();
  final _teacherEmailStream = BehaviorSubject<String>();
  final _teacherCellphoneStream = BehaviorSubject<String>();

  //streams whit validated
  //students-logib-register
  Stream<String> get studentEmailStream => _studentEmailStream.stream.transform(validateStudentEmail);
  Stream<String> get studentPasswordStream => _studentPasswordStream.stream.transform(validateStudentPassword);
  Stream<bool> get buttonLoginStream => CombineLatestStream.combine2(studentEmailStream, studentPasswordStream, (e, p)=>true); //combina 2 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
  Stream<String> get studentNameStream => _studentNameStream.stream.transform(validateStudentName);
  Stream<String> get studentLastNameStream => _studentLastNameStream.stream.transform(validateStudentLastName);
  Stream<bool> get buttonRegisterStream => CombineLatestStream.combine4(studentNameStream, studentLastNameStream, studentEmailStream, studentPasswordStream, (n, l, e, p) =>  true); //combina 4 streams para el stream del boton cual se habilita o desabilita o desabilita segun el contenido
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
  //submit
  Stream<String> get submitNoteStream => _submitNoteStream.stream.transform(validateSubmitNote);
  Stream<String> get submitStateStream => _submitStateStream.stream.transform(validateSubmitState);
  Stream<bool> get buttonCreateSubmitStream => CombineLatestStream.combine2(submitNoteStream, submitStateStream, (n, s) => true);
  //teacher
  Stream<String> get teacherIdStream => _teacherIdStream.stream.transform(validateTeacherId);
  Stream<String> get teacherNameStream => _teacherNameStream.stream.transform(validateTeacherName);
  Stream<String> get teacherLastNameStream => _teacherLastNameStream.stream.transform(validateTeacherLastName);
  Stream<String> get teacherEmailStream => _teacherEmailStream.stream.transform(validateTeacherEmail);
  Stream<String> get teacherCellphoneStream => _teacherCellphoneStream.stream.transform(validateTeacherCellphone);
  Stream<bool> get buttonTeacherStream => CombineLatestStream.combine4(teacherNameStream, teacherLastNameStream, teacherEmailStream, teacherCellphoneStream, (n, l, t, c) =>  true);

  //add data to stream
  //students-logib-register
  Function(String) get changeStudentEmail => _studentEmailStream.sink.add;
  Function(String) get changeStudentPassword => _studentPasswordStream.sink.add;
  Function(String) get changeStudentName => _studentNameStream.sink.add;
  Function(String) get changeStudentLastName => _studentLastNameStream.sink.add;
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
  //submit
  Function(String) get changeSubmitNote => _submitNoteStream.sink.add;
  Function(String) get changeSubmitState => _submitStateStream.sink.add;
  //teacher
  Function(String) get changeTeacherId => _teacherIdStream.sink.add;
  Function(String) get changeTeacherName => _teacherNameStream.sink.add;
  Function(String) get changeTeacherLastName => _teacherLastNameStream.sink.add;
  Function(String) get changeTeacherEmail => _teacherEmailStream.sink.add;
  Function(String) get changeTeachereCellphone => _teacherCellphoneStream.sink.add;

  //validateIfHasData
  //submit
  bool get submitStateHasData => _submitStateStream.hasValue;
  //teacher
  bool get teacherIdHasData => _teacherIdStream.hasValue;
  bool get teacherEmailHasData => _teacherEmailStream.hasValue;
  bool get teacherCellphoneHasData => _teacherCellphoneStream.hasValue;

  //get lasted data on the stream
  //student-register-login
  String get studentName => _studentNameStream.value;
  String get studentLastName => _studentLastNameStream.value;
  String get studentEmail => _studentEmailStream.value;
  String get studentPassword => _studentPasswordStream.value;
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
  //submit
  String get submitNote => _submitNoteStream.value;
  String get submitState => _submitStateStream.value;
  //teacher
  String get teacherId => _teacherIdStream.value;
  String get teacherName => _teacherNameStream.value;
  String get teacherLastName => _teacherLastNameStream.value;
  String get teacherEmail => _teacherEmailStream.value;
  String get teacherCellphone => _teacherCellphoneStream.value;

  //reset stream
  //students-logib-register
  void resetName(){
    _studentNameStream.sink.add("");
    _studentNameStream.sink.addError("null");
  }
  void resetLastName(){
    _studentLastNameStream.sink.add("");
    _studentLastNameStream.sink.addError("null");
  }
  void resetEmail(){
    _studentEmailStream.sink.add("");
    _studentEmailStream.sink.addError("null");
  }
  void resetPassword(){
    _studentPasswordStream.sink.add("");
    _studentPasswordStream.sink.addError("null");
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
  //submit
  void resetSubmitNote(){
    _submitNoteStream.sink.add("");
    _submitNoteStream.sink.addError("null");
  }
  void resetSubmitState(){
    _submitStateStream.sink.add("");
    _submitStateStream.sink.addError("null");
  }
  //teacher
  void resetTeacherId(){
    _teacherIdStream.sink.add("");
    _teacherIdStream.sink.addError("null");
  }
  void resetTeacherName(){
    _teacherNameStream.sink.add("");
    _teacherNameStream.sink.addError("null");
  }
  void resetTeacherLastName(){
    _teacherLastNameStream.sink.add("");
    _teacherLastNameStream.sink.addError("null");
  }
  void resetTeacherEmail(){
    _teacherEmailStream.sink.add("");
    _teacherEmailStream.sink.addError("null");
  }
  void resetTeacherCellphone(){
    _teacherCellphoneStream.sink.add("");
    _teacherCellphoneStream.sink.addError("null");
  }

  dispose() {
    //student-login-register
    _studentEmailStream.close();
    _studentPasswordStream.close();
    _studentNameStream.close();
    _studentLastNameStream.close();
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
    //teacher
    _teacherIdStream.close();
    _teacherNameStream.close();
    _teacherLastNameStream.close();
    _teacherEmailStream.close();
    _teacherCellphoneStream.close();

  }

}