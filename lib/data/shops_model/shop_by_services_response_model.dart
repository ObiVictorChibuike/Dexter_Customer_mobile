

class ShopByServicesResponse {
  String? status;
  String? message;
  List<ShopByServices>? data;

  ShopByServicesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ShopByServicesResponse.fromJson(Map<String, dynamic> json) => ShopByServicesResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ShopByServices>.from(json["data"]!.map((x) => ShopByServices.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShopByServices {
  int? id;
  String? name;
  int? vendorId;
  String? coverImage;
  ContactAddress? contactAddress;
  String? biography;
  String? averageRating;

  ShopByServices({
    this.id,
    this.name,
    this.vendorId,
    this.coverImage,
    this.contactAddress,
    this.biography,
    this.averageRating,
  });

  factory ShopByServices.fromJson(Map<String, dynamic> json) => ShopByServices(
    id: json["id"],
    name: json["name"],
    vendorId: json["vendor_id"],
    coverImage: json["cover_image"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
    biography: json["biography"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendor_id": vendorId,
    "cover_image": coverImage,
    "contact_address": contactAddress?.toJson(),
    "biography": biography,
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
