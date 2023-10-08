import 'package:carousel_slider/carousel_slider.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/widgets/dexter_primary_button.dart';
import 'package:dexter_mobile/presentation/auth/login/pages/login.dart';
import 'package:dexter_mobile/presentation/intro/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'landing_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = Get.put(OnBoardingController());
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                  height: height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      controller.current = index;
                    });
                  }
              ),
              items: controller.imgList.map((item) => Center(
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.cover, height: height, width: width,),
                  ],
                ),
              )).toList(),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.3,
            color: white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 70,),
                  Text(controller.onBoardingHeader()!, textAlign: TextAlign.center, style: const TextStyle(
                    color: black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: Text(controller.onBoardingText()!, textAlign: TextAlign.center, style: const TextStyle(
                      color: black, fontSize: 15.0, fontWeight: FontWeight.w400,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.imgList.map((x) {
                      final index = controller.imgList.indexOf(x);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.current == index
                              ? greenPea
                              : Colors.grey.shade400,
                        ),
                      );

                    }).toList(),
                  ),
                  const SizedBox(height: 50,),
                  controller.current == 3 ? DexterPrimaryButton(
                    onTap: (){
                      Get.to(()=> const LandingPage());
                    },
                    btnTitle: "Get started", btnTitleSize: 16, borderRadius: 35, btnHeight: 56,
                    btnWidth: MediaQuery.of(context).size.width,
                  ) :
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                            Get.to(()=> Login());
                        },
                        child: DexterPrimaryButton(
                          buttonBorder: white, btnHeight: 52, btnTitleSize: 16, borderRadius: 35,
                          btnTitle: "Skip", btnColor: white, titleColor: greenPea,
                          btnWidth: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      DexterPrimaryButton(
                        onTap: (){
                          if(controller.current == 0){
                            setState(() {
                              controller.current = 1;
                              carouselController.nextPage();
                            });
                          }else if (controller.current == 1){
                            setState(() {
                              controller.current = 2;
                              carouselController.nextPage();
                            });
                          }else if (controller.current == 2){
                            setState(() {
                              controller.current = 3;
                              carouselController.nextPage();
                            });
                          }else if(controller.current == 3){
                            Get.to(()=> LandingPage());
                          }
                        },
                        btnTitle: "Next", btnHeight: 52, borderRadius: 35, btnTitleSize: 16,
                        btnWidth: MediaQuery.of(context).size.width / 3,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

