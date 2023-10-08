
class RemoveFromCartResponse {
  RemoveFromCartResponse({
    this.data,
    this.status,
    this.message,
  });

  List<FoodRemovedFromCart>? data;
  int? status;
  String? message;

  factory RemoveFromCartResponse.fromJson(Map<String, dynamic> json) => RemoveFromCartResponse(
    data: json["data"] == null ? [] : List<FoodRemovedFromCart>.from(json["data"]!.map((x) => FoodRemovedFromCart.fromJson(x))),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class FoodRemovedFromCart {
  FoodRemovedFromCart({
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

  factory FoodRemovedFromCart.fromJson(Map<String, dynamic> json) => FoodRemovedFromCart(
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
