import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/setting/data/models/language_model.dart';
import 'package:almonafs_flutter/features/setting/presentation/widgets/language_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        final isArabic = langState == AppLanguage.arabic;
        final currentLanguageCode = isArabic ? 'ar' : 'en';

        return Scaffold(
          backgroundColor: AppColor.offWhite,
          appBar: AppBar(
            backgroundColor: AppColor.mainWhite,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                isArabic ? Icons.arrow_forward : Icons.arrow_back,
                color: AppColor.mainBlack,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              isArabic ? 'اختر اللغة' : 'Choose Language',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.mainBlack,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Header section with icon
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  decoration: BoxDecoration(
                    color: AppColor.mainWhite,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.r),
                      bottomRight: Radius.circular(32.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.language_rounded,
                          size: 40.sp,
                          color: AppColor.mainColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        isArabic
                            ? 'اختر لغتك المفضلة'
                            : 'Select Your Preferred Language',
                        style: AppTextStyle.setPoppinsTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Language options
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: LanguageData.supportedLanguages.length,
                      itemBuilder: (context, index) {
                        final language = LanguageData.supportedLanguages[index];
                        final isSelected = language.code == currentLanguageCode;

                        return LanguageOptionCard(
                          language: language,
                          isSelected: isSelected,
                          onTap: () {
                            if (!isSelected) {
                              final newLanguage = language.code == 'ar'
                                  ? AppLanguage.arabic
                                  : AppLanguage.english;
                              context.read<LanguageCubit>().setLanguage(
                                newLanguage,
                              );

                              // Show confirmation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    language.code == 'ar'
                                        ? 'تم تغيير اللغة إلى العربية'
                                        : 'Language changed to English',
                                    style: AppTextStyle.setPoppinsWhite(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  backgroundColor: AppColor.mainColor,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Footer info
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    isArabic
                        ? 'سيتم تطبيق اللغة على التطبيق بالكامل'
                        : 'Language will be applied throughout the app',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.setPoppinsTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.secondaryGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
