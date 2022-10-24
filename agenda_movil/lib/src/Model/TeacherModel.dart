// ignore_for_file: file_names

class TeacherModel {
  TeacherModel(
    {
      required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      this.cellphone,
    }
  );

  final int id;
  final String name;
  final String lastName;
  final String email;
  final int? cellphone;

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
    id: json["id"],
    name: json["name"],
    lastName: json["lastName"],
    email: json["email"],
    cellphone: json["cellphone"],
  );

  int get getId{
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

  String get getEmail{
    return email;
  }

  int? get getCellPhone{
    return cellphone;
  }

}
