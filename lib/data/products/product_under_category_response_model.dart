
class ProductUnderCategoryResponseModel {
  String? status;
  String? message;
  List<ProductUnderCategory>? data;

  ProductUnderCategoryResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductUnderCategoryResponseModel.fromJson(Map<String, dynamic> json) => ProductUnderCategoryResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ProductUnderCategory>.from(json["data"]!.map((x) => ProductUnderCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProductUnderCategory {
  int? id;
  String? name;
  String? description;
  String? image;
  String? price;
  bool? inStock;
  int? categoryId;
  int? shopId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  dynamic averageRating;
  Category? category;

  ProductUnderCategory({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.inStock,
    this.categoryId,
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.averageRating,
    this.category,
  });

  factory ProductUnderCategory.fromJson(Map<String, dynamic> json) => ProductUnderCategory(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
    inStock: json["in_stock"],
    categoryId: json["category_id"],
    shopId: json["shop_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    averageRating: json["average_rating"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "in_stock": inStock,
    "category_id": categoryId,
    "shop_id": shopId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt?.toIso8601String(),
    "average_rating": averageRating,
    "category": category?.toJson(),
  };
}

class Category {
  int? id;
  String? name;
  dynamic coverImage;

  Category({
    this.id,
    this.name,
    this.coverImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    coverImage: json["cover_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover_image": coverImage,
  };
}

enum Name { CATEGORY_1 }

final nameValues = EnumValues({
  "Category 1": Name.CATEGORY_1
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
