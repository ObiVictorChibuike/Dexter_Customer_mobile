
class RateBusinessResponseModel {
  String? status;
  String? message;
  Data? data;

  RateBusinessResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RateBusinessResponseModel.fromJson(Map<String, dynamic> json) => RateBusinessResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? userId;
  String? rating;
  String? comment;
  int? reviewableId;
  String? reviewableType;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.rating,
    this.comment,
    this.reviewableId,
    this.reviewableType,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    rating: json["rating"],
    comment: json["comment"],
    reviewableId: json["reviewable_id"],
    reviewableType: json["reviewable_type"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "rating": rating,
    "comment": comment,
    "reviewable_id": reviewableId,
    "reviewable_type": reviewableType,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
