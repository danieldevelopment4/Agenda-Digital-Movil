// ignore_for_file: file_names

import 'dart:async';

class Validator{

  //students-logib-register
  final validateStudentEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError("Correo no valido");
      }
    }
  );

  final validateStudentPassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError("Contraseña demasiado corta");
      }
    }
  );

  final validateStudentName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=3 && name.length<=18){
        sink.add(name);
      }else if(name.length>22){
      sink.addError("El nombre es demasiado largo");
      }else{
        sink.addError("Nombre demasiado corto");
      }
    }
  );

  final validateStudentLastName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=5){
        sink.add(name);
      }else{
        sink.addError("Apellido demasiado corto");
      }
    }
  );

  //matter
  final validateMatterId = StreamTransformer<String,String>.fromHandlers(
    handleData: (matterId, sink){
      if(matterId.isNotEmpty){
        sink.add(matterId);
      }else{
        sink.addError("Debe ingresar un ID para consultar");
      }
    }
  );

  final validateMatterName = StreamTransformer<String,String>.fromHandlers(
    handleData: (matterName, sink){
      if(matterName.length<3){
        sink.addError("El nombre es demasiado corto");
      }else if(matterName.length>18){
        sink.addError("El nombre es demasiado largo");
      }else{
        sink.add(matterName);
      }
    }
  );

  //activity
  final validateActivityName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=3 && name.length<=10){
        sink.add(name);
      }else if(name.length>10){
        sink.addError("El nombre es demasiado largo");
      }else{
        sink.addError("Nombre demasiado corto");
      }
    }
  );

  final validateActivityDescription = StreamTransformer<String,String>.fromHandlers(
    handleData: (activityDescription, sink){
      if(activityDescription.length>255){
        sink.addError("El nombre es demasiado largo");
      }else{
        sink.add(activityDescription);
      }
    }
  );

  final validateActivityPercent = StreamTransformer<String,String>.fromHandlers(
    handleData: (activityPercent, sink){
      if(int.parse(activityPercent)<0){
        sink.addError("No se puede establecer un valor negativo");
      }else{
        sink.add(activityPercent);
      }
    }
  );

  final validateActivityNoDaysRecordatories = StreamTransformer<String,String>.fromHandlers(
    handleData: (activityNoDaysRecordatories, sink){
      if(activityNoDaysRecordatories.toString().isEmpty){
        sink.addError("Debes ingresar un valor");
      }else if(int.parse(activityNoDaysRecordatories)<0){
        sink.addError("No se puede establecer un valor negativo");
      }else{
        sink.add(activityNoDaysRecordatories.toString());
      }
    }
  );

  final validateActivitySubmissionDateStream = StreamTransformer<String,String>.fromHandlers(
    handleData: (activitySubmissionDate, sink){
      if(activitySubmissionDate.isEmpty){
        sink.addError("Debes de establecer una fecha de entrega");
      }else{
        sink.add(activitySubmissionDate);
      }
    }
  );

  final validateActivityTerm = StreamTransformer<String,String>.fromHandlers(
    handleData: (activityTerm, sink){
      if(activityTerm.toString().isEmpty){
        sink.addError("Debes de establecer el corte academico al que pertenece la actividad");
      }else if(int.parse(activityTerm)<1){
        sink.addError("No se puede establecer un valor inferior a 1");
      }else{
        sink.add(activityTerm.toString());
      }
    }
  );

  //teacher
  final validateTeacherName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=3 && name.length<=18){
        sink.add(name);
      }else if(name.length>28){
      sink.addError("El nombre es demasiado largo");
      }else{
        sink.addError("El nombre es demasiado corto");
      }
    }
  );

  final validateTeacherLastName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=5){
        sink.add(name);
      }else{
        sink.addError("El Apellido demasiado corto");
      }
    }
  );

  final validateTeacherEmail = StreamTransformer<String,String>.fromHandlers(
    handleData: (email, sink){
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError("Correo no valido");
      }
    }
  );

  final validateTeacherCellphone = StreamTransformer<String,String>.fromHandlers(
    handleData: (cellphone, sink){
      if(cellphone.length==10 || cellphone.isEmpty){
        sink.add(cellphone);
      }else{
        sink.addError("Numero celular no valido");
      }
    }
  );


}