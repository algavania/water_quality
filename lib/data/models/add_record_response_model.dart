// To parse this JSON data, do
//
//     final addRecordResponseModel = addRecordResponseModelFromJson(jsonString);

import 'dart:convert';

AddRecordResponseModel addRecordResponseModelFromJson(String str) => AddRecordResponseModel.fromJson(json.decode(str));

String addRecordResponseModelToJson(AddRecordResponseModel data) => json.encode(data.toJson());

class AddRecordResponseModel {
  AddRecordResponseModel({
    this.data,
    this.message,
    this.status,
  });

  final Data? data;
  final String? message;
  final int? status;

  factory AddRecordResponseModel.fromJson(Map<String, dynamic> json) => AddRecordResponseModel(
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
    this.id,
    this.message,
    this.acidity,
    this.salinity,
    this.temperature,
    this.oxygen,
    this.createdAt,
  });

  final String? id, message;
  final double? acidity;
  final double? salinity;
  final int? temperature;
  final int? oxygen;
  final DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    message: json["message"],
    acidity: json["acidity"]?.toDouble(),
    salinity: json["salinity"]?.toDouble(),
    temperature: json["temperature"],
    oxygen: json["oxygen"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "acidity": acidity,
    "salinity": salinity,
    "temperature": temperature,
    "oxygen": oxygen,
    "created_at": createdAt?.toIso8601String(),
  };
}
