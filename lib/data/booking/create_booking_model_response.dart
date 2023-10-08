
class CreateBookingResponseModel {
  String? status;
  String? message;
  Data? data;

  CreateBookingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateBookingResponseModel.fromJson(Map<String, dynamic> json) => CreateBookingResponseModel(
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
  String? reference;
  int? userId;
  int? businessId;
  String? addressId;
  DateTime? scheduledDate;
  String? subtotalAmount;
  String? taxAmount;
  String? totalAmount;
  String? notes;
  String? status;
  String? paymentStatus;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.reference,
    this.userId,
    this.businessId,
    this.addressId,
    this.scheduledDate,
    this.subtotalAmount,
    this.taxAmount,
    this.totalAmount,
    this.notes,
    this.status,
    this.paymentStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reference: json["reference"],
    userId: json["user_id"],
    businessId: json["business_id"],
    addressId: json["address_id"],
    scheduledDate: json["scheduled_date"] == null ? null : DateTime.parse(json["scheduled_date"]),
    subtotalAmount: json["subtotal_amount"],
    taxAmount: json["tax_amount"],
    totalAmount: json["total_amount"],
    notes: json["notes"],
    status: json["status"],
    paymentStatus: json["payment_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "user_id": userId,
    "business_id": businessId,
    "address_id": addressId,
    "scheduled_date": scheduledDate?.toIso8601String(),
    "subtotal_amount": subtotalAmount,
    "tax_amount": taxAmount,
    "total_amount": totalAmount,
    "notes": notes,
    "status": status,
    "payment_status": paymentStatus,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
