
class OrderDetailsModelResponse {
  String? status;
  String? message;
  Data? data;

  OrderDetailsModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OrderDetailsModelResponse.fromJson(Map<String, dynamic> json) => OrderDetailsModelResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? reference;
  String? status;
  String? paymentStatus;
  int? addressId;
  int? userId;
  int? shopId;
  String? subtotalAmount;
  String? discountAmount;
  String? taxAmount;
  String? totalAmount;
  String? shippingCost;
  String? additionalCharge;
  dynamic notes;
  dynamic paymentMethod;
  dynamic fulfilledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Shop? shop;
  Address? address;
  List<OrderItem>? orderItems;

  Data({
    this.id,
    this.reference,
    this.status,
    this.paymentStatus,
    this.addressId,
    this.userId,
    this.shopId,
    this.subtotalAmount,
    this.discountAmount,
    this.taxAmount,
    this.totalAmount,
    this.shippingCost,
    this.additionalCharge,
    this.notes,
    this.paymentMethod,
    this.fulfilledAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shop,
    this.address,
    this.orderItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    reference: json["reference"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    addressId: json["address_id"],
    userId: json["user_id"],
    shopId: json["shop_id"],
    subtotalAmount: json["subtotal_amount"],
    discountAmount: json["discount_amount"],
    taxAmount: json["tax_amount"],
    totalAmount: json["total_amount"],
    shippingCost: json["shipping_cost"],
    additionalCharge: json["additional_charge"],
    notes: json["notes"],
    paymentMethod: json["payment_method"],
    fulfilledAt: json["fulfilled_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "status": status,
    "payment_status": paymentStatus,
    "address_id": addressId,
    "user_id": userId,
    "shop_id": shopId,
    "subtotal_amount": subtotalAmount,
    "discount_amount": discountAmount,
    "tax_amount": taxAmount,
    "total_amount": totalAmount,
    "shipping_cost": shippingCost,
    "additional_charge": additionalCharge,
    "notes": notes,
    "payment_method": paymentMethod,
    "fulfilled_at": fulfilledAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "shop": shop?.toJson(),
    "address": address?.toJson(),
    "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  int? userId;
  String? street;
  String? city;
  String? state;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? fullAddress;

  Address({
    this.id,
    this.userId,
    this.street,
    this.city,
    this.state,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "full_address": fullAddress,
  };
}

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Product? product;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
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

class Shop {
  int? id;
  String? name;
  String? coverImage;
  ContactAddress? contactAddress;

  Shop({
    this.id,
    this.name,
    this.coverImage,
    this.contactAddress,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json["id"],
    name: json["name"],
    coverImage: json["cover_image"],
    contactAddress: json["contact_address"] == null ? null : ContactAddress.fromJson(json["contact_address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover_image": coverImage,
    "contact_address": contactAddress?.toJson(),
  };
}

class ContactAddress {
  String? street;
  String? city;
  String? state;
  String? country;
  String? fullAddress;

  ContactAddress({
    this.street,
    this.city,
    this.state,
    this.country,
    this.fullAddress,
  });

  factory ContactAddress.fromJson(Map<String, dynamic> json) => ContactAddress(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "full_address": fullAddress,
  };
}
