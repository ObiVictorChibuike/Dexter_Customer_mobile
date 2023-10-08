import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/firestore_constants.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/data/auth_models/login_response_model.dart';
import 'package:dexter_mobile/data/auth_models/registration_response_model.dart';
import 'package:dexter_mobile/data/profile/profile_response_model.dart';
import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/auth/login/pages/login.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as UserAuth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class RegistrationController extends GetxController{
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Status _status = Status.uninitialized;
  Status get status => _status;

  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }

  Future<void> getAuthUserWithFirebase() async {
    try{
      var response = await NetworkProvider().call(path: "/profile", method: RequestMethod.get);
      final value = ProfileResponseModel.fromJson(response!.data);
      await LocalCachedData.instance.cacheProfileResponse(profileResponse: value);
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
      update();
      throw err.toString();
    }
  }

  Future<void> registerUser({required String firstName, required String lastName, required String email, required String phone, required String password})async{
    progressIndicator(Get.context!);
    try{
      var postBody = jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": password
      });
      final response = await NetworkProvider().call(path: AppConfig.register, method: RequestMethod.post, body: postBody);
      final value = RegistrationResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheAuthToken(token: value.data!.token).then((value) async {
        await getProfile().then((value) async {
          await LocalCachedData.instance.getProfileResponse().then((value) async {
            // var uuid = Uuid();
            UserLoginResponseEntity userProfile = UserLoginResponseEntity();
            userProfile.email = value!.data!.email;
            userProfile.userId = value.data!.id.toString();
            // userProfile.userId = uuid.v4();
            userProfile.displayName = "${value.data!.firstName} ${value.data!.lastName}";
            userProfile.photoUrl = imagePlaceHolder;
            userProfile.userType = "Customer";
            userProfile.phoneNumber = value.data!.phone;
            await LocalCachedData.instance.saveUserDetails(userLoginResponseEntity: userProfile);
            await LocalCachedData.instance.cacheCurrentUserType(userType: "Customer");
            await LocalCachedData.instance.cacheCurrentUserId(userId: userProfile.userId);
            await LocalCachedData.instance.cachePhoneNumber(phoneNumber: userProfile.phoneNumber);
            var userDataStore = await firebaseFirestore.collection(FirestoreConstants.pathUserCollection)
                .withConverter(fromFirestore: UserData.fromFirestore,toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore(),).where("id", isEqualTo: userProfile.userId).where("user_type", isEqualTo: "Customer").get();
            if(userDataStore.docs.isEmpty){
              final data = UserData(
                  id: userProfile.userId, name: userProfile.displayName, email: userProfile.email,
                  photourl: userProfile.photoUrl, location: "", fcmtoken: "",
                  addtime: Timestamp.now(), userType: "Customer", businessType: "",
                  businessName:"", businessBio: "", businessCloseTime: "", businessOpenTime:"",
                  businessAddress:"", businessCoverPhoto: imagePlaceHolder);
              await firebaseFirestore.collection(FirestoreConstants.pathUserCollection).withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore(),
              ).add(data);}
            await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
            final ctrl = Get.put(HomeController());
            await ctrl.onInitializeLocalStorage();
            await ctrl.getRestaurantsAroundYou();
            await ctrl.getSelectedAddress();
            await ctrl.getRestaurantsAroundYou();
            await ctrl.getTopRatedVendors();
            await ctrl.getInAppNotification();
            Get.back();
            Get.offAll(()=> const BottomNavigationBarScreen());
          });
        });
      });
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

  Future<bool> handleSignIn() async {
    progressIndicator(Get.context);
    _status = Status.authenticating;
    update();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserAuth.User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        String displayName = user.displayName ?? "";
        String email = user.email ?? "";
        String id = user.uid;
        String phoneNumber = user.phoneNumber ?? "08199999999";
        String photoUrl = user.photoURL ?? profilePicturePlaceHolder;
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.userId = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        userProfile.userType = "Customer";
        userProfile.phoneNumber = phoneNumber;
        Get.put<LocalCachedData>(await LocalCachedData.create());
        await LocalCachedData.instance.saveUserDetails(userLoginResponseEntity: userProfile);
        await LocalCachedData.instance.cacheCurrentUserType(userType: "Customer");
        await LocalCachedData.instance.cacheCurrentUserId(userId: userProfile.userId);
        await LocalCachedData.instance.cachePhoneNumber(phoneNumber: userProfile.phoneNumber);
        var userDataStore = await firebaseFirestore.collection(FirestoreConstants.pathUserCollection)
            .withConverter(fromFirestore: UserData.fromFirestore,toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore(),).where("id", isEqualTo: id).get();
        if(userDataStore.docs.isEmpty){
          final data = UserData(
              id: id, name: displayName,
              email: email, photourl: photoUrl,
              location: "", fcmtoken: "", addtime: Timestamp.now(),
              userType: "Customer", businessType: "");
          await firebaseFirestore.collection(FirestoreConstants.pathUserCollection).withConverter(fromFirestore: UserData.fromFirestore,toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore(),).add(data);
        }
        await registerWithFireBaseAccount(displayName.split(" ").first, displayName.split(" ").last, email, phoneNumber, "${email}");
        _status = Status.authenticated;
        Get.back();
        update();
        return true;
      } else {
        _status = Status.authenticateError;
        Get.back();
        update();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      Get.back();
      update();
      return false;
    }
  }


  Future<void> registerWithFireBaseAccount(String firstName, String lastName, String email, String phone, String password)async{
    try{
      var postBody = jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": password
      });
      final response = await NetworkProvider().call(path: AppConfig.register, method: RequestMethod.post, body: postBody);
      final value = RegistrationResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheAuthToken(token: value.data!.token);
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
        Get.offAll(()=> const BottomNavigationBarScreen());
        update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.back();
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      update();
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
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

  void handleException() {
    _status = Status.authenticateException;
    update();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}