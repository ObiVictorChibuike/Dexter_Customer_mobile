// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) => ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  bool? success;
  String? message;
  List<Datum>? data;

  ReviewResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? userId;
  int? vendorId;
  String? review;
  int? rating;
  DateTime? createdAt;

  Datum({
    this.id,
    this.userId,
    this.vendorId,
    this.review,
    this.rating,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    vendorId: json["vendor_id"],
    review: json["review"],
    rating: json["rating"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "vendor_id": vendorId,
    "review": review,
    "rating": rating,
    "created_at": createdAt?.toIso8601String(),
  };
}
