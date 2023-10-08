
class InAppNotificationResponse {
  String? status;
  String? message;
  List<NotificationList>? data;

  InAppNotificationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory InAppNotificationResponse.fromJson(Map<String, dynamic> json) => InAppNotificationResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationList>.from(json["data"]!.map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationList {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  DateTime? readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationList({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["id"],
    type: json["type"],
    notifiableType: json["notifiable_type"],
    notifiableId: json["notifiable_id"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_type": notifiableType,
    "notifiable_id": notifiableId,
    "data": data?.toJson(),
    "read_at": readAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Data {
  String? type;
  String? message;
  int? orderId;
  int? transactionId;
  int? bookingId;

  Data({
    this.type,
    this.message,
    this.orderId,
    this.transactionId,
    this.bookingId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    message: json["message"],
    orderId: json["order_id"],
    transactionId: json["transaction_id"],
    bookingId: json["booking_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "message": message == null ? null : message,
    "order_id": orderId == null ? null : orderId,
    "booking_id": bookingId == null ? null : bookingId,
    "transaction_id": transactionId == null ? null : transactionId,
  };
}
