import 'package:schedule_notification_app_demo/main.dart';
import 'package:schedule_notification_app_demo/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => LoginPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/splashscreen.jpg",
      fit: BoxFit.fitHeight,
    );
  }
}
