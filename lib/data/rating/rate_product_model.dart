

class RateProductResponseModel {
  String? status;
  String? message;
  List<RatedProduct>? data;

  RateProductResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RateProductResponseModel.fromJson(Map<String, dynamic> json) => RateProductResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<RatedProduct>.from(json["data"]!.map((x) => RatedProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RatedProduct {
  int? id;
  int? userId;
  String? reviewableType;
  int? reviewableId;
  String? comment;
  int? rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  RatedProduct({
    this.id,
    this.userId,
    this.reviewableType,
    this.reviewableId,
    this.comment,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory RatedProduct.fromJson(Map<String, dynamic> json) => RatedProduct(
    id: json["id"],
    userId: json["user_id"],
    reviewableType: json["reviewable_type"],
    reviewableId: json["reviewable_id"],
    comment: json["comment"],
    rating: json["rating"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "reviewable_type": reviewableType,
    "reviewable_id": reviewableId,
    "comment": comment,
    "rating": rating,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
