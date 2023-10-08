import 'package:dexter_mobile/datas/model/user/user.dart';
import 'package:dexter_mobile/presentation/auth/login/pages/login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController{
  UserLoginResponseEntity headDetail = UserLoginResponseEntity();
  List<MeListItem> meListItem = <MeListItem>[].obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
  );

  Future<void> onLogOut()async{
    await _googleSignIn.signOut();
    Get.offAll(()=>Login());
  }

}