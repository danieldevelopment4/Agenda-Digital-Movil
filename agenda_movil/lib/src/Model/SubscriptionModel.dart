// ignore_for_file: file_names

import 'dart:convert';

import 'MatterModel.dart';

List<SubscriptionModel> subscriptionListFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

class SubscriptionModel {
  SubscriptionModel(
    {
      required this.id,
      required this.matter,
      required this.request,
    }
  );

  final int id;
  final MatterModel matter;
  final bool request;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"],
    matter: MatterModel.fromJson(json["matter"]),
    request: json["request"],
  );

}