import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/data/app_services_model/get_all_services_response_model.dart';
import 'package:dexter_mobile/presentation/customer/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTypeButton extends StatelessWidget {
  final int? selected;
  final Function? callback;
  final List<AllAppServices>? category;
  const CategoryTypeButton({this.selected, this.callback, this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
        builder: (controller){
      return Container(
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => callback!(index),
            child: Container(
              // width: 120,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: index == 0 ? Color(0xffD9F2EA)
                    : index == 1 ? Color(0xffFBEEDC) : index == 2 ? Color(0xffF9DFDF) : index == 3 ? Color(0xffEDF3FF) :
                index == 4 ? Color(0xffEDF3FF) : index == 5 ? Color(0xffFFEAFC) : index == 6? Color(0xffD9F2EA) : Color(0xffF9DFDF),
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.appServicesResponse?.data?[index].coverImage ?? imagePlaceHolder,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 30, width: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) => CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => ClipRRect(borderRadius: BorderRadius.circular(40),
                          child: Image.network(imagePlaceHolder, height: 30, width: 30, fit: BoxFit.cover,)),
                      // errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      controller.appServicesResponse?.data?[index].name ?? "", overflow: TextOverflow.clip, maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w600),
                    )
                    // Expanded(
                    //   child: Text(
                    //     controller.appServicesResponse?.data?[index].name ?? "", overflow: TextOverflow.clip, maxLines: 2,
                    //     style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                )),
          ),
          separatorBuilder: (_, __) => SizedBox(
            width: 10,
          ),
          itemCount: controller.appServicesResponse!.data!.length,
        ),
      );
    });
  }
}
