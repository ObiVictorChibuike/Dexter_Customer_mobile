

class BookingDetailsModelResponse {
  String? status;
  String? message;
  Data? data;

  BookingDetailsModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BookingDetailsModelResponse.fromJson(Map<String, dynamic> json) => BookingDetailsModelResponse(
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
  Address? address;

  Data({
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
    this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
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
    "address": address?.toJson(),
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

class Business {
  int? id;
  String? name;
  String? coverImage;
  ContactAddress? contactAddress;

  Business({
    this.id,
    this.name,
    this.coverImage,
    this.contactAddress,
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
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
