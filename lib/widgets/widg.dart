// privacy_policy_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showPrivacyPolicy(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Allow closing by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'This Offline Music Player app respects your privacy. We collect minimal device information like your device model and operating system version to ensure compatibility and troubleshoot issues. Your music files remain private on your device. We do not access or share your personal information with any third-party services.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              IconButton(
                icon: Icon(Icons.close, size: 30),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

