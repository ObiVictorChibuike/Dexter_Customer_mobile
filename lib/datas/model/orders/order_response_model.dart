

class OrderResponseModel {
  String? status;
  String? message;
  List<Orders>? data;

  OrderResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Orders>.from(json["data"]!.map((x) => Orders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Orders {
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
  String? notes;
  dynamic paymentMethod;
  dynamic fulfilledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Shop? shop;

  Orders({
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
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
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
  };
}

enum Status {
  CANCELLED,
  PENDING
}

final statusValues = EnumValues({
  "cancelled": Status.CANCELLED,
  "pending": Status.PENDING
});

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

enum City {
  KS_87832
}

final cityValues = EnumValues({
  "KS 87832": City.KS_87832
});

enum FullAddress {
  THE_246_MORAR_WELL_LANDENVIEW_KS_87832
}

final fullAddressValues = EnumValues({
  "246 Morar Well\nLandenview, KS 87832": FullAddress.THE_246_MORAR_WELL_LANDENVIEW_KS_87832
});

enum Street {
  THE_246_MORAR_WELL_LANDENVIEW
}

final streetValues = EnumValues({
  "246 Morar Well\nLandenview": Street.THE_246_MORAR_WELL_LANDENVIEW
});

enum Name {
  ULLRICH_KLEIN_AND_BEAHAN
}

final nameValues = EnumValues({
  "Ullrich, Klein and Beahan": Name.ULLRICH_KLEIN_AND_BEAHAN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
