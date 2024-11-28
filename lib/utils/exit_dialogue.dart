import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Exit App'),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Close dialog, do not exit
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop(); // Close the app
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  ) ??
      false; // Return false if dialog is dismissed
}
