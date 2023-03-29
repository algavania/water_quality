// To parse this JSON data, do
//
//     final authenticationResponseModel = authenticationResponseModelFromJson(jsonString);

import 'dart:convert';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) => AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) => json.encode(data.toJson());

class AuthenticationResponseModel {
  AuthenticationResponseModel({
    this.data,
    this.message,
    this.status,
  });

  final Data? data;
  final String? message;
  final int? status;

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) => AuthenticationResponseModel(
    data: json["data"] == null ? null : (json["data"] is String ? Data(message: json["data"]) : Data.fromJson(json["data"])),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
  Data({
    this.meterId,
    this.meterName,
    this.message,
  });

  final String? meterId;
  final String? meterName;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meterId: json["meter_id"],
    meterName: json["meter_name"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "meter_id": meterId,
    "meter_name": meterName,
    "message": message,
  };
}
