
class CategoryResponseModel {
  String? status;
  String? message;
  List<ProductCategory>? data;

  CategoryResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ProductCategory>.from(json["data"]!.map((x) => ProductCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductCategory {
  int? id;
  int? shopId;
  String? name;
  dynamic coverImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  ProductCategory({
    this.id,
    this.shopId,
    this.name,
    this.coverImage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["id"],
    shopId: json["shop_id"],
    name: json["name"],
    coverImage: json["cover_image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "name": name,
    "cover_image": coverImage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
