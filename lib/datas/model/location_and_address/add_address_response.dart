

class AddAddressResponse {
  bool? success;
  String? message;
  List<AddAddress>? data;

  AddAddressResponse({
    this.success,
    this.message,
    this.data,
  });

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) => AddAddressResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AddAddress>.from(json["data"]!.map((x) => AddAddress.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddAddress {
  int? addressId;
  int? userId;
  String? address;

  AddAddress({
    this.addressId,
    this.userId,
    this.address,
  });

  factory AddAddress.fromJson(Map<String, dynamic> json) => AddAddress(
    addressId: json["address_id"],
    userId: json["user_id"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId,
    "user_id": userId,
    "address": address,
  };
}
