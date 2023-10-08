
class GetAllCategoryResponse {
  String? message;
  List<Category>? categories;

  GetAllCategoryResponse({
    this.message,
    this.categories,
  });

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) => GetAllCategoryResponse(
    message: json["message"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  int? shopId;
  String? name;
  dynamic coverImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.shopId,
    this.name,
    this.coverImage,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    shopId: json["shop_id"],
    name: json["name"],
    coverImage: json["cover_image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "name": name,
    "cover_image": coverImage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
