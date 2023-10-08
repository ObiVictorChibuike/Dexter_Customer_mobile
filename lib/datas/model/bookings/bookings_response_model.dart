

class BookingResponseModel {
  String? status;
  String? message;
  List<Bookings>? data;

  BookingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) => BookingResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Bookings>.from(json["data"]!.map((x) => Bookings.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Bookings {
  int? id;
  String? reference;
  String? status;
  String? paymentStatus;
  int? addressId;
  int? userId;
  int? businessId;
  DateTime? scheduledDate;
  String? subtotalAmount;
  String? taxAmount;
  String? totalAmount;
  dynamic paymentMethod;
  String? notes;
  dynamic fulfilledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Business? business;

  Bookings({
    this.id,
    this.reference,
    this.status,
    this.paymentStatus,
    this.addressId,
    this.userId,
    this.businessId,
    this.scheduledDate,
    this.subtotalAmount,
    this.taxAmount,
    this.totalAmount,
    this.paymentMethod,
    this.notes,
    this.fulfilledAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.business,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    id: json["id"],
    reference: json["reference"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    addressId: json["address_id"],
    userId: json["user_id"],
    businessId: json["business_id"],
    scheduledDate: json["scheduled_date"] == null ? null : DateTime.parse(json["scheduled_date"]),
    subtotalAmount: json["subtotal_amount"],
    taxAmount: json["tax_amount"],
    totalAmount: json["total_amount"],
    paymentMethod: json["payment_method"],
    notes: json["notes"],
    fulfilledAt: json["fulfilled_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    business: json["business"] == null ? null : Business.fromJson(json["business"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "status": status,
    "payment_status": paymentStatus,
    "address_id": addressId,
    "user_id": userId,
    "business_id": businessId,
    "scheduled_date": scheduledDate?.toIso8601String(),
    "subtotal_amount": subtotalAmount,
    "tax_amount": taxAmount,
    "total_amount": totalAmount,
    "payment_method": paymentMethod,
    "notes": notes,
    "fulfilled_at": fulfilledAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "business": business?.toJson(),
  };
}

class Business {
  int? id;
  String? name;
  String? coverImage;

  Business({
    this.id,
    this.name,
    this.coverImage,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
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
