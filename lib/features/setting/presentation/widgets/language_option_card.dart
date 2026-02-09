import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/setting/data/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageOptionCard extends StatelessWidget {
  final LanguageOption language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Ink(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.mainColor.withOpacity(0.1)
                  : AppColor.mainWhite,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? AppColor.mainColor : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: Row(
                children: [
                  // Flag emoji
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.mainColor.withOpacity(0.1)
                          : AppColor.offWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        language.flagEmoji,
                        style: TextStyle(fontSize: 28.sp),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Language names
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          language.nameNative,
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColor.mainColor
                                : AppColor.mainBlack,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          language.description,
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColor.secondaryGrey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Selection indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.mainColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.mainColor
                            : AppColor.secondaryGrey,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 18.sp,
                            color: AppColor.mainWhite,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
