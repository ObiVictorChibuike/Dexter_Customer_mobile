

class ClearCartResponse {
  bool? success;
  String? message;
  List<dynamic>? data;

  ClearCartResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ClearCartResponse.fromJson(Map<String, dynamic> json) => ClearCartResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
