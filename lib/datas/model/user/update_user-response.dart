
class UpdateUserResponse {
  UpdateUserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) => UpdateUserResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
  };
}
