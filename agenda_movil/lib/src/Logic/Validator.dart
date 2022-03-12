import 'dart:async';

class Validator{

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

  final validateSubjectId = StreamTransformer<String,String>.fromHandlers(
    handleData: (subjectId, sink){
      if(subjectId.length>=6){
        sink.add(subjectId);
      }else{
        sink.addError("El ID es demasiado corto");
      }
    }
  );

}