// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/StudentModel.dart';

import 'ActivityModel.dart';
import 'TeacherModel.dart';

class MatterModel {
  MatterModel(
    {
      required this.id,
      required this.name,
      required this.studentsCount,
      this.teacher,
      required this.activities,
      required this.admin,
      required this.studentList,
    } 
  );

  final int id;
  final String name;
  final int studentsCount;
  final TeacherModel? teacher;
  final List<ActivityModel> activities;
  final bool admin;
  final List<StudentModel> studentList;

  factory MatterModel.fromJson(Map<String, dynamic> json) => MatterModel(
      id: json["id"],
      name: json["name"],
      studentsCount: json["studentsCount"],
      teacher: TeacherModel.fromJson(json["teacher"]),
      activities: List<ActivityModel>.from(json["activities"].map((x) => ActivityModel.fromJson(x))),
      admin: json["admin"],
      studentList: List<StudentModel>.from(json["studentList"].map((x) => StudentModel.fromJson(x))),
  );

}