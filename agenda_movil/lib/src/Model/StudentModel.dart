// ignore_for_file: file_names

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
    Student({
        required this.id,
        required this.name,
        required this.lastName,
    });

    final String id;
    final String name;
    final String lastName;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
    };
}
