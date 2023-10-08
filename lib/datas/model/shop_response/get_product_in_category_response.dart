// To parse this JSON data, do
//
//     final productsInCategoryResponse = productsInCategoryResponseFromJson(jsonString);

import 'dart:convert';

ProductsInCategoryResponse productsInCategoryResponseFromJson(String str) => ProductsInCategoryResponse.fromJson(json.decode(str));

String productsInCategoryResponseToJson(ProductsInCategoryResponse data) => json.encode(data.toJson());

class ProductsInCategoryResponse {
  String? message;
  List<Product>? products;

  ProductsInCategoryResponse({
    this.message,
    this.products,
  });

  factory ProductsInCategoryResponse.fromJson(Map<String, dynamic> json) => ProductsInCategoryResponse(
    message: json["message"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  int? categoryId;
  int? shopId;
  String? name;
  String? description;
  String? image;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.categoryId,
    this.shopId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    shopId: json["shop_id"],
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
    "shop_id": shopId,
    "name": name,
    "description": description,
    "image": image,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
