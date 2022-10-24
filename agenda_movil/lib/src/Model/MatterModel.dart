// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/StudentModel.dart';

import 'ActivityModel.dart';
import 'TeacherModel.dart';

class MatterModel {
  MatterModel(
    {
      required this.id,
      required this.name,
      required this.rgb,
      this.studentsCount,
      this.teacher,
      this.activities,
      this.admin,
      this.studentList,
    } 
  );

  final int id;
  final String name;
  final String rgb;
  final int? studentsCount;
  final TeacherModel? teacher;
  final List<ActivityModel>? activities;
  final bool? admin;
  final List<StudentModel>? studentList;

  factory MatterModel.fromJson(Map<String, dynamic> json) => MatterModel(
      id: json["id"],
      name: json["name"],
      rgb: json["rgb"],
      studentsCount: json["studentsCount"],
      teacher: ((json["teacher"] == null)?null:TeacherModel.fromJson(json["teacher"])),
      activities: List<ActivityModel>.from(json["activities"].map((x) => ActivityModel.fromJson(x))),
      admin: json["admin"],
      studentList: List<StudentModel>.from(json["studentList"].map((x) => StudentModel.fromJson(x))),
  );
  
  factory MatterModel.fromHalfJson(Map<String, dynamic> json) => MatterModel(
      id: json["id"],
      name: json["name"],
      rgb: json["rgb"]
  );

  int get getId{
    return id;
  }

  String get getName{
    return name;
  }

  String get getRgb{
    return rgb;
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

  List<StudentModel> get getStudentsList{
    return studentList!;
  }

}