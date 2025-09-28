import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/helper/app_images.dart';
import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e2e4f),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 130.h),
          Center(child: SvgPicture.asset(AppImages.onBoarding)),
          SizedBox(height: 50.h),
          Text(
            TextHelper.welcome,
            style: AppTextStyle.setPoppinsWhite(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 50.h),
          Text(
            TextHelper.aboutApp,
            style: AppTextStyle.setPoppinsWhite(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 70.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.signUp);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.mainWhite,
              padding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Text(
              TextHelper.next,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
