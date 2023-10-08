

class CartResponse {
  bool? success;
  String? message;
  List<CartItem>? data;

  CartResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CartItem>.from(json["data"]!.map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CartItem {
  int? id;
  int? cartId;
  int? productId;
  String? productName;
  String? image;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  CartItem({
    this.id,
    this.cartId,
    this.productId,
    this.productName,
    this.image,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    cartId: json["cart_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    image: json["image"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": cartId,
    "product_id": productId,
    "product_name": productName,
    "image": image,
    "quantity": quantity,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
