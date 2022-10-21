// ignore_for_file: file_names

class TeacherModel {
    TeacherModel({
        required this.id,
        required this.name,
        required this.lastName,
        required this.email,
        required this.cellphone,
    });

    final int id;
    final String name;
    final String lastName;
    final String email;
    final String cellphone;

    factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"] == null ? null : json["email"],
        cellphone: json["cellphone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email == null ? null : email,
        "cellphone": cellphone,
    };
}
