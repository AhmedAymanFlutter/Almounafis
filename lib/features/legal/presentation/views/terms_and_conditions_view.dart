import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/legal/resources/legal_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

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
                          ? LegalStringsAr.termsWelcome
                          : LegalStringsEn.termsWelcome,
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
                          ? LegalStringsAr.termsSection1Title
                          : LegalStringsEn.termsSection1Title,
                      isArabic
                          ? LegalStringsAr.termsSection1Content
                          : LegalStringsEn.termsSection1Content,
                    ),
                    _buildSection(
                      context,
                      "2",
                      isArabic
                          ? LegalStringsAr.termsSection2Title
                          : LegalStringsEn.termsSection2Title,
                      isArabic
                          ? LegalStringsAr.termsSection2Content
                          : LegalStringsEn.termsSection2Content,
                    ),
                    _buildSection(
                      context,
                      "3",
                      isArabic
                          ? LegalStringsAr.termsSection3Title
                          : LegalStringsEn.termsSection3Title,
                      isArabic
                          ? LegalStringsAr.termsSection3Content
                          : LegalStringsEn.termsSection3Content,
                    ),
                    _buildSection(
                      context,
                      "4",
                      isArabic
                          ? LegalStringsAr.termsSection4Title
                          : LegalStringsEn.termsSection4Title,
                      isArabic
                          ? LegalStringsAr.termsSection4Content
                          : LegalStringsEn.termsSection4Content,
                    ),
                    _buildSection(
                      context,
                      "5",
                      isArabic
                          ? LegalStringsAr.termsSection5Title
                          : LegalStringsEn.termsSection5Title,
                      isArabic
                          ? LegalStringsAr.termsSection5Content
                          : LegalStringsEn.termsSection5Content,
                    ),
                    _buildSection(
                      context,
                      "6",
                      isArabic
                          ? LegalStringsAr.termsSection6Title
                          : LegalStringsEn.termsSection6Title,
                      isArabic
                          ? LegalStringsAr.termsSection6Content
                          : LegalStringsEn.termsSection6Content,
                    ),
                    _buildSection(
                      context,
                      "7",
                      isArabic
                          ? LegalStringsAr.termsSection7Title
                          : LegalStringsEn.termsSection7Title,
                      isArabic
                          ? LegalStringsAr.termsSection7Content
                          : LegalStringsEn.termsSection7Content,
                    ),
                    _buildSection(
                      context,
                      "8",
                      isArabic
                          ? LegalStringsAr.termsSection8Title
                          : LegalStringsEn.termsSection8Title,
                      isArabic
                          ? LegalStringsAr.termsSection8Content
                          : LegalStringsEn.termsSection8Content,
                    ),
                    _buildSection(
                      context,
                      "9",
                      isArabic
                          ? LegalStringsAr.termsSection9Title
                          : LegalStringsEn.termsSection9Title,
                      isArabic
                          ? LegalStringsAr.termsSection9Content
                          : LegalStringsEn.termsSection9Content,
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
          isArabic ? LegalStringsAr.termsTitle : LegalStringsEn.termsTitle,
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
