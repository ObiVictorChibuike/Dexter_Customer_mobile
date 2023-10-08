
class ShopResponseModel {
  String? status;
  String? message;
  Data? data;

  ShopResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShopResponseModel.fromJson(Map<String, dynamic> json) => ShopResponseModel(
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
  int? id;
  String? name;
  String? biography;
  String? coverImage;
  String? openingTine;
  String? closingTime;
  String? contactEmail;
  String? contactPhone;
  ContactAddress? contactAddress;
  int? vendorId;
  String? discount;
  String? minOrder;
  String? additionalCharge;
  String? shippingCost;
  String? longitude;
  String? latitude;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? averageRating;

  Data({
    this.id,
    this.name,
    this.biography,
    this.coverImage,
    this.openingTine,
    this.closingTime,
    this.contactEmail,
    this.contactPhone,
    this.contactAddress,
    this.vendorId,
    this.discount,
    this.minOrder,
    this.additionalCharge,
    this.shippingCost,
    this.longitude,
    this.latitude,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.averageRating,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    biography: json["biography"],
    coverImage: json["cover_image"],
    openingTine: json["opening_tine"],
    closingTime: json["closing_time"],
    contactEmail: json["contact_email"],
    contactPhone: json["contact_phone"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
    vendorId: json["vendor_id"],
    discount: json["discount"],
    minOrder: json["min_order"],
    additionalCharge: json["additional_charge"],
    shippingCost: json["shipping_cost"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    serviceId: json["service_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "biography": biography,
    "cover_image": coverImage,
    "opening_tine": openingTine,
    "closing_time": closingTime,
    "contact_email": contactEmail,
    "contact_phone": contactPhone,
    "contact_address": contactAddress?.toJson(),
    "vendor_id": vendorId,
    "discount": discount,
    "min_order": minOrder,
    "additional_charge": additionalCharge,
    "shipping_cost": shippingCost,
    "longitude": longitude,
    "latitude": latitude,
    "service_id": serviceId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "average_rating": averageRating,
  };
}

class ContactAddress {
  String? street;
  String? city;
  String? state;
  String? country;
  String? fullAddress;

  ContactAddress({
    this.street,
    this.city,
    this.state,
    this.country,
    this.fullAddress,
  });

  factory ContactAddress.fromJson(Map<String, dynamic> json) => ContactAddress(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "full_address": fullAddress,
  };
}
