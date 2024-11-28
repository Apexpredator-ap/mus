import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/player_controller.dart';
import '../controllers/settings_controller.dart';
import '../main_layout.dart';
import '../utils/exit_dialogue.dart';
import '../widgets/mini_player.dart';
import '../widgets/widg.dart';

class ProfilePage extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  void _showImageSelectionDialog() {
    Get.dialog(
      AlertDialog(
        title: Text("Select Profile Image"),
        content: SizedBox(
          height: 200,
          width: 300,
          child: GridView.builder(
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              String imagePath = 'assets/images/avt${index + 1}.png';
              return GestureDetector(
                onTap: () {
                  controller.updateAvatar(imagePath);
                  Get.back(); // Close the dialog
                },
                child: Obx(() => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        imagePath,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                    ),
                    if (controller.selectedAvatar.value == imagePath)
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Icon(Icons.check_circle, color: Colors.blue),
                      ),
                  ],
                )),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Get.back(), child: Text("Cancel"))],
      ),
    );
  }

  void _showChangeUsernameDialog() {
    TextEditingController usernameController = TextEditingController(text: controller.username.value);
    Get.dialog(
      AlertDialog(
        title: Text("Change Username"),
        content: TextField(
          controller: usernameController,
          decoration: InputDecoration(hintText: "Enter new username"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
          TextButton(
            onPressed: () {
              controller.updateUsername(usernameController.text);
              Get.back();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  // Show Privacy Policy
  void showPrivacyPolicy(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Text(
            'This is the privacy policy text. Make sure to update this with your actual privacy policy content.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show About Dialog and Get In Touch Sheet
  void _showAboutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        titlePadding: const EdgeInsets.all(12),
        title: Column(
          children: [
            Image.asset(
              'assets/images/applogo.png', // Ensure this path is correct
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              'MusiQ ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        content: const Text(
          'It is an ad-free Music Player that plays all local storage music.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _showGetInTouchSheet(context); // Open bottom sheet
            },
            child: const Text('Get In Touch'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog using GetX
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Get In Touch Bottom Sheet
  void _showGetInTouchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext ctx) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // User Icon and Name
              ListTile(
                leading: Icon(Icons.person, color: Colors.blue, size: 40),
                title: Text(
                  'ABHIRAM M', // Replace with your name
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle:
                Text('Jr Flutter Developer'), // Replace with your job role
              ),
              Divider(),

              // Email with clickable link
              ListTile(
                leading: Icon(Icons.email, color: Colors.red, size: 30),
                title: GestureDetector(
                  onTap: () {
                    _launchEmail(
                        'abhiramm95@gmail.com'); // Replace with your email
                  },
                  child: Text(
                    'abhiramm95@gmail.com', // Replace with your email
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // OK Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to launch the email app
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello there!', // Optional subject line
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Show error message using GetX snackbar
      Get.snackbar(
        "Could not open email client",
        "",
        icon: const Icon(Icons.error),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(context),
      child: MainLayout(
        bodyContent: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Settings",
                style: GoogleFonts.jost(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() => CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: controller.selectedAvatar.value.isNotEmpty
                            ? AssetImage(controller.selectedAvatar.value)
                            : null,
                        child: controller.selectedAvatar.value.isEmpty
                            ? Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSelectionDialog,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              controller.selectedAvatar.value.isEmpty ? Icons.add : Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Obx(() => Text(
                    'Welcome, ${controller.username.value}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showChangeUsernameDialog,
                    child: Text('Change Username'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showPrivacyPolicy(context);
                    },
                    child: Text('Privacy Policy'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showAboutDialog(context);
                    },
                    child: Text('About'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Show confirmation dialog before exiting
                      Get.dialog(
                        AlertDialog(
                          title: Text('Confirm Exit'),
                          content: Text('Are you sure you want to exit the app?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Get.back();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Exit the app
                                SystemNavigator.pop();
                              },
                              child: Text('Exit'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Exit'),
                  ),
                  Text("Version :1.0.0"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
