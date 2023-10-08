
class PayWithPayStackResponseModel {
  String? status;
  String? message;
  Data? data;

  PayWithPayStackResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory PayWithPayStackResponseModel.fromJson(Map<String, dynamic> json) => PayWithPayStackResponseModel(
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
  String? authorizationUrl;

  Data({
    this.authorizationUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    authorizationUrl: json["authorization_url"],
  );

  Map<String, dynamic> toJson() => {
    "authorization_url": authorizationUrl,
  };
}
