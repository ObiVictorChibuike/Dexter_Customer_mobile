import 'package:dexter_mobile/app/shared/app_assets/assets_path.dart';
import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/app/shared/utils/custom_date.dart';
import 'package:dexter_mobile/presentation/customer/controller/order_controller.dart';
import 'package:dexter_mobile/presentation/customer/widget/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'order_progress.dart';

class ConfirmedOrderScreen extends StatefulWidget {
  const ConfirmedOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmedOrderScreen> createState() => _ConfirmedOrderScreenState();
}

class _ConfirmedOrderScreenState extends State<ConfirmedOrderScreen> {
  final _controller = Get.find<OrderController>();


  @override
  void initState() {
    _controller.getConfirmedOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: OrderController(),
        builder: (controller){
          return _controller.confirmedOrderResponseModel == null || _controller.confirmedOrderResponseModel!.isEmpty && _controller.getConfirmOrderLoadingState == true && _controller.getPendingOrderErrorState == false ?
          CircularLoadingWidget() : _controller.confirmedOrderResponseModel == null || _controller.confirmedOrderResponseModel!.isEmpty && _controller.getConfirmOrderLoadingState == false &&
              _controller.getConfirmOrderErrorState == false ?
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetPath.emptyFile, height: 120, width: 120,),
                const SizedBox(height: 40,),
                Text("You have no confirmed Orders",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: dustyGray, fontSize: 14, fontWeight: FontWeight.w400),),
              ],
            ),
          ) : _controller.confirmedOrderResponseModel != null || _controller.confirmedOrderResponseModel!.isNotEmpty && _controller.getConfirmOrderLoadingState == false &&
              _controller.getConfirmOrderErrorState == false ?
          Column(
            children: [
              const SizedBox(height: 10,),
              ...List.generate( _controller.confirmedOrderResponseModel!.length, (index){
                final item = _controller.confirmedOrderResponseModel![index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> OrderProgressScreen(id: _controller.confirmedOrderResponseModel![index].id!));
                      },
                      child: Container(
                        width: double.maxFinite, padding: EdgeInsets.all(16),
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: dustyGray)),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    item.shop?.coverImage ?? imagePlaceHolder , height: 40, width: 40, fit: BoxFit.cover,),
                                ),
                                const SizedBox(width: 15,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.shop?.name ?? ""}",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 14, fontWeight: FontWeight.w600),),
                                    Text(CustomDate.slash(item.createdAt.toString()),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xff8F92A1), fontSize: 12, fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: tulipTree, borderRadius: BorderRadius.circular(2)),
                              child: Text(item.status ?? "",  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: white, fontSize: 10, fontWeight: FontWeight.w700),),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                );
              })
            ],
          ) : CircularLoadingWidget();
        });
  }
}
