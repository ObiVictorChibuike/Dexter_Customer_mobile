

class ProductsInShop {
  String? success;
  String? message;
  List<Products>? data;

  ProductsInShop({
    this.success,
    this.message,
    this.data,
  });

  factory ProductsInShop.fromJson(Map<String, dynamic> json) => ProductsInShop(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Products>.from(json["data"]!.map((x) => Products.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Products {
  int? id;
  int? categoryId;
  String? categoryName;
  int? shopId;
  String? shopName;
  String? name;
  String? description;
  String? image;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Products({
    this.id,
    this.categoryId,
    this.categoryName,
    this.shopId,
    this.shopName,
    this.name,
    this.description,
    this.image,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    shopId: json["shop_id"],
    shopName: json["shop_name"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category_name": categoryName,
    "shop_id": shopId,
    "shop_name": shopName,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
