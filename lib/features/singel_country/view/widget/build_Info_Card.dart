import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_color.dart';
import '../../../localization/manager/localization_cubit.dart';

Widget buildInfoCard({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Builder(
    builder: (context) {
      final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColor.lightGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.lightGrey, width: 1),
          ),
          child: Column(
            children: [
              Icon(icon, size: 24.sp, color: AppColor.mainBlack),
              SizedBox(height: 4.h),
              Text(
                isArabic ? _translateLabel(label) : label, // ✅ ترجمة تلقائية
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColor.secondaryBlack,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// 🗣️ دالة بسيطة لترجمة بعض الكلمات المشهورة
String _translateLabel(String label) {
  switch (label.toLowerCase()) {
    case 'country':
      return 'الدولة';
    case 'currency':
      return 'العملة';
    case 'population':
      return 'عدد السكان';
    case 'capital':
      return 'العاصمة';
    case 'language':
      return 'اللغة';
    default:
      return label; // لو مش موجودة في القائمة تفضل زي ما هي
  }
}
