import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{

  int current = 0;

  final List<String> imgList = [
    AssetPath.onBoardingBg1,
    AssetPath.onBoardingBg2,
    AssetPath.onBoardingBg3,
    AssetPath.onBoardingBg4
  ];

  final List<String> dexterOptions = [
    "Get Work Done",
    "Mouth-watering \nDelights",
    "Logistics",
    "Fast Deliveries"
  ];

  String? onBoardingText(){
    if(current == 0){
      return "We cover a wide range of maintenance \nrequests including electrical, cleaning, \ncarpentry, and so on.";
    }else if(current == 1){
      return "Order and get your meals hot and fast \nfrom your favourite restaurants.";
    }else if(current == 2){
      return "Get the beauty treatments you need, \nwhen you need them, with our on-\ndemand  beauty services.";
    }else if(current == 3){
      return "Say goodbye to laundry day hassles \nwith our reliable and convenient on-\ndemand laundry services.";
    }
  }

  String? onBoardingHeader(){
    if(current == 0){
      return "Get Work Done";
    }else if(current == 1){
      return "Mouth-watering \nDelights";
    }else if(current == 2){
      return "Logistics";
    }else if(current == 3){
      return "Fast Deliveries";
    }
  }

  @override
  void onInit() {
    update();
    super.onInit();
  }
}