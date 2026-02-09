import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/onboarding/data/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingContent content;
  final bool isArabic;

  const OnboardingPageWidget({
    super.key,
    required this.content,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          content.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColor.mainColor, AppColor.lightPurple],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.travel_explore,
                  size: 120.sp,
                  color: AppColor.mainWhite.withOpacity(0.3),
                ),
              ),
            );
          },
        ),

        // Gradient overlay for better text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Text content
        Positioned(
          bottom: 150.h,
          left: 24.w,
          right: 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with app text style
              Text(
                content.getTitle(isArabic),
                style: AppTextStyle.setPoppinsWhite(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16.h),

              // Description with app text style
              Text(
                content.getDescription(isArabic),
                style: AppTextStyle.setPoppinsWhite(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ).copyWith(color: AppColor.mainWhite.withOpacity(0.9)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
