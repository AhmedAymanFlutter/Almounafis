import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class ModernSearchBar extends StatelessWidget {
  final bool isArabic;
  final VoidCallback? onTap;

  const ModernSearchBar({super.key, required this.isArabic, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: isArabic
                        ? 'ابحث عن وجهتك التالية...'
                        : 'Search your next destination...',
                    hintStyle: AppTextStyle.setPoppinsSecondlightGrey(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColor.secondaryblue,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.tune, color: Colors.white, size: 18.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
