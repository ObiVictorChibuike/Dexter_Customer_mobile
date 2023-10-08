import 'dart:convert';
import 'dart:developer';
import 'package:dexter_mobile/data/profile/profile_response_model.dart';
import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/core/state/view_state.dart';
import 'package:dexter_mobile/data/address/add_address_response_model.dart';
import 'package:dexter_mobile/data/app_services_model/get_all_services_response_model.dart';
import 'package:dexter_mobile/data/auth_models/login_response_model.dart';
import 'package:dexter_mobile/data/notification/in_app_notification_model_response.dart';
import 'package:dexter_mobile/datas/location/get_location.dart';
import 'package:dexter_mobile/datas/model/location_and_address/add_address_response.dart';
import 'package:dexter_mobile/datas/model/location_and_address/get_address_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/get_all_category_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/get_product_in_category_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/product_in_shop_response.dart';
import 'package:dexter_mobile/datas/model/shop_response/shop_response.dart';
import 'package:dexter_mobile/datas/model/user/update_user-response.dart';
import 'package:dexter_mobile/datas/model/vendor/top_rated_vendor_response.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/address_and_location_repository.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/restaurant_repository.dart';
import 'package:dexter_mobile/datas/repository/dashboard_repository/vendor_respoitory.dart';
import 'package:dexter_mobile/datas/repository/user_repository/user_repository.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/location_and_address_services.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/restaurant_services.dart';
import 'package:dexter_mobile/datas/services/dashboard_services/vendor_services.dart';
import 'package:dexter_mobile/datas/services/user_services/user_services.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_data_state.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/domain/repository/dashboard/all_product_category_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/get_product_in_category_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/location_and_address_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/retaurant_repository_impl.dart';
import 'package:dexter_mobile/domain/repository/dashboard/top_rated_vendor_impl.dart';
import 'package:dexter_mobile/domain/repository/user/send_fcm_token_impl.dart';
import 'package:dexter_mobile/domain/repository/user/update_user_impl.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dexter_mobile/presentation/intro/page/onboarding_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_controller.dart';

class HomeController extends GetxController{
  final _getRestaurants = Get.put(RestaurantRepositoryImpl(RestaurantRepository(RestaurantServices())));
  final _getTopRatedVendor = Get.put(TopRatedRepositoryImpl(VendorRepository(VendorServices())));
  final _getAllProductCategory = Get.put(GetAllProductCategoryImpl(VendorRepository(VendorServices())));
  final _getProductsInCategory = Get.put(GetProductInCategoryImpl(VendorRepository(VendorServices())));
  final updateUser = Get.put(UpdateUserImpl(UserRepository(UserServices())));
  final sendFcmToken = Get.put(SendFcmTokenImpl(UserRepository(UserServices())));
  // final user = Get.put(UserRepositoryImpl(UserRepository(UserServices())));
  final getAddress = Get.put(GetAddressImpl(AddressAndLocationRepository(LocationAndAddressServices())));
  final addAddress = Get.put(AddAddressImpl(AddressAndLocationRepository(LocationAndAddressServices())));
  final removeAddress = Get.put(RemoveAddressImpl(AddressAndLocationRepository(LocationAndAddressServices())));

  int selectedIndex = 0;
  String? errorMessage;
  bool? notificationStatus;
  int? selectedVendorIndex;
  double? latitude, longitude;
  TopRatedVendorResponse? topRatedVendorResponse;
  List<Placemark>? placeMark;
  String? address;
  int enableNotificationPromptCount = 0;
  navigateToNextPage({ required int index}) {
    selectedVendorIndex = index;
  }

  getSelectedItem() {
    return topRatedVendorResponse?.data!.elementAt(selectedVendorIndex!);
  }

  Future<void> getNotificationStatus() async {
    notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
  update();
  }

  final notification = [
    {
      "assets": AssetPath.notification,
      "title": "Reminder",
      "body": "Fan Repair Inspection is scheduled for tomorrow",
      "duration": "13min"
    },
    {
      "assets": AssetPath.image,
      "title": "New Message",
      "body": "“Hey! I looked your problem and it’s fixed\n3 now. Can you confirm?”",
      "duration": "1hr"
    },
    {
      "assets": AssetPath.verified,
      "title": "Order Confirmed",
      "body": "Your Vehicle - Mini Van Order is successfully \nplaced.",
      "duration": "1hr"
    },

  ];

  ViewState<ShopsAroundYouResponse> viewState = ViewState(state: ResponseState.EMPTY);

  void _setViewState(ViewState<ShopsAroundYouResponse> viewState) {
    this.viewState = viewState;
  }

  ViewState<AddAddressResponse> addAddressViewState = ViewState(state: ResponseState.EMPTY);

  void _setAddAddressViewState(ViewState<AddAddressResponse> addAddressViewState) {
    this.addAddressViewState = addAddressViewState;
  }

  ViewState<GetAddressResponse> getAddressViewState = ViewState(state: ResponseState.EMPTY);

  void _setGetAddressViewState(ViewState<GetAddressResponse> getAddressViewState) {
    this.getAddressViewState = getAddressViewState;
  }

  ViewState<TopRatedVendorResponse> topRatedVendorViewState = ViewState(state: ResponseState.EMPTY);

  void _setTopRatedVendorViewState(ViewState<TopRatedVendorResponse> topRatedVendorViewState) {
    this.topRatedVendorViewState = topRatedVendorViewState;
  }

  ViewState<UpdateUserResponse> updateUserProfileViewState = ViewState(state: ResponseState.EMPTY);

  void _setUpdateUserProfileViewState(ViewState<UpdateUserResponse> updateUserProfileViewState) {
    this.updateUserProfileViewState = updateUserProfileViewState;
  }

  ViewState<ProductsInCategoryResponse> productsInCategoryState = ViewState(state: ResponseState.EMPTY);

  void _setProductsInCategoryState(ViewState<ProductsInCategoryResponse> productsInCategoryStateState) {
    this.productsInCategoryState = productsInCategoryStateState;
  }

  ViewState<ProductsInShop> productsInShopViewState = ViewState(state: ResponseState.EMPTY);

  void _setProductsInShopState(ViewState<ProductsInShop> productsInShopViewState) {
    this.productsInShopViewState = productsInShopViewState;
  }

  ViewState<dio.Response> userFcmTokenViewState = ViewState(state: ResponseState.EMPTY);

  void _setSendUserFcmTokenViewState(ViewState<dio.Response> userFcmTokenViewState) {
    this.userFcmTokenViewState = userFcmTokenViewState;
  }


  //Address List
  List<AddAddress>? addedAddress = <AddAddress>[].obs;
  List<ShopsAroundYou>? shopsAroundYou = <ShopsAroundYou>[].obs;

  Future<void> getRestaurantsAroundYou() async {
    _setViewState(ViewState.loading());
    update();
    final location = await GetLocation.instance!.checkLocation;
    await _getRestaurants.execute(params: ShopsAroundYouResponseParam(location.longitude, location.latitude, 1.toString())).then((value) async {
      if(value is DataSuccess || value.data != null) {
        await LocalCachedData.instance.getAppServices().then((value){
          appServicesResponse = value;
          update();
        });
        shopsAroundYou = value.data!.data!;
        update();
        _setViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        _setViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  GetAllCategoryResponse? getAllCategoryResponse;
  List<String?>? categoryNames;

  Future<void> getAllProductCategory({required String shopId})async{
    await _getAllProductCategory.execute(params: GetAllProductCategoryParam(shopId)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        getAllCategoryResponse = value.data;
        final myArray = getAllCategoryResponse!.categories!.map((e) => e.name).toList();
        categoryNames = myArray.toSet().toList();
        update();
      }
      if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        // _setUserDataViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  ProductsInCategoryResponse? productsInCategoryResponse;

  Future<void> getProductsInCategory({required String categoryId})async{
    await _getProductsInCategory.execute(params: GetProductInCategoryParam(categoryId)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        productsInCategoryResponse = value.data;
        update();
      }
      if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setProductsInCategoryState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  String selectedAddress = "";
  Future<void> getSelectedAddress() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getSelectedLocation().then((value){
      log(value.toString());
      if(value != null && value != ""){
        selectedAddress = value;
        log(selectedAddress);
        update();
      }
    });
  }

  // Future<void> getUserAddress({required String id}) async {
  //   _setGetAddressViewState(ViewState.loading());
  //   update();
  //   await getAddress.execute(params: GetAddressParam(id)).then((value) async {
  //     if(value is DataSuccess || value.data != null) {
  //       log("fetched");
  //       userAddresses = value.data?.data;
  //       log("done");
  //       _setGetAddressViewState(ViewState.complete(value.data!));
  //       update();
  //     }if (value is DataFailed || value.data == null) {
  //       if (kDebugMode) {
  //         print(value.error);
  //       }errorMessage = value.error.toString();
  //       _setGetAddressViewState(ViewState.error(value.error.toString()));
  //       update();
  //     }}
  //   );
  // }

  Future<void> addUserAddress({required String address}) async {
    _setAddAddressViewState(ViewState.loading());
    await addAddress.execute(params: AddAddressParam(address)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        addedAddress = value.data?.data;
        _setAddAddressViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }errorMessage = value.error.toString();
        _setAddAddressViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  // UpdateUserResponse? updateUserResponse;

  Future<void> updateUserProfile(String firstName, lastName, email)async{
    await updateUser.execute(params: UpdateUserProfileParam(firstName, lastName, email)).then((value) async {
      if(value is DataSuccess || value.data != null) {
        _setUpdateUserProfileViewState(ViewState.complete(value.data!));
        // updateUserResponse = value.data;
        update();
      }
      if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error.toString());
        }
        errorMessage = value.error.toString();
        _setUpdateUserProfileViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  String? fcmToken;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  getToken() async {
    await messaging.getToken().then((value){
      final token = value;
      fcmToken = token;
      log(fcmToken!);
    });
  }
  // getToken() async {
  //   fmcToken = await messaging.getToken(vapidKey: "BHOBCZzEo37ZyEkOJZf0EAikG_FPePe9C2XhTdbklsXtvcYkZqu1kilZbbJUm8Ph0iMs7ro5Pr3NoB9Ii8TYYo4");
  //   return fmcToken;
  // }

  Future<void> deleteFcmToken() async {
    progressIndicator(Get.context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final fcmToken = await LocalCachedData.instance.getVendorFcmToken();
    try{
      final response = await NetworkProvider().call(path: "/fcm-tokens/$fcmToken", method: RequestMethod.delete);
      await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: false);
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      Get.back();
      Get.snackbar("Success", "Notification Deactivated!", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> sendUserFcmToken() async {
    progressIndicator(Get.context);
    await getToken();
    try{
      var postBody = dio.FormData.fromMap({
        "token": fcmToken,
      });
      final response = await NetworkProvider().call(path: "/fcm-tokens", method: RequestMethod.post, body: postBody);
      log(response?.data["message"]);
      Get.back();
      Get.put<LocalCachedData>(await LocalCachedData.create());
      await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
      await LocalCachedData.instance.cacheVendorFcmToken(fcmToken: fcmToken!);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      Get.snackbar("Success", "Notification Activated!", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if(err.response?.data['message'] == "This token is already registered."){
        Get.back();
        Get.snackbar("Success", "Notification already activated", colorText: white, backgroundColor: greenPea);
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
      }
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: false);
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      Get.back();
      throw errorMessage;
    } catch (err) {
      if(err.toString() == "This token is already registered."){
        Get.back();
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
        notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
        update();
        Get.snackbar("Success", "Notification already activated", colorText: white, backgroundColor: greenPea);
      }else{
        Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: false);
        notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
        update();
        Get.back();
      }
      update();
      throw err.toString();
    }
  }

  Future<void> getTopRatedVendors() async {
    _setTopRatedVendorViewState(ViewState.loading());
    update();
    await _getTopRatedVendor.noParamCall().then((value) async {
      if(value is DataSuccess || value.data != null) {
        topRatedVendorResponse = value.data!;
        _setTopRatedVendorViewState(ViewState.complete(value.data!));
        update();
      }if (value is DataFailed || value.data == null) {
        if (kDebugMode) {
          print(value.error);
        }
        errorMessage = value.error.toString();
        _setTopRatedVendorViewState(ViewState.error(value.error.toString()));
        update();
      }}
    );
  }

  List<NotificationList>? inAppNotificationResponse = <NotificationList>[].obs;
  int notificationItem = 0;
  bool? inAppNotificationLoadingState;
  bool? inAppNotificationErrorState;
  Future<void> getInAppNotification()async{
    inAppNotificationLoadingState = true;
    inAppNotificationErrorState = false;
    inAppNotificationResponse == null;
    // update();
    try{
      final response = await NetworkProvider().call(path: "/notifications", method: RequestMethod.get);
      final payload = InAppNotificationResponse.fromJson(response!.data);
      inAppNotificationResponse = payload.data;
      update();
      if(payload.data!.isNotEmpty || payload.data != []){
        notificationItem = payload.data!.where((element) => element.readAt == null).length;
        update();
      }else{
        notificationItem = 0;
        update();
      }
      inAppNotificationLoadingState = false;
      inAppNotificationErrorState = false;
      update();
    }on DioError catch (err) {
      inAppNotificationLoadingState = false;
      inAppNotificationErrorState = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      // showErrorSnackBar(Get.context, title: "Something Went Wrong", content: err.response?.data['message'] ?? errorMessage);
      throw errorMessage;
    } catch (err) {
      inAppNotificationLoadingState = false;
      inAppNotificationErrorState = true;
      update();
      // showErrorSnackBar(Get.context, title: "Something Went Wrong", content: err.toString());
      throw err.toString();
    }
  }

  Future<void> markAsRead({required BuildContext context, required String notificationId, required bool isNotificationDetails})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/notifications/$notificationId/mark-as-read", method: RequestMethod.post);
      final message = response?.data["message"];
      await getInAppNotification().then((value){
        Get.back();
        isNotificationDetails == true ? Get.back() : null;
        Get.snackbar("Success",  message ?? "Marked as read", colorText: white, backgroundColor: greenPea);
      });
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  Future<void> markAllAsRead({required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/notifications/mark-all-as-read", method: RequestMethod.post);
      final message = response?.data["message"];
      await getInAppNotification();
      Get.back();
      Get.snackbar("Success",  message ?? "Marked as read", colorText: white, backgroundColor: greenPea);
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }

  ProfileResponseModel? profileResponse;
  AppServicesResponse? appServicesResponse;
  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    await LocalCachedData.instance.getProfileResponse().then((value){
      profileResponse = value;
      update();
    });
    super.onInit();
  }

  Future<void> login({required String street, required String city, required String state, required String country})async{
    progressIndicator(Get.context);
    try{
      var postBody = jsonEncode({
        "street":  street,
        "city": city,
        "state": state,
        "country": country,
      });
      final response = await NetworkProvider().call(path: "/addresses", method: RequestMethod.post, body: postBody);
      final payload = AddAddressResponseModel.fromJson(response?.data);
      Get.back();
      Get.snackbar("Success", payload.message ?? "Address Added Successfully");

    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      throw err.toString();
    }
  }


  @override
  void onInit() {
    getSelectedAddress();
    getRestaurantsAroundYou();
    getTopRatedVendors();
    getInAppNotification();
    // getLocation();
    // getNotificationStatus();
    onInitializeLocalStorage();
    // getRestaurantsAroundYou();
    // controller.getUserRestaurantFoodCart();
    // getAllVendors();
    // getTopRatedVendors();
    super.onInit();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly'
      ]
  );
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  Future<void> SignOut() async {
    if (_googleSignIn.currentUser != null){
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
    } else{
      await FirebaseAuth.instance.signOut();}
  }

  Future<void> logOut({required BuildContext context}) async {
    progressIndicator(Get.context!);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      await NetworkProvider().call(path: "/logout", method: RequestMethod.delete);
      final sharedPreferences = await SharedPreferences.getInstance();
      await LocalCachedData.instance.clearCache();
      await LocalCachedData.instance.onLogout();
      await SignOut();
      await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: false);
      sharedPreferences.clear();
      Get.back();
      Get.offUntil(MaterialPageRoute(builder: (context) => OnBoardingScreen()), (Route<dynamic> route) => false);
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong",  err.toString(), colorText: white, backgroundColor: persianRed);
      update();
      throw err.toString();
    }
  }




  final picker = ImagePicker();
  void onUploadProductPhoto(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      updateProfilePhoto = pickedFile;
      update();
    } catch (e) {
      final pickImageError = e;
      log(pickImageError.toString());
      update();
    }
  }

  XFile? updateProfilePhoto;

  Future<void> updateProfilePicture() async {
    progressIndicator(Get.context!);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      var postBody = dio.FormData.fromMap({
        "_method": "patch",
        "email": profileResponse?.data?.email ?? "",
        "first_name": profileResponse?.data?.lastName ?? "",
        "last_name": profileResponse?.data?.firstName ?? "",
        "phone": profileResponse?.data?.phone ?? "",
        "image": await dio.MultipartFile.fromFile(updateProfilePhoto!.path, filename: updateProfilePhoto!.path.split('/').last),
      });
      final response = await NetworkProvider().call(path: "/vendor/profile", method: RequestMethod.post, body: postBody);
      final value = ProfileResponseModel.fromJson(response!.data);
      await LocalCachedData.instance.cacheProfileResponse(profileResponse: value);
      await getProfile().then((value){
        onInitializeLocalStorage();
        updateProfilePhoto = null;
        update();
        Get.back();
        Get.snackbar("Success", "Profile Picture Updated", colorText: white, backgroundColor: greenPea);
      });
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] == "Request Entity Too Large" ? "Image Size is Too Large" : err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: greenPea);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString() == "Request Entity Too Large" ? "Image Size is Too Large" : err.toString(), colorText: white, backgroundColor: persianRed);
      update();
      throw err.toString();
    }
  }


  Future<void> getProfile() async {
    try{
      var response = await NetworkProvider().call(path: "/profile", method: RequestMethod.get,);
      final value = ProfileResponseModel.fromJson(response!.data);
      await LocalCachedData.instance.cacheProfileResponse(profileResponse: value);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error", err.response?.data['message'] ?? errorMessage, backgroundColor: persianRed, colorText: white);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Something Went Wrong", err.toString(), backgroundColor: persianRed, colorText: white);
      update();
      throw err.toString();
    }
  }

  Future<void> sendFcmTokenDuringLoging() async {
    await getToken();
    try{
      var postBody = dio.FormData.fromMap({
        "token": fcmToken,
      });
      final response = await NetworkProvider().call(path: "/fcm-tokens", method: RequestMethod.post, body: postBody);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
      await LocalCachedData.instance.cacheVendorFcmToken(fcmToken: fcmToken!);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if(err.response?.data['message'] == "This token is already registered."){
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
      }
      await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: false);
      notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
      update();
      throw errorMessage;
    } catch (err) {
      if(err.toString() == "This token is already registered."){
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: true);
      }else{
        await LocalCachedData.instance.cacheIsEnableNotificationStatus(isEnableNotification: false);
        notificationStatus = await LocalCachedData.instance.getIsEnableNotificationStatus();
        update();
      }
      update();
      throw err.toString();
    }
  }
}