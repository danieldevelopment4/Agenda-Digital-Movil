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
      required this.submissionDate,
      required this.term,
      this.submit
    }
  );

  final int id;
  final String name;
  final String? description;
  final int percent;
  final int noDaysRecordatories;
  final DateTime submissionDate;
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
      submit: json["submit"] == null ? null : SubmitModel.fromJson(json["submit"]),
  );

  int get getId{
    return id;
  }

  String get getName{
    return name;
  }

  String? get getDescription{
    return description;
  }

  int get getPercen{
    return percent;
  }

  int get getNoDayRecordatories{
    return noDaysRecordatories;
  }

  String get getSubmissionDate{
    return submissionDate.toString();
  }

  int get getTerm{
    return term;
  }

  SubmitModel? get getSumission{
    return submit;
  }

}