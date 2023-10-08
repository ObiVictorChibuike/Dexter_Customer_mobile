
class BusinessByServicesResponse {
  String? status;
  String? message;
  List<Business>? data;

  BusinessByServicesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BusinessByServicesResponse.fromJson(Map<String, dynamic> json) => BusinessByServicesResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Business>.from(json["data"]!.map((x) => Business.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Business {
  int? id;
  String? name;
  int? vendorId;
  String? coverImage;
  ContactAddress? contactAddress;
  String? averageRating;

  Business({
    this.id,
    this.name,
    this.vendorId,
    this.coverImage,
    this.contactAddress,
    this.averageRating,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    name: json["name"],
    vendorId: json["vendor_id"],
    coverImage: json["cover_image"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendor_id": vendorId,
    "cover_image": coverImage,
    "contact_address": contactAddress?.toJson(),
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
