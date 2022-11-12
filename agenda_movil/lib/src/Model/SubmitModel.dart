// ignore_for_file: file_names

class SubmitModel{

  SubmitModel(
    {
      required this.id,
      this.note,
      required this.state
    }
  );

  final int id;
  final double? note;
  final String state;

  factory SubmitModel.fromJson(Map<String, dynamic> json) => SubmitModel(
    id: json["id"],
    note: json["note"],
    state: json["state"],
  );

  int get getId{
    return id;
  }

  double? get getNote{
    return note;
  }

  String get getState{
    return state.toString();
  }

}