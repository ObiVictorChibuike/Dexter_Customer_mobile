// To parse this JSON data, do
//
//     final successResponseModel = successResponseModelFromJson(jsonString);

import 'dart:convert';

SuccessResponseModel successResponseModelFromJson(String str) => SuccessResponseModel.fromJson(json.decode(str));

String successResponseModelToJson(SuccessResponseModel data) => json.encode(data.toJson());

class SuccessResponseModel {
  String? status;
  String? message;

  SuccessResponseModel({
    this.status,
    this.message,
  });

  factory SuccessResponseModel.fromJson(Map<String, dynamic> json) => SuccessResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
