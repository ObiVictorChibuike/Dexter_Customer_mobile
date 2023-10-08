// To parse this JSON data, do
//
//     final cartByShopResponse = cartByShopResponseFromJson(jsonString);

import 'dart:convert';

CartByShopResponse cartByShopResponseFromJson(String str) => CartByShopResponse.fromJson(json.decode(str));

String cartByShopResponseToJson(CartByShopResponse data) => json.encode(data.toJson());

class CartByShopResponse {
  String? status;
  String? message;
  List<ShopCart>? data;

  CartByShopResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CartByShopResponse.fromJson(Map<String, dynamic> json) => CartByShopResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ShopCart>.from(json["data"]!.map((x) => ShopCart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShopCart {
  int? id;
  int? userId;
  int? shopId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? cartItemsSumPrice;
  int? cartItemsCount;
  List<CartItem>? cartItems;

  ShopCart({
    this.id,
    this.userId,
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cartItemsSumPrice,
    this.cartItemsCount,
    this.cartItems,
  });

  factory ShopCart.fromJson(Map<String, dynamic> json) => ShopCart(
    id: json["id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    cartItemsSumPrice: json["cart_items_sum_price"],
    cartItemsCount: json["cart_items_count"],
    cartItems: json["cart_items"] == null ? [] : List<CartItem>.from(json["cart_items"]!.map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_id": shopId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "cart_items_sum_price": cartItemsSumPrice,
    "cart_items_count": cartItemsCount,
    "cart_items": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class CartItem {
  int? id;
  int? cartId;
  int? productId;
  int? quantity;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  CartItem({
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    cartId: json["cart_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": cartId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
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
  dynamic deletedAt;

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    deletedAt: json["deleted_at"],
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
    "deleted_at": deletedAt,
  };
}
