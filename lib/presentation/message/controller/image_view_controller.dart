import 'package:get/get.dart';

class ImageViewController extends GetxController{
  String? imageUrl;

  @override
  void onInit() {
    update();
    super.onInit();
  }
}