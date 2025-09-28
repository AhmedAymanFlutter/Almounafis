import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/helper/app_images.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to Home after 3 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.onBoarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xff0e2e4f), 
      body: Center(
        child: Image(
          image: AssetImage(AppImages.logo), 
        ),
      ),
    );
  }
}
