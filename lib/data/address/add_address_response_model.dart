
class AddAddressResponseModel {
  String? status;
  String? message;
  Data? data;

  AddAddressResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddAddressResponseModel.fromJson(Map<String, dynamic> json) => AddAddressResponseModel(
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
  String? street;
  String? city;
  String? state;
  String? country;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? fullAddress;

  Data({
    this.street,
    this.city,
    this.state,
    this.country,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.fullAddress,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    userId: json["user_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "full_address": fullAddress,
  };
}
