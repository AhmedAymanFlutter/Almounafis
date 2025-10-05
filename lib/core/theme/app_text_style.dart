import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle setPoppinsTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }){
    return GoogleFonts.poppins(
      
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle setPoppinsWhite({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainWhite,
    );
  }

  static TextStyle setPoppinsSecondaryBlack({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryBlack,
    );
  }

  static TextStyle setPoppinsSecondlightGrey({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondeLightGrey,
    );
  }

  static TextStyle setPoppinssecondaryGery({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.secondaryGrey,
    );
  }

  static TextStyle setPoppinsBlack({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.mainBlack,
    );
  }
   static TextStyle setPoppinsDeepPurple({
    required double fontSize,
    required FontWeight fontWeight,
  }){
    return GoogleFonts.poppins(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: AppColor.lightPurple,
    );
  }
}