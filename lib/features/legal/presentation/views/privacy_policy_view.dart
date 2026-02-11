import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/legal/resources/legal_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context, isArabic),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic
                          ? LegalStringsAr.privacyWelcome
                          : LegalStringsEn.privacyWelcome,
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                      ).copyWith(height: 1.6),
                    ),
                    SizedBox(height: 24.h),
                    _buildSection(
                      context,
                      "1",
                      isArabic
                          ? LegalStringsAr.privacySection1Title
                          : LegalStringsEn.privacySection1Title,
                      isArabic
                          ? LegalStringsAr.privacySection1Content
                          : LegalStringsEn.privacySection1Content,
                    ),
                    _buildSection(
                      context,
                      "2",
                      isArabic
                          ? LegalStringsAr.privacySection2Title
                          : LegalStringsEn.privacySection2Title,
                      isArabic
                          ? LegalStringsAr.privacySection2Content
                          : LegalStringsEn.privacySection2Content,
                    ),
                    _buildSection(
                      context,
                      "3",
                      isArabic
                          ? LegalStringsAr.privacySection3Title
                          : LegalStringsEn.privacySection3Title,
                      isArabic
                          ? LegalStringsAr.privacySection3Content
                          : LegalStringsEn.privacySection3Content,
                    ),
                    _buildSection(
                      context,
                      "4",
                      isArabic
                          ? LegalStringsAr.privacySection4Title
                          : LegalStringsEn.privacySection4Title,
                      isArabic
                          ? LegalStringsAr.privacySection4Content
                          : LegalStringsEn.privacySection4Content,
                    ),
                    _buildSection(
                      context,
                      "5",
                      isArabic
                          ? LegalStringsAr.privacySection5Title
                          : LegalStringsEn.privacySection5Title,
                      isArabic
                          ? LegalStringsAr.privacySection5Content
                          : LegalStringsEn.privacySection5Content,
                    ),
                    _buildSection(
                      context,
                      "6",
                      isArabic
                          ? LegalStringsAr.privacySection6Title
                          : LegalStringsEn.privacySection6Title,
                      isArabic
                          ? LegalStringsAr.privacySection6Content
                          : LegalStringsEn.privacySection6Content,
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isArabic) {
    return SliverAppBar(
      expandedHeight: 180.h,
      pinned: true,
      backgroundColor: AppColor.secondaryblue,
      iconTheme: const IconThemeData(color: AppColor.mainWhite),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          isArabic ? LegalStringsAr.privacyTitle : LegalStringsEn.privacyTitle,
          style: AppTextStyle.setPoppinsWhite(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/almonafis_combany.jpeg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String number,
    String title,
    String content,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: AppColor.secondaryblue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: AppTextStyle.setPoppinsBlack(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ).copyWith(color: AppColor.secondaryblue),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 44.w),
            child: Text(
              content,
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ).copyWith(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
