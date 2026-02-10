import 'package:almonafs_flutter/config/cache/cache_helper.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/helper/app_images.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo Animation: Scale and Fade In
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Text Animation: Slide Up and Fade In (Delayed)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    // Start Animations and logic
    _startSplash();
  }

  void _startSplash() async {
    // Start animations
    _logoController.forward();

    // Wait for logo animation partially then start text
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    // Ensure minimum splash duration
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      _checkAuthAndNavigate();
    }
  }

  void _checkAuthAndNavigate() {
    final String? token = CacheHelper.getData(key: 'token');
    final bool? isFirstTime = CacheHelper.getData(key: 'isFirstTime');

    if (isFirstTime == null || isFirstTime == true) {
      Navigator.pushReplacementNamed(context, Routes.onBoarding);
    } else if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onBoarding);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e2e4f),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0e2e4f), Color(0xff1a4b7c)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            FadeTransition(
              opacity: _logoFadeAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Image.asset(AppImages.logo, width: 150.w, height: 150.w),
              ),
            ),
            SizedBox(height: 30.h),
            // Animated Text
            FadeTransition(
              opacity: _textFadeAnimation,
              child: SlideTransition(
                position: _textSlideAnimation,
                child: Column(
                  children: [
                    Text(
                      "Almounafis",
                      style: AppTextStyle.setPoppinsWhite(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "The best travel guide",
                      style: AppTextStyle.setPoppinsWhite(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
