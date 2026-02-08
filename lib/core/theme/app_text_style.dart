import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle setPoppinsTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle setPoppinsWhite({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainWhite,
      height: height,
    );
  }

  static TextStyle setPoppinsSecondaryBlack({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryBlack,
      height: height,
    );
  }

  static TextStyle setPoppinsSecondlightGrey({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondeLightGrey,
      height: height,
    );
  }

  static TextStyle setPoppinssecondaryGery({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryGrey,
      height: height,
    );
  }

  static TextStyle setPoppinsBlack({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainBlack,
      height: height,
    );
  }

  static TextStyle setPoppinsDeepPurple({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.lightPurple,
      height: height,
    );
  }
}
