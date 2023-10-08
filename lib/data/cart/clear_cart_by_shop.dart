// To parse this JSON data, do
//
//     final clearCartByShopResponseModel = clearCartByShopResponseModelFromJson(jsonString);

import 'dart:convert';

ClearCartByShopResponseModel clearCartByShopResponseModelFromJson(String str) => ClearCartByShopResponseModel.fromJson(json.decode(str));

String clearCartByShopResponseModelToJson(ClearCartByShopResponseModel data) => json.encode(data.toJson());

class ClearCartByShopResponseModel {
  String? status;
  String? message;

  ClearCartByShopResponseModel({
    this.status,
    this.message,
  });

  factory ClearCartByShopResponseModel.fromJson(Map<String, dynamic> json) => ClearCartByShopResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
