// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/StudentModel.dart';

import 'ActivityModel.dart';
import 'TeacherModel.dart';

class MatterModel {
  MatterModel(
    {
      required this.id,
      required this.name,
      this.studentsCount,
      this.teacher,
      this.activities,
      this.admin,
      this.aprobedStudentsList,
      this.waitingStudentsList,
    } 
  );

  final int id;
  final String name;
  final int? studentsCount;
  final TeacherModel? teacher;
  final List<ActivityModel>? activities;
  final bool? admin;
  final List<StudentModel>? aprobedStudentsList;
  final List<StudentModel>? waitingStudentsList;

  factory MatterModel.fromJson(Map<String, dynamic> json) => MatterModel(
      id: json["id"],
      name: json["name"],
      studentsCount: json["studentsCount"],
      teacher: ((json["teacher"] == null)?null:TeacherModel.fromJson(json["teacher"])),
      activities: List<ActivityModel>.from(json["activities"].map((x) => ActivityModel.fromJson(x))),
      admin: json["admin"],
      aprobedStudentsList: List<StudentModel>.from(json["aprobedStudentsList"].map((x) => StudentModel.fromJson(x))),
      waitingStudentsList: List<StudentModel>.from(json["waitingStudentsList"].map((x) => x)),
  );
  
  factory MatterModel.fromHalfJson(Map<String, dynamic> json) => MatterModel(
      id: json["id"],
      name: json["name"],
  );

  int get getId{
    return id;
  }

  String get getName{
    return name;
  }

  int get getStucentsCount{
    return studentsCount!;
  }

  TeacherModel? get getTeacher{
    return teacher;
  }

  List<ActivityModel> get getActivitiesList{
    return activities!;
  }

  bool get getAdmin{
    return admin!;
  }

  List<StudentModel> get getAprobedStudentsList{
    return aprobedStudentsList!;
  }

  List<StudentModel> get getWaitingStudentsList{
    return waitingStudentsList!;
  }
}