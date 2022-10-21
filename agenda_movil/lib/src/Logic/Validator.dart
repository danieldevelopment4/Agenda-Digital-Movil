// ignore_for_file: file_names

import 'dart:async';

class Validator{

  //login
  final validateEmail = StreamTransformer<String,String>.fromHandlers(
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

  final validatePassword = StreamTransformer<String,String>.fromHandlers(
    handleData: (password, sink){
      if(password.length>=6){
        sink.add(password);
      }else{
        sink.addError("Contraseña demasiado corta");
      }
    }
  );

  //register
  final validateName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=3){
        sink.add(name);
      }else{
        sink.addError("Nombre demasiado corto");
      }
    }
  );

  final validateLastName = StreamTransformer<String,String>.fromHandlers(
    handleData: (name, sink){
      if(name.length>=5){
        sink.add(name);
      }else{
        sink.addError("Apellido demasiado corto");
      }
    }
  );

    //subject
  final validateSubjectId = StreamTransformer<String,String>.fromHandlers(
    handleData: (subjectId, sink){
      if(subjectId.length>=6){
        sink.add(subjectId);
      }else{
        sink.addError("El ID es demasiado corto");
      }
    }
  );

  final validateSubjectName = StreamTransformer<String,String>.fromHandlers(
    handleData: (subjectName, sink){
      if(subjectName.length>=6){
        sink.add(subjectName);
      }else{
        sink.addError("El nombre es demasiado corto");
      }
    }
  );

}