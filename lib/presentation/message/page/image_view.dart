import 'package:dexter_mobile/presentation/message/controller/image_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final String? imageUrl;
  const ImageView({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageViewController>(
        init: ImageViewController(),
        builder: (controller){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
              elevation: 0, backgroundColor: Colors.white,
              bottom: PreferredSize(
                child: Container(
                  color: Colors.white, height: 2.0,
                ),
                preferredSize: Size.fromHeight(1.0),
              ),
              title: Text("PhotoView", style:  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),),
            ),
            body: Container(
              child: PhotoView(
                imageProvider: NetworkImage(controller.imageUrl ?? ""),
              ),
            ),
          );
        });
  }

  final _controller = Get.put(ImageViewController());

  @override
  void initState() {
    if(widget.imageUrl != null){
      _controller.imageUrl = widget.imageUrl;
      setState(() {});
    }
    super.initState();
  }
}
