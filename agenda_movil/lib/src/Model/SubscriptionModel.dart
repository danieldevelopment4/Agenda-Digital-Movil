// ignore_for_file: file_names

import 'dart:convert';

import 'MatterModel.dart';

List<SubscriptionModel> subscriptionFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String subscriptionToJson(List<SubscriptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
    SubscriptionModel({
        required this.id,
        required this.matter,
        required this.student,
        required this.request,
    });

    final int id;
    final MatterModel matter;
    final dynamic student;
    final bool request;

    factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
        id: json["id"],
        matter: MatterModel.fromJson(json["matter"]),
        student: json["student"],
        request: json["request"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "matter": matter.toJson(),
        "student": student,
        "request": request,
    };
}