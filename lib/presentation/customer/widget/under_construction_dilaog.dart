import 'package:flutter/material.dart';

void underConstruction(BuildContext context) async {
  // show the loading dialog
  showDialog(
    // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // Some text
                Center(child: Text('Still Under Construction'))
              ],
            ),
          ),
        );
      });
}