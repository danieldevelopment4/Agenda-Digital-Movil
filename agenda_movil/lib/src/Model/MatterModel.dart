// ignore_for_file: file_names

import 'TeacherModel.dart';

class MatterModel {
    MatterModel({
        required this.id,
        required this.name,
        required this.teacher,
        required this.student,
    });

    final int id;
    final String name;
    final TeacherModel teacher;
    final dynamic student;

    factory MatterModel.fromJson(Map<String, dynamic> json) => MatterModel(
        id: json["id"],
        name: json["name"],
        teacher: TeacherModel.fromJson(json["teacher"]),
        student: json["student"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "teacher": teacher.toJson(),
        "student": student,
    };
}