

class GetBusinessDetailsResponseModel {
  String? status;
  String? message;
  Data? data;

  GetBusinessDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetBusinessDetailsResponseModel.fromJson(Map<String, dynamic> json) => GetBusinessDetailsResponseModel(
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
  String? openingTime;
  String? closingTime;
  String? contactEmail;
  String? contactPhone;
  String? serviceCharge;
  ContactAddress? contactAddress;
  int? vendorId;
  String? longitude;
  String? latitude;
  int? serviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? averageRating;
  int? totalCompletedBookings;
  List<BusinessImage>? businessImages;

  Data({
    this.id,
    this.name,
    this.biography,
    this.coverImage,
    this.openingTime,
    this.closingTime,
    this.contactEmail,
    this.contactPhone,
    this.serviceCharge,
    this.contactAddress,
    this.vendorId,
    this.longitude,
    this.latitude,
    this.serviceId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.averageRating,
    this.totalCompletedBookings,
    this.businessImages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    biography: json["biography"],
    coverImage: json["cover_image"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    contactEmail: json["contact_email"],
    contactPhone: json["contact_phone"],
    serviceCharge: json["service_charge"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
    vendorId: json["vendor_id"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    serviceId: json["service_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    averageRating: json["average_rating"],
    totalCompletedBookings: json["total_completed_bookings"],
    businessImages: json["business_images"] == null ? [] : List<BusinessImage>.from(json["business_images"]!.map((x) => BusinessImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "biography": biography,
    "cover_image": coverImage,
    "opening_time": openingTime,
    "closing_time": closingTime,
    "contact_email": contactEmail,
    "contact_phone": contactPhone,
    "service_charge": serviceCharge,
    "contact_address": contactAddress?.toJson(),
    "vendor_id": vendorId,
    "longitude": longitude,
    "latitude": latitude,
    "service_id": serviceId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "average_rating": averageRating,
    "total_completed_bookings": totalCompletedBookings,
    "business_images": businessImages == null ? [] : List<dynamic>.from(businessImages!.map((x) => x.toJson())),
  };
}

class BusinessImage {
  int? id;
  int? businessId;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  BusinessImage({
    this.id,
    this.businessId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BusinessImage.fromJson(Map<String, dynamic> json) => BusinessImage(
    id: json["id"],
    businessId: json["business_id"],
    imageUrl: json["image_url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "image_url": imageUrl,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
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
