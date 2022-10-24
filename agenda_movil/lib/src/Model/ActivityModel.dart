// ignore_for_file: file_names
import 'SubmitModel.dart';

class ActivityModel{
  ActivityModel(
    {
      required this.id,
      required this.name,
      this.description,
      required this.percent,
      required this.noDaysRecordatories,
      this.submissionDate,
      required this.term,
      this.submit
    }
  );

  final int id;
  final String name;
  final String? description;
  final double percent;
  final int noDaysRecordatories;
  final DateTime? submissionDate;
  final int term;
  final SubmitModel? submit;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      percent: json["percent"],
      noDaysRecordatories: json["noDaysRecordatories"],
      submissionDate: DateTime.parse(json["submissionDate"]),
      term: json["term"],
      submit: SubmitModel.fromJson(json["submit"]),
  );

}