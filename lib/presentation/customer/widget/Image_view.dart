import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/app/shared/constants/strings.dart';
import 'package:dexter_mobile/data/business_services/business_details_model_response.dart';
import 'package:flutter/material.dart';
import 'custom_scroll_physics.dart';

class ImageViewer extends StatefulWidget{
  final int imageCount;
  final  List<BusinessImage>? imageUrl;
  ImageViewer({Key? key, required this.imageCount, this.imageUrl}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer>  with SingleTickerProviderStateMixin{
  final ctrl = PageController();
  int current = 0;

  @override
  void initState() {
    setState(() {});
    // controller = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    // controller?.addListener(() {
    //   setState(() {
    //    widget.selectedIndex = controller!.page!.toInt();
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget indicator(){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imageUrl!.map((x) {
          final index = widget.imageUrl!.indexOf(x);
          return Container(
            width: 5.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: current == index
                  ? greenPea
                  : Colors.grey.shade400,
            ),
          );
        }).toList(),
      );
    }

    return SafeArea(top: false, bottom: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0, centerTitle: true,
            leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xffF2F2F2), shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                )),
            title: Text("Photos",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontSize: 18,

                    fontWeight: FontWeight.bold)),
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.imageUrl!.isEmpty ||
                  widget.imageUrl == [] ||
                  widget.imageUrl == null ?
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height/2.6, width: MediaQuery.of(context).size.width, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: PageView.builder(
                        physics: const CustomPageViewScrollPhysics(),
                        itemCount: 6,
                        pageSnapping: true,
                        controller: ctrl,
                        onPageChanged: (page) {
                          setState(() {
                            current = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(imagePlaceHolder, fit: BoxFit.cover,),
                          );
                        }),
                  ),
                  Positioned(
                    right: 30,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                      child: Text("$current / ${6}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    ),
                  )
                ],
              ) :
              Stack(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height/2.6, width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      child: PageView.builder(
                          physics: const CustomPageViewScrollPhysics(),
                          itemCount: widget.imageUrl?.length,
                          pageSnapping: true,
                          controller: ctrl,
                          onPageChanged: (page) {
                            setState(() {
                              current = page;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(widget.imageUrl![pagePosition].imageUrl!, fit: BoxFit.cover,),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(15)),
                      child: Text("${current + 1} / ${widget.imageUrl!.length}", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    ),
                  )
                ],
              ),
              indicator(),
              const SizedBox(height: 70,)
            ],
          ),
        )
    );
  }
}
