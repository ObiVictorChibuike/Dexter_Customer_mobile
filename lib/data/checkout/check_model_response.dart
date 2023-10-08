

class CheckoutResponseModel {
  String? status;
  String? message;
  Data? data;

  CheckoutResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) => CheckoutResponseModel(
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
  num? userId;
  num? shopId;
  String? addressId;
  dynamic notes;
  String? reference;
  String? subtotalAmount;
  String? taxAmount;
  String? shippingCost;
  num? discountAmount;
  String? totalAmount;
  String? status;
  String? paymentStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  num? id;

  Data({
    this.userId,
    this.shopId,
    this.addressId,
    this.notes,
    this.reference,
    this.subtotalAmount,
    this.taxAmount,
    this.shippingCost,
    this.discountAmount,
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    shopId: json["shop_id"],
    addressId: json["address_id"],
    notes: json["notes"],
    reference: json["reference"],
    subtotalAmount: json["subtotal_amount"],
    taxAmount: json["tax_amount"],
    shippingCost: json["shipping_cost"],
    discountAmount: json["discount_amount"],
    totalAmount: json["total_amount"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "shop_id": shopId,
    "address_id": addressId,
    "notes": notes,
    "reference": reference,
    "subtotal_amount": subtotalAmount,
    "tax_amount": taxAmount,
    "shipping_cost": shippingCost,
    "discount_amount": discountAmount,
    "total_amount": totalAmount,
    "status": status,
    "payment_status": paymentStatus,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
