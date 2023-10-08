import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FundWalletWebView extends StatefulWidget {
  final String url;
  const FundWalletWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<FundWalletWebView> createState() => _FundWalletWebViewState();
}

class _FundWalletWebViewState extends State<FundWalletWebView> {
  WebViewController? controller;
  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print('navigation url = ${request.url}');
            if (request.url.contains('status=cancelled')) {
              Get.snackbar('Canceled','Transactions Canceled',colorText: white,backgroundColor: persianRed);
              //  return NavigationDecision.prevent;
              Navigator.pop(context);
            }else if(request.url.contains('status=completed')){
              Get.snackbar('Success','Transactions Successful',colorText: white,backgroundColor: greenPea);
              Navigator.pop(context);
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: greenPea),
        title: Text('Make Payment',style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
        centerTitle: true,
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
        elevation: 0.0, backgroundColor: white,
      ),
      body:  SafeArea(child: WebViewWidget(controller: controller!,)),
    );
  }
}
//https://checkout.flutterwave.com/v3/hosted/pay/flwlnk-01h2dg9ady7vmpyxabt2bgq31a