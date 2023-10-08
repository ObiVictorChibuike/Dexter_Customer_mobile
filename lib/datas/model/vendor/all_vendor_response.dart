
class AllVendorResponse {
  AllVendorResponse({
    this.message,
    this.data,
  });

  String? message;
  List<AllVendor>? data;

  factory AllVendorResponse.fromJson(Map<String, dynamic> json) => AllVendorResponse(
    message: json["message"],
    data: json["data"] == null ? [] : List<AllVendor>.from(json["data"]!.map((x) => AllVendor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllVendor {
  AllVendor({
    this.id,
    this.name,
    this.vendorId,
    this.bio,
    this.rating,
    this.image,
    this.jobsCompleted,
    this.longitude,
    this.latitude,
    this.offers,
  });

  int? id;
  String? name;
  int? vendorId;
  String? bio;
  String? rating;
  String? image;
  String? jobsCompleted;
  double? longitude;
  double? latitude;
  List<Offer>? offers;

  factory AllVendor.fromJson(Map<String, dynamic> json) => AllVendor(
    id: json["id"],
    name: json["name"],
    vendorId: json["vendor_id"],
    bio: json["bio"],
    rating: json["rating"],
    image: json["image"],
    jobsCompleted: json["jobs_completed"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "vendor_id": vendorId,
    "bio": bio,
    "rating": rating,
    "image": image,
    "jobs_completed": jobsCompleted,
    "longitude": longitude,
    "latitude": latitude,
    "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
  };
}

class Offer {
  Offer({
    this.id,
    this.businessId,
    this.name,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? businessId;
  String? name;
  String? price;
  String? image;
  dynamic createdAt;
  dynamic updatedAt;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    businessId: json["business_id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "name": name,
    "price": price,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
