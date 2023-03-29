// To parse this JSON data, do
//
//     final recordResponseModel = recordResponseModelFromJson(jsonString);

import 'dart:convert';

RecordResponseModel recordResponseModelFromJson(String str) => RecordResponseModel.fromJson(json.decode(str));

String recordResponseModelToJson(RecordResponseModel data) => json.encode(data.toJson());

class RecordResponseModel {
  RecordResponseModel({
    this.data,
    this.message,
    this.status,
  });

  final List<MeterData>? data;
  final String? message;
  final int? status;

  factory RecordResponseModel.fromJson(Map<String, dynamic> json) => RecordResponseModel(
    data: json["data"] == null ? null : (json["data"] is String ? [MeterData(message: json["data"])] : List<MeterData>.from(json["data"]!.map((x) => MeterData.fromJson(x)))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class MeterData {
  MeterData({
    this.message,
    this.acidity,
    this.salinity,
    this.temperature,
    this.oxygen,
    this.createdAt,
  });

  final String? message;
  final double? acidity;
  final double? salinity;
  final int? temperature;
  final int? oxygen;
  final DateTime? createdAt;

  factory MeterData.fromJson(Map<String, dynamic> json) => MeterData(
    acidity: json["acidity"]?.toDouble(),
    salinity: json["salinity"]?.toDouble(),
    message: json["message"],
    temperature: json["temperature"],
    oxygen: json["oxygen"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "acidity": acidity,
    "message": message,
    "salinity": salinity,
    "temperature": temperature,
    "oxygen": oxygen,
    "created_at": createdAt?.toIso8601String(),
  };
}
