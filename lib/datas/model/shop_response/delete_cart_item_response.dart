// To parse this JSON data, do
//
//     final deleteCartItemResponse = deleteCartItemResponseFromJson(jsonString);

import 'dart:convert';

DeleteCartItemResponse deleteCartItemResponseFromJson(String str) => DeleteCartItemResponse.fromJson(json.decode(str));

String deleteCartItemResponseToJson(DeleteCartItemResponse data) => json.encode(data.toJson());

class DeleteCartItemResponse {
  bool? success;
  String? message;
  List<dynamic>? data;

  DeleteCartItemResponse({
    this.success,
    this.message,
    this.data,
  });

  factory DeleteCartItemResponse.fromJson(Map<String, dynamic> json) => DeleteCartItemResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
