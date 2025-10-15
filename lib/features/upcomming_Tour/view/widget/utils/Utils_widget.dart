import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/Fun_helper.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../features/localization/manager/localization_cubit.dart';
import '../../../../global_Settings/manager/global_cubit.dart';
import '../../../../global_Settings/manager/global_stete.dart';


Widget buildInfoChip({required IconData icon, required String label, required BuildContext context}) {
  final isArabic = context.watch<LanguageCubit>().isArabic;
  
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (!isArabic) Icon(icon, size: 16.sp, color: AppColor.mainBlack),
      if (!isArabic) SizedBox(width: 4.w),
      Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      if (isArabic) SizedBox(width: 4.w),
      if (isArabic) Icon(icon, size: 16.sp, color: AppColor.mainBlack),
    ],
  );
}

Widget buildSection({
  required String title,
  String? content,
  required BuildContext context,
}) {
  final isArabic = context.watch<LanguageCubit>().isArabic;
  
  if (content == null || content.isEmpty) return SizedBox.shrink();

  return Column(
    crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTextStyle.setPoppinsTextStyle(fontSize:16 , fontWeight: FontWeight.w500, color: AppColor.mainBlack),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      SizedBox(height: 8.h),
      Text(
        content,
        style: AppTextStyle.setPoppinsTextStyle(fontSize:10 , fontWeight: FontWeight.w300, color: AppColor.mainBlack),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      SizedBox(height: 24.h),
    ],
  );
}

Widget buildListSection({
  required String title,
  required List<String> items,
  required IconData icon,
  required Color iconColor,
  required BuildContext context,
}) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  return Column(
    crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTextStyle.setPoppinsTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.mainBlack),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      SizedBox(height: 12.h),
      ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isArabic) Icon(icon, size: 20.sp, color: iconColor),
                if (!isArabic) SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyle.setPoppinsTextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: AppColor.mainBlack),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                ),
                if (isArabic) SizedBox(width: 8.w),
                if (isArabic) Icon(icon, size: 20.sp, color: iconColor),
              ],
            ),
          )),
      SizedBox(height: 24.h),
    ],
  );
}

Widget buildTagsSection(List<String> tags, BuildContext context) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  return Column(
    crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        isArabic ? 'الوسوم' : 'Tags',
        style: AppTextStyle.setPoppinsTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.mainBlack),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      SizedBox(height: 12.h),
      Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        alignment: isArabic ? WrapAlignment.end : WrapAlignment.start,
        children: tags.map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColor.mainBlack,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: AppTextStyle.setPoppinsTextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: AppColor.mainWhite)
              ),
            )).toList(),
      ),
      SizedBox(height: 24.h),
    ],
  );
}

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