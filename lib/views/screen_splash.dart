import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/colors.dart';
import '../controllers/splash_controller.dart';
import '../widgets/custom_progress_bar.dart';
import 'login.dart';
import '../widgets/bottom_nav.dart'; // Import your home screen

class SplashPage extends StatefulWidget {
  final SplashController splashController = Get.put(SplashController());
   SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late double percentage = 0.0;
  AnimationController? _controller;
  double _animationValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _controller?.addListener(() {
      setState(() {
        _animationValue = _controller!.value;
      });
    });

    _controller?.forward().then((_) {
      _checkLoginStatus(); // Check login status after animation
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');

    // Navigate based on login status
    if (username != null && username.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Image.asset(
              "assets/images/applogo.png",
              height: 400,
              width: 400,
            ),
            Stack(
              children: [
                CustomPaint(
                  painter: LiquidPainter(_animationValue, 1.0),
                  size: Size(200.0, 200.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
