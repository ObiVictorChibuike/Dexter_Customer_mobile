
class TopRatedVendorResponse {
  String? status;
  String? message;
  List<TopratedVendors>? data;

  TopRatedVendorResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TopRatedVendorResponse.fromJson(Map<String, dynamic> json) => TopRatedVendorResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TopratedVendors>.from(json["data"]!.map((x) => TopratedVendors.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TopratedVendors {
  int? id;
  String? name;
  int? vendorId;
  String? coverImage;
  String? biography;
  String? averageRating;
  Address? address;
  Address? contactAddress;

  TopratedVendors({
    this.id,
    this.name,
    this.vendorId,
    this.coverImage,
    this.biography,
    this.averageRating,
    this.address,
    this.contactAddress,
  });

  factory TopratedVendors.fromJson(Map<String, dynamic> json) => TopratedVendors(
    id: json["id"],
    name: json["name"],
    vendorId: json["vendor_id"],
    coverImage: json["cover_image"],
    biography: json["biography"],
    averageRating: json["average_rating"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    contactAddress: json["contact_address"] == null ? null : Address.fromJson(json["contact_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendor_id": vendorId,
    "cover_image": coverImage,
    "biography": biography,
    "average_rating": averageRating,
    "address": address?.toJson(),
    "contact_address": contactAddress?.toJson(),
  };
}

class Address {
  String? street;
  String? city;
  String? state;
  String? country;
  String? fullAddress;

  Address({
    this.street,
    this.city,
    this.state,
    this.country,
    this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
