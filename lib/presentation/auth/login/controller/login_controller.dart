import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/firestore_constants.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/widgets/custom_snack.dart';
import 'package:dexter_mobile/data/app_services_model/get_all_services_response_model.dart';
import 'package:dexter_mobile/data/auth_models/login_response_model.dart';
import 'package:dexter_mobile/data/profile/profile_response_model.dart';
import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/app_config.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_client.dart';
import 'package:dexter_mobile/domain/remote/network_services/dio_service_config/dio_error.dart';
import 'package:dexter_mobile/presentation/bottom_navigation_bar_screen.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/progress_indicator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as AuthUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class LoginController extends GetxController{

  //Variables
  bool togglePassword = true;

  void togglePasswordVisibility(){
    togglePassword = !togglePassword;
    update();
  }

  final homeController = Get.put(HomeController());
  //To login in a registered user and cache login response locally
  Future<void> login({required String email, required String password})async{
    progressIndicator(Get.context);
    try{
      var postBody = jsonEncode({
        "email":  email,
        "password": password,
      });
      final response = await NetworkProvider().call(path: AppConfig.login, method: RequestMethod.post, body: postBody);
      final value = LoginResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheAuthToken(token: value.data!.token);
      await homeController.sendFcmTokenDuringLoging();


      Get.delete<HomeController>();
      await getProfile().then((value) async {
        //Check firebase to see if user already exist
        final data = await LocalCachedData.instance.getProfileResponse();
        // var uuid = Uuid();
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = data!.data!.email;
        userProfile.userId = data.data!.id.toString();
        // userProfile.userId = uuid.v4();
        userProfile.displayName = "${data.data!.firstName} ${data.data!.lastName}";
        userProfile.photoUrl = imagePlaceHolder;
        userProfile.userType = "Customer";
        userProfile.phoneNumber = data.data!.phone;
        await LocalCachedData.instance.saveUserDetails(userLoginResponseEntity: userProfile);
        await LocalCachedData.instance.cacheCurrentUserType(userType: "Customer");
        await LocalCachedData.instance.cacheCurrentUserId(userId: userProfile.userId);
        await LocalCachedData.instance.cachePhoneNumber(phoneNumber: userProfile.phoneNumber);
        await firebaseFirestore.collection(FirestoreConstants.pathUserCollection).withConverter(fromFirestore: UserData.fromFirestore,toFirestore: (UserData userChatModel, options)=> userChatModel.toFirestore(),).
        where("id", isEqualTo: userProfile.userId).where("user_type", isEqualTo: "Customer").get();
        await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
        Get.back();
        Get.offAll(()=> const BottomNavigationBarScreen());
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

  AppServicesResponse? appServicesResponse;

  Future<void> getAppServices()async{
    try{
      final response = await NetworkProvider().call(path: AppConfig.services, method: RequestMethod.get);
      final value = AppServicesResponse.fromJson(response!.data);
      await LocalCachedData.instance.cacheAppServices(appServicesResponse: value);
      update();
    }on DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar("Error",err.response?.data['message'] ?? errorMessage, colorText: white, backgroundColor: persianRed);
      throw errorMessage;
    } catch (err) {
      Get.snackbar("Error",err.toString(), colorText: white, backgroundColor: persianRed);
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



  // Future<void> getAuthUser() async {
  //   try{
  //     var response = await NetworkProvider().call(path: AppConfig.user, method: RequestMethod.get,);
  //     final value = AuthUserResponse.fromJson(response!.data);
  //     final userid = value.data?.id;
  //     await LocalCachedData.instance.cacheAuthUser(authUserResponse: value);
  //     final _controller = Get.put(HomeController());
  //     await GetLocation.instance!.checkLocation.then((value) async {
  //       _controller.latitude = value.latitude;
  //       _controller.longitude = value.longitude;
  //       final placeMarks = await placemarkFromCoordinates(_controller.latitude!, _controller.longitude!,localeIdentifier: "en");
  //       _controller.placeMark = placeMarks;
  //       _controller.address = "${placeMarks.first.street} ${placeMarks.first.locality}";
  //       await getUserAddress(id: userid.toString()).then((value) async {
  //       });
  //     });
  //   }on DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.response?.data['message'] ?? errorMessage);
  //     update();
  //     throw errorMessage;
  //   } catch (err) {
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.toString());
  //     update();
  //     throw err.toString();
  //   }
  // }

  // List<Address>? userAddresses = <Address>[].obs;
  //
  // Future<void> getUserAddress({required String id}) async {
  //   try{
  //     var response = await NetworkProvider().call(path: "/api/address/$id", method: RequestMethod.get,);
  //     final value = GetAddressResponse.fromJson(response!.data);
  //     userAddresses = value.data;
  //   }on DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.response?.data['message'] ?? errorMessage);
  //     update();
  //     throw errorMessage;
  //   } catch (err) {
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.toString());
  //     update();
  //     throw err.toString();
  //   }
  // }
  //
  // List<AddAddress>? addedAddress = <AddAddress>[].obs;
  // Future<void> addUserAddress({required String address}) async {
  //   try{
  //     var postBody = jsonEncode({
  //       "address":  address,
  //     });
  //     final response = await NetworkProvider().call(path: "/api/address/store", method: RequestMethod.post, body: postBody);
  //     final value = AddAddressResponse.fromJson(response!.data);
  //     addedAddress = value.data;
  //   }on DioError catch (err) {
  //     final errorMessage = Future.error(ApiError.fromDio(err));
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.response?.data['message'] ?? errorMessage);
  //     update();
  //     throw errorMessage;
  //   } catch (err) {
  //     Get.back();
  //     showErrorSnackBar(Get.context,
  //         title: "Something Went Wrong",
  //         content: err.toString());
  //     update();
  //     throw err.toString();
  //   }
  // }



  final googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Status _status = Status.uninitialized;
  Status get status => _status;

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
      AuthUser.User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        String displayName = user.displayName ?? "";
        String email = user.email ?? "";
        String id = user.uid;
        String phoneNumber = user.phoneNumber ?? "";
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
        // await loginWithFirebase(email,"${email}");
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


  Future<void> onInitializeLocalStorage() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    super.onInit();
  }

  @override
  void onInit() {
    onInitializeLocalStorage();
    super.onInit();
  }
}