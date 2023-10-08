

class AddressResponseModel {
  String? status;
  String? message;
  List<Datum>? data;

  AddressResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) => AddressResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? userId;
  String? street;
  String? city;
  String? state;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullAddress;

  Datum({
    this.id,
    this.userId,
    this.street,
    this.city,
    this.state,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.fullAddress,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "full_address": fullAddress,
  };
}
