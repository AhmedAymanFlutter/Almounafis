import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/onboarding/data/models/onboarding_model.dart';
import 'package:almonafs_flutter/features/onboarding/data/onboarding_strings.dart';
import 'package:almonafs_flutter/features/onboarding/presentation/widgets/onboarding_page_widget.dart';
import 'package:almonafs_flutter/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_currentPage < OnboardingData.pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHome();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        final isArabic = langState == AppLanguage.arabic;

        return Scaffold(
          body: Stack(
            children: [
              // PageView with full-screen images
              PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: OnboardingData.pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    content: OnboardingData.pages[index],
                    isArabic: isArabic,
                  );
                },
              ),

              // App name at top with gradient background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 40.h, bottom: 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isArabic
                          ? OnboardingStrings.appNameAr
                          : OnboardingStrings.appNameEn,
                      style: AppTextStyle.setPoppinsWhite(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ).copyWith(letterSpacing: 1.5),
                    ),
                  ),
                ),
              ),

              // Skip button
              Positioned(
                top: 50.h,
                right: isArabic ? null : 20.w,
                left: isArabic ? 20.w : null,
                child: TextButton(
                  onPressed: _navigateToHome,
                  style: TextButton.styleFrom(
                    backgroundColor: AppColor.mainWhite.withOpacity(0.2),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    isArabic
                        ? OnboardingStrings.skipAr
                        : OnboardingStrings.skipEn,
                    style: AppTextStyle.setPoppinsWhite(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Bottom navigation section
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    bottom: 40.h,
                    top: 20.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous button
                      if (_currentPage > 0)
                        TextButton.icon(
                          onPressed: _previousPage,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                          ),
                          icon: Icon(
                            isArabic ? Icons.arrow_forward : Icons.arrow_back,
                            color: AppColor.mainWhite,
                            size: 20.sp,
                          ),
                          label: Text(
                            isArabic
                                ? OnboardingStrings.previousAr
                                : OnboardingStrings.previousEn,
                            style: AppTextStyle.setPoppinsWhite(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        SizedBox(width: 100.w),

                      // Page indicators
                      Row(
                        children: List.generate(
                          OnboardingData.pages.length,
                          (index) =>
                              PageIndicator(isActive: index == _currentPage),
                        ),
                      ),

                      // Next/Get Started button
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.mainColor,
                          foregroundColor: AppColor.mainWhite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 28.w,
                            vertical: 12.h,
                          ),
                          elevation: 4,
                          shadowColor: AppColor.mainColor.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          _currentPage == OnboardingData.pages.length - 1
                              ? (isArabic
                                    ? OnboardingStrings.getStartedAr
                                    : OnboardingStrings.getStartedEn)
                              : (isArabic
                                    ? OnboardingStrings.nextAr
                                    : OnboardingStrings.nextEn),
                          style: AppTextStyle.setPoppinsWhite(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
