
class AppServicesResponse {
  String? status;
  String? message;
  List<AllAppServices>? data;

  AppServicesResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AppServicesResponse.fromJson(Map<String, dynamic> json) => AppServicesResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AllAppServices>.from(json["data"]!.map((x) => AllAppServices.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AllAppServices {
  int? id;
  String? name;
  bool? isBookable;
  String? description;
  String? coverImage;
  bool? isActive;
  dynamic deletedAt;

  AllAppServices({
    this.id,
    this.name,
    this.isBookable,
    this.description,
    this.coverImage,
    this.isActive,
    this.deletedAt,
  });

  factory AllAppServices.fromJson(Map<String, dynamic> json) => AllAppServices(
    id: json["id"],
    name: json["name"],
    isBookable: json["is_bookable"],
    description: json["description"],
    coverImage: json["cover_image"],
    isActive: json["is_active"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_bookable": isBookable,
    "description": description,
    "cover_image": coverImage,
    "is_active": isActive,
    "deleted_at": deletedAt,
  };
}
