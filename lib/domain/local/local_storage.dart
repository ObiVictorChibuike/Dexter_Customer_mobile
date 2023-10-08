import 'dart:convert';
import 'package:dexter_mobile/app/shared/constants/firestore_constants.dart';
import 'package:dexter_mobile/data/app_services_model/get_all_services_response_model.dart';
import 'package:dexter_mobile/data/auth_models/login_response_model.dart';
import 'package:dexter_mobile/data/profile/profile_response_model.dart';
import 'package:dexter_mobile/datas/model/shop_response/card_response.dart';
import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  Future<String?> getAuthToken() async {
    String? token = _prefs.getString("token");
    return token;
  }

  Future<void> cacheAuthToken({required String? token}) async {
    _prefs.setString("token", token!);
  }

  Future<void> cachePassword({required String? password}) async {
    _prefs.setString("password", password!);
  }

  Future<String?> getPassword() async {
    String? password = _prefs.getString("password");
    return password;
  }

  Future<void> cachePhoneNumber({required String? phoneNumber}) async {
    _prefs.setString("phoneNumber", phoneNumber!);
  }

  Future<String?> getPhoneNumber() async {
    String? password = _prefs.getString("phoneNumber");
    return password;
  }

  Future<void> cacheProfileResponse({required ProfileResponseModel profileResponse}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("profileResponse", json.encode(profileResponse.toJson()));
  }

  Future<ProfileResponseModel?> getProfileResponse() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? profile = sharedPreferences.getString("profileResponse");
    return profile == null ? null : ProfileResponseModel.fromJson(jsonDecode(profile));
  }

  Future<void> cacheAppServices({required AppServicesResponse appServicesResponse}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("app_services", json.encode(appServicesResponse.toJson()));
  }

  Future<AppServicesResponse?> getAppServices() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? appServicesResponse = sharedPreferences.getString("app_services");
    return appServicesResponse == null ? null : AppServicesResponse.fromJson(jsonDecode(appServicesResponse));
  }

  Future<void> cacheCardResponse({required CardResponse cardResponse}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("card_response", json.encode(cardResponse.toJson()));
  }

  Future<CardResponse?> getCardResponse() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? cardResponse = sharedPreferences.getString("card_response");
    return cardResponse == null ? null : CardResponse.fromJson(jsonDecode(cardResponse));
  }

  Future<bool> getLoginStatus() async {
    bool? loginStatus = _prefs.getBool("isLoggedIn");
    return loginStatus ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  Future<String?> getVendorFcmToken() async {
    String? fcmToken = _prefs.getString("fcm_token");
    return fcmToken == null ? null : fcmToken;
  }

  Future<void> cacheVendorFcmToken({required String fcmToken}) async {
    _prefs.setString("fcm_token", fcmToken);
  }

  Future<bool?> getIsEnableNotificationStatus() async {
    bool? isEnableNotification = _prefs.getBool("isEnableNotification");
    return isEnableNotification;
  }

  Future<void> cacheIsEnableNotificationStatus({required bool isEnableNotification}) async {
    _prefs.setBool("isEnableNotification", isEnableNotification);
  }

  Future<void> clearCache() async {
    _prefs.clear();
  }

  Future<void> onLogout() async {
    await _prefs.remove(FirestoreConstants.id);
    // await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    // _isLogin.value = false;
    // token = '';
  }

  Future<String?> getCurrentUserId() async {
    String? userId = _prefs.getString(FirestoreConstants.id);
    return userId;
  }
  Future<void> cacheCurrentUserId({required String? userId}) async {
    _prefs.setString(FirestoreConstants.id, userId!);
  }

  Future<String?> getCurrentUserType() async {
    String? userType = _prefs.getString(FirestoreConstants.userType);
    return userType;
  }
  Future<void> cacheCurrentUserType({required String? userType}) async {
    _prefs.setString(FirestoreConstants.userType, userType!);
  }

  Future<String?> getCurrentUserAboutMe() async {
    String? userAboutMe = _prefs.getString(FirestoreConstants.aboutMe);
    return userAboutMe;
  }
  Future<void> cacheCurrentUserAboutMe({required String? userAboutMe}) async {
    _prefs.setString(FirestoreConstants.aboutMe, userAboutMe!);
  }

  Future<String?> getCurrentUserNickName() async {
    String? userNickName = _prefs.getString(FirestoreConstants.nickname);
    return userNickName;
  }
  Future<void> cacheCurrentUserNickName({required String? userNickName}) async {
    _prefs.setString(FirestoreConstants.nickname, userNickName!);
  }

  Future<String?> getCurrentUserPhotoUrl() async {
    String? userPhotoUrl = _prefs.getString(FirestoreConstants.photoUrl);
    return userPhotoUrl;
  }
  Future<void> cacheCurrentPhotoUrl({required String? userPhotoUrl}) async {
    _prefs.setString(FirestoreConstants.photoUrl, userPhotoUrl!);
  }

  Future<void> saveUserDetails({required UserLoginResponseEntity userLoginResponseEntity}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userLoginResponseEntity", jsonEncode(userLoginResponseEntity));
  }

  Future<UserLoginResponseEntity> fetchUserDetails() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString("userLoginResponseEntity");
    return UserLoginResponseEntity.fromJson(jsonDecode(userData!));
  }

  Future<String?> getUserCartId() async {
    String? cartId = _prefs.getString("cart_id");
    return cartId;
  }
  Future<void> cacheUserCartId({required String? cartId}) async {
    _prefs.setString("cart_id", cartId!);
  }

  Future<void> clearUserCartId() async {
    _prefs.remove("cart_id");
  }

  Future<String?> getUserShopId() async {
    String? cartId = _prefs.getString("shop_id");
    return cartId;
  }
  Future<void> cacheUserShopId({required String? shopId}) async {
    _prefs.setString("shop_id", shopId!);
  }

  Future<String?> getSelectedLocation() async {
    String? location = _prefs.getString("location");
    return location;
  }

  Future<void> cacheSelectedLocation({required String? location}) async {
    _prefs.setString("location", location!);
  }

  Future<String?> getSelectedLocationId() async {
    String? locationId = _prefs.getString("location_id");
    return locationId;
  }

  Future<void> cacheSelectedLocationId({required String? locationId}) async {
    _prefs.setString("location_id", locationId!);
  }
}