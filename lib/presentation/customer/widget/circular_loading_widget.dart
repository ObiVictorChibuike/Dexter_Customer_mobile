import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatefulWidget {
  const CircularLoadingWidget({Key? key}) : super(key: key);

  @override
  State<CircularLoadingWidget> createState() => _CircularLoadingWidgetState();
}

class _CircularLoadingWidgetState extends State<CircularLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            const SizedBox(height: 10,),
            Text("Please wait...", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
