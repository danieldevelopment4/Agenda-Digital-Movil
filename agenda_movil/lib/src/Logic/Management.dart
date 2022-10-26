// ignore_for_file: file_names

import 'dart:async';

import 'package:agenda_movil/src/API/ActivityRequest.dart';
import 'package:agenda_movil/src/API/RateRequest.dart';
import 'package:agenda_movil/src/API/MatterRequest.dart';
import 'package:agenda_movil/src/API/StudentRequest.dart';
import 'package:agenda_movil/src/API/SubscriptionRequest.dart';
import 'package:agenda_movil/src/API/TeacherRequest.dart';
import 'package:agenda_movil/src/Logic/Streams.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/SubscriptionModel.dart';

import '../Model/StudentModel.dart';
import '../Persistence/Percistence.dart';


class Management{

  Management(){
    if(_percistence.student!=""){
      setStudent();
    }
    if(_percistence.subscription!=""){
      setSubscriptionList();
    }
  }

  final Percistence _percistence = Percistence();
  String host = "https://back-end-agenda-digital.herokuapp.com";
  Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  var streams = Streams();

//


//BottonMenuBar
  int _currentIndex = 1;
  int get getIndex {
    return _currentIndex;
  }
  set setIndex(int index) {
    _currentIndex = index;
  }

  late StudentModel? _student;
  StudentModel get getStudent{
    return _student!;
  }
  void setStudent(){
    _student = studentFromJson(_percistence.student);
  }

  List<SubscriptionModel> _subsciptionList = List.empty(growable: true);
  List<SubscriptionModel> get getSubscriptionList{
    return _subsciptionList;
  }
  void setSubscriptionList(){
    _subsciptionList = subscriptionListFromJson(_percistence.subscription);
  }



  //Student-Login-Register
  Future<Map<String, dynamic>> logingRequest() {
    Map<String, String> body = {
      "email": streams.studentEmail,
      "password": streams.studentPassword
    };
    return StudentRequest().loggin(host, header, body);
  }

  Future<Map<String, dynamic>> registerRequest() {
    Map<String, String> body = {
      "name": streams.studentName,
      "lastName": streams.studentLastName,
      "email": streams.studentEmail,
      "password": streams.studentPassword
    };
    return StudentRequest().register(host, header, body);
  }

  //rate
  Future<Map<String, dynamic>> rateRequest(Map<String, String> body) {
    return RateRequest().rate(host, header, body);
  }

  //subscripciption
  Future<bool> subscripciptionRequest() async{
    Map<String, dynamic> body = {
      "student":getStudent.toJson()
    };
    bool ok = await SubscriptionRequest().viewSubscriptions(host, header, body);
    if(ok){
      setSubscriptionList();  
    }
    return ok;
  }

  Future<Map<String, dynamic>> aprobeSubscriptionRequest() async{
    Map<String, dynamic> body = {
      "student":getStudent.toJson()
    };
    Map<String, dynamic> ok = await SubscriptionRequest().aprobeSubscriptionRequest(host, header, body);
    if(ok["status"]){
      setSubscriptionList();  
    }
    return ok;
  }

  Future<Map<String, dynamic>> deniedSubscriptionRequest() async{
    Map<String, dynamic> body = {
      "student":getStudent.toJson()
    };
    Map<String, dynamic> ok = await SubscriptionRequest().deniedSubscriptionRequest(host, header, body);
    if(ok["status"]){
      setSubscriptionList();  
    }
    return ok;
  }

  //matter
  int _matterIndex =-1;

  int get getMatterIndex{
    return _matterIndex;
  }

  set setMatterIndex(int matterIndex){
    _matterIndex = matterIndex;
  }

  MatterModel getMatter(){
    return _subsciptionList[_matterIndex].getMatter;
  }

  Future<Map<String, dynamic>> createMatterRequest(){
    Map<String, dynamic> body = {
      "name": streams.matterName,
      "student":getStudent.toJson()
    };
    return MatterRequest().create(host, header, body);
  }
  
  Future<Map<String, dynamic>> searchMatterRequest(){
    Map<String, dynamic> body = {
      "matter":{
        "id":streams.matterId
      },
      "student":getStudent.toJson()
    };
    return SubscriptionRequest().subscribe(host, header, body);
  }

  //activity
  Future<Map<String, dynamic>> createActivityRequest(){
    Map<String, dynamic> body = {
        "name": streams.activityName,
        "percent": streams.activityPercent,
        "matter": {
            "id": _subsciptionList[_matterIndex].getMatter.getId
        },
        "noDaysRecordatories": streams.activityNoDaysRecordatories,
        "submissionDate": streams.activitySubmissionDate,
        "term": streams.activityTerm
    };
    return ActivityRequest().create(host, header, body);
  }

  //teacher
  Future<Map<String, dynamic>> createTeacherRequest(){
    Map<String, dynamic> body;
    if(streams.teacherCelphoneHasData){
      body = {
          "name": streams.teacherName,
          "lastName": streams.teacherLastName,
          "email": streams.teacherEmail,
          "cellphone": streams.teacherCellphone
      };
    }else{
      body = {
          "name": streams.teacherName,
          "lastName": streams.teacherLastName,
          "email": streams.teacherEmail,
      };
    }
    return TeacherRequest().create(host, header, body);
  }


}
