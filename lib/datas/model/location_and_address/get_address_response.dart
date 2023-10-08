// To parse this JSON data, do
//
//     final getAddressResponse = getAddressResponseFromJson(jsonString);

import 'dart:convert';

GetAddressResponse getAddressResponseFromJson(String str) => GetAddressResponse.fromJson(json.decode(str));

String getAddressResponseToJson(GetAddressResponse data) => json.encode(data.toJson());

class GetAddressResponse {
  bool? success;
  String? message;
  List<Address>? data;

  GetAddressResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GetAddressResponse.fromJson(Map<String, dynamic> json) => GetAddressResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Address {
  int? addressId;
  int? userId;
  String? address;

  Address({
    this.addressId,
    this.userId,
    this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
