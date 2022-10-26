// ignore_for_file: file_names

import 'dart:convert';

StudentModel studentFromJson(String str) => StudentModel.fromJson(json.decode(str));

List<StudentModel> studentListFromJson(String str) => List<StudentModel>.from(json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel(
    {
      this.id,
      required this.name,
      required this.lastName,
    }
  );

  final String? id;
  final String name;
  final String lastName;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
      id: json["id"],
      name: json["name"],
      lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "lastName": lastName,
  };

  String? get getId{
    return id;
  } 

  String get getName{
    return name;
  }

  String get getLastName{
    return lastName;
  }   

  String get getFullName{
    return name+" "+lastName;
  }

}
