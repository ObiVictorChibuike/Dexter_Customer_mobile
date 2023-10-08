import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController{
  var currentIndex = 0.obs;

  void onItemTapped(int index) {
    currentIndex.value = index;
    update();
  }
  void moveToBookings() {
    currentIndex = 1.obs;
    update();
  }
}