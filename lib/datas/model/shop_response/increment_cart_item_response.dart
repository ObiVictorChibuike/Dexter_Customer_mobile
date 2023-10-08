// To parse this JSON data, do
//
//     final incrementCartItemResponse = incrementCartItemResponseFromJson(jsonString);

import 'dart:convert';

IncrementCartItemResponse incrementCartItemResponseFromJson(String str) => IncrementCartItemResponse.fromJson(json.decode(str));

String incrementCartItemResponseToJson(IncrementCartItemResponse data) => json.encode(data.toJson());

class IncrementCartItemResponse {
  bool? success;
  String? message;
  Data? data;

  IncrementCartItemResponse({
    this.success,
    this.message,
    this.data,
  });

  factory IncrementCartItemResponse.fromJson(Map<String, dynamic> json) => IncrementCartItemResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? cartId;
  int? productId;
  String? productName;
  String? image;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.cartId,
    this.productId,
    this.productName,
    this.image,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    cartId: json["cart_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    image: json["image"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": cartId,
    "product_id": productId,
    "product_name": productName,
    "image": image,
    "quantity": quantity,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
