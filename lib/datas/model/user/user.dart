import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? id;
  final String? name;
  final String? email;
  final String? photourl;
  final String? location;
  final String? fcmtoken;
  final Timestamp? addtime;
  final String? userType;
  final String? businessType;
  final String? businessName;
  final String? businessCoverPhoto;
  final String? businessBio;
  final String? businessOpenTime;
  final String? businessCloseTime;
  final String? businessAddress;

  UserData({
    this.id,
    this.name,
    this.email,
    this.photourl,
    this.location,
    this.fcmtoken,
    this.addtime,
    this.userType,
    this.businessType,
    this.businessName,
    this.businessCoverPhoto,
    this.businessBio,
    this.businessOpenTime,
    this.businessCloseTime,
    this.businessAddress,
  });

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserData(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      photourl: data?['photourl'],
      location: data?['location'],
      fcmtoken: data?['fcmtoken'],
      addtime: data?['addtime'],
      userType: data?["user_type"],
      businessType: data?['business_type'],
      businessCoverPhoto: data?['business_cover_photo'],
      businessOpenTime: data?['business_open_time'],
      businessCloseTime: data?['business_close_time'],
      businessBio: data?['business_bio'],
      businessName: data?['business_name'],
      businessAddress: data?['business_address'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photourl != null) "photourl": photourl,
      if (location != null) "location": location,
      if (fcmtoken != null) "fcmtoken": fcmtoken,
      if (addtime != null) "addtime": addtime,
      if (userType != null) "user_type": userType,
      if (businessType != null) "business_type": businessType,
      if (businessCoverPhoto != null) "business_cover_photo": businessCoverPhoto,
      if (businessOpenTime != null) "business_open_time": businessOpenTime,
      if (businessCloseTime != null) "business_close_time": businessCloseTime,
      if (businessBio != null) "business_bio": businessBio,
      if (businessName != null) "business_name": businessName,
      if (businessAddress != null) "business_address": businessAddress,
    };
  }
}

// 登录返回
class UserLoginResponseEntity {
  String? userId;
  String? userDexterId;
  String? displayName;
  String? email;
  String? photoUrl;
  String? userType;
  String? businessType;
  String? phoneNumber;
  String? businessName;
  String? businessCoverPhoto;
  String? businessBio;
  String? businessOpenTime;
  String? businessCloseTime;
  String? businessAddress;

  UserLoginResponseEntity({
    this.userId,
    this.userDexterId,
    this.displayName,
    this.email,
    this.photoUrl,
    this.userType,
    this.businessType,
    this.phoneNumber,
    this.businessName,
    this.businessCoverPhoto,
    this.businessBio,
    this.businessOpenTime,
    this.businessCloseTime,
    this.businessAddress,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        userId: json["access_token"],
        userDexterId: json["dexter_Id"],
        displayName: json["display_name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        userType: json['user_type'],
        businessType: json['business_type'],
        phoneNumber: json['phone_number'],
        businessCoverPhoto: json['business_cover_photo'],
        businessOpenTime: json['business_open_time'],
        businessCloseTime: json['business_close_time'],
        businessBio: json['business_bio'],
        businessName: json['business_name'],
        businessAddress: json['business_address'],
      );

  Map<String, dynamic> toJson() => {
    "access_token": userId,
    "dexter_Id": userDexterId,
    "display_name": displayName,
    "email": email,
    "photoUrl": photoUrl,
    "user_type": userType,
    "business_type": businessType,
    "phone_number": phoneNumber,
    "business_cover_photo": displayName,
    "business_open_time": email,
    "business_close_time": photoUrl,
    "business_bio": userType,
    "business_name": businessType,
    " business_address": phoneNumber
  };
}

class MeListItem {
  String? name;
  String? icon;
  String? explain;
  String? route;


  MeListItem({
    this.name,
    this.icon,
    this.explain,
    this.route,
  });

  factory MeListItem.fromJson(Map<String, dynamic> json) =>
      MeListItem(
        name: json["name"],
        icon: json["icon"],
        explain: json["explain"],
        route: json["route"],
      );
}
