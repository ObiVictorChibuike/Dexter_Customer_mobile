
class AddToCartResponse {
  AddToCartResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<FoodAddedToCart>? data;

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FoodAddedToCart>.from(json["data"]!.map((x) => FoodAddedToCart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FoodAddedToCart {
  FoodAddedToCart({
    this.id,
    this.userId,
    this.foodId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? foodId;
  String? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FoodAddedToCart.fromJson(Map<String, dynamic> json) => FoodAddedToCart(
    id: json["id"],
    userId: json["user_id"],
    foodId: json["food_id"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "food_id": foodId,
    "quantity": quantity,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
