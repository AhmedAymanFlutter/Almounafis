import 'package:almonafs_flutter/core/helper/Fun_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBookButton(BuildContext context) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: () {         
  final globalSettingsState = context.read<GlobalSettingsCubit>().state;

if (globalSettingsState is GlobalSettingsLoaded) {
  WhatsAppService.launchWhatsApp(
    context,
    isArabic: isArabic,
    settings: globalSettingsState.globalSettings,
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isArabic 
          ? "جاري تحميل الإعدادات..." 
          : "Loading settings..."
      ),
    ),
  );
}
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.mainBlack,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        isArabic ? 'احجز الآن' : 'Book Now',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}