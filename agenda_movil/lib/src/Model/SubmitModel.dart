// ignore_for_file: file_names

import 'package:agenda_movil/src/Model/SubmitStateEnum.dart';

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
  final SubmitStateEnum state;

  factory SubmitModel.fromJson(Map<String, dynamic> json) => SubmitModel(
    id: json["id"],
    note: json["note"],
    state: SubmitStateEnum.values.firstWhere((e)=>e.toString().split('.')[1].toUpperCase()==json["state"].toUpperCase()),
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