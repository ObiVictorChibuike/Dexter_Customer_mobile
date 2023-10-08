
class RegistrationResponse {
  String? status;
  String? message;
  Data? data;

  RegistrationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
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
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
