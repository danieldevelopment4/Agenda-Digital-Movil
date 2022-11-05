// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

import 'package:agenda_movil/src/API/ActivityRequest.dart';
import 'package:agenda_movil/src/API/RateRequest.dart';
import 'package:agenda_movil/src/API/MatterRequest.dart';
import 'package:agenda_movil/src/API/StudentRequest.dart';
import 'package:agenda_movil/src/API/SubscriptionRequest.dart';
import 'package:agenda_movil/src/API/TeacherRequest.dart';
import 'package:agenda_movil/src/Logic/Streams.dart';
import 'package:agenda_movil/src/Model/MatterModel.dart';
import 'package:agenda_movil/src/Model/SubscriptionModel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
    _loadTutorialFromAsset();
  }

  final Percistence _percistence = Percistence();
  String host = "https://back-end-agenda-digital.herokuapp.com";
  Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  var streams = Streams();

//tutorial
  final _path = "Files/Tutorial/Tutorial.pdf";
  late File _file;
  File get getFile{
    return _file;
  }
  void _loadTutorialFromAsset() async {
    final data = await rootBundle.load(_path);
    final bytes = data.buffer.asUint8List();

    final filename = basename(_path);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    _file = file;
  }

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
    print("setSubscriptionList");
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
  Future<bool> viewSubscripciptionsRequest() async{
    Map<String, dynamic> body = {
      "student":getStudent.toJson()
    };
    bool ok = await SubscriptionRequest().viewSubscriptions(host, header, body);
    if(ok){
      setSubscriptionList();  
    }
    return ok;
  }

  Future<Map<String, dynamic>> aprobeSubscriptionRequest(String id) async{
    Map<String, dynamic> body = {
      "matter": {
        "id": _subsciptionList[_matterIndex].getMatter.getId
      },
      "student":{
        "id": id
      }
    };
    Map<String, dynamic> ok = await SubscriptionRequest().aprobeSubscriptionRequest(host, header, body);
    if(ok["status"]){
      setSubscriptionList();  
    }
    return ok;
  }

  Future<Map<String, dynamic>> deniedSubscriptionRequest(String id) async{
    Map<String, dynamic> body = {
      "matter": {
        "id": _subsciptionList[_matterIndex].getMatter.getId
      },
      "student":{
        "id": id
      }
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

  Future<Map<String, dynamic>> exitMatterRequest() async{
    Map<String, dynamic> body = {
      "matter":{
        "id":_subsciptionList[_matterIndex].getMatter.getId
      },
      "student":getStudent.toJson()
    };
    Map<String, dynamic> ok = await SubscriptionRequest().unsubscribe(host, header, body);
    if(ok["status"]){
      setSubscriptionList();  
    }
    return ok;
  }

  Future<Map<String, dynamic>> createMatterRequest(String? teacherId){
    Map<String, dynamic> body;
    if (teacherId!=null) {
      body = {
        "name": streams.matterName,
        "student":getStudent.toJson(),
        "teacher": {
          "id": teacherId
        }
      };
    }else{
      body = {
        "name": streams.matterName,
        "student":getStudent.toJson()
      };
    }
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

  Future<Map<String, dynamic>> addTeacher(String teacherId){
    Map<String, dynamic> body = {
        "id": _subsciptionList[_matterIndex].getMatter.getId,
        "name": _subsciptionList[_matterIndex].getMatter.getName,
        "teacher": {
            "id": teacherId
        }
    };
    return MatterRequest().updateTeacher(host, header, body);
  }

  Future<Map<String, dynamic>> removeTeacher(){
    Map<String, dynamic> body = {
        "id": _subsciptionList[_matterIndex].getMatter.getId,
        "name": _subsciptionList[_matterIndex].getMatter.getName,
        "teacher": null
    };
    return MatterRequest().updateTeacher(host, header, body);
  }

  //teacher
  Future<Map<String, dynamic>> searchTeacherRequest(){
    Map<String, dynamic> body = {
        "id": streams.teacherId
    };
    return TeacherRequest().searchTeacherRequest(host, header, body);
  }

  Future<Map<String, dynamic>> createTeacherRequest(){
    Map<String, dynamic> body = {};
    if(streams.teacherEmail!="" && streams.teacherCellphone!=""){
      body = {
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": streams.teacherEmail,
        "cellphone": streams.teacherCellphone
      };
    }else if(streams.teacherEmail!="" && streams.teacherCellphone==""){
      body = {
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": streams.teacherEmail,
        "cellphone": null
      };
    }else if(streams.teacherEmail=="" && streams.teacherCellphone!=""){
      body = {
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": null,
        "cellphone": streams.teacherCellphone
      };
    }else{
      body = {
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": null,
        "cellphone": null
      };
    }
    return TeacherRequest().create(host, header, body);
  }

  Future<Map<String, dynamic>> updateTeacherRequest(){
    Map<String, dynamic> body;
    if(streams.teacherEmail!="" && streams.teacherCellphone!=""){
      body = {
        "id": streams.teacherId,
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": streams.teacherEmail,
        "cellphone": streams.teacherCellphone
      };
    }else if(streams.teacherEmail!="" && streams.teacherCellphone==""){
      body = {
        "id": streams.teacherId,
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": streams.teacherEmail,
        "cellphone": null
      };
    }else if(streams.teacherEmail=="" && streams.teacherCellphone!=""){
      body = {
        "id": streams.teacherId,
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": null,
        "cellphone": streams.teacherCellphone
      };
    }else{
      body = {
        "id": streams.teacherId,
        "name": streams.teacherName,
        "lastName": streams.teacherLastName,
        "email": null,
        "cellphone": null
      };
    }
    return TeacherRequest().update(host, header, body);
  }

  


}
