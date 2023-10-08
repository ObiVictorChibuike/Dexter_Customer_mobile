
class ShopsAroundYouResponse {
  String? status;
  String? message;
  List<ShopsAroundYou>? data;

  ShopsAroundYouResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ShopsAroundYouResponse.fromJson(Map<String, dynamic> json) => ShopsAroundYouResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ShopsAroundYou>.from(json["data"]!.map((x) => ShopsAroundYou.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShopsAroundYou {
  int? id;
  String? name;
  int? vendorId;
  String? coverImage;
  String? biography;
  ContactAddress? contactAddress;
  String? averageRating;
  String? distance;

  ShopsAroundYou({
    this.id,
    this.name,
    this.vendorId,
    this.coverImage,
    this.biography,
    this.contactAddress,
    this.averageRating,
    this.distance,
  });

  factory ShopsAroundYou.fromJson(Map<String, dynamic> json) => ShopsAroundYou(
    id: json["id"],
    name: json["name"],
    vendorId: json["vendor_id"],
    coverImage: json["cover_image"],
    biography: json["biography"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
    averageRating: json["average_rating"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendor_id": vendorId,
    "cover_image": coverImage,
    "biography": biography,
    "contact_address": contactAddress?.toJson(),
    "average_rating": averageRating,
    "distance": distance,
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
