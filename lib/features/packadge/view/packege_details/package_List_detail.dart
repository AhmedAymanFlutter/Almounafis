import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../data/repo/package_repo.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';
import 'widget/build_book_btn.dart';

class PackageDetailsView extends StatelessWidget {
  final String packageId;
  final String packageTitle;

  const PackageDetailsView({
    super.key,
    required this.packageId,
    required this.packageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())..getPackageDetails(packageId),
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, langState) {
          final isArabic = langState == AppLanguage.arabic;

          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              bottomNavigationBar: buildBookButton(context),
              backgroundColor: AppColor.mainWhite,
              body: BlocBuilder<PackageCubit, PackageState>(
                builder: (context, state) {
                  if (state is PackageDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PackageDetailsLoaded) {
                    final details = state.packageDetails.data?.first;

                    if (details == null) {
                      return Center(
                          child: Text(
                              isArabic ? 'لا توجد تفاصيل متاحة' : 'No details available'));
                    }

                    return Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 56),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 🖼️ الصورة الرئيسية
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(30.r),
                                          child: Image.network(
                                            details.imageCover ?? '',
                                            height: 650.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Container(
                                              height: 650.h,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.broken_image,
                                                  size: 50, color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        // تدرج لوني
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(30.r),
                                              bottomRight: Radius.circular(30.r),
                                            ),
                                            child: Container(
                                              height: 650.h,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black.withOpacity(0.6),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // زر الرجوع
                                        Positioned(
                                          top: 16.h,
                                          left: isArabic ? null : 16.w,
                                          right: isArabic ? 16.w : null,
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                              width: 40.w,
                                              height: 40.h,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(isArabic ? 3.14159 : 0),
                                                child: Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 18.sp,
                                                  color: AppColor.mainBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // العنوان
                                        Positioned(
                                          bottom: 16.h,
                                          left: 16.w,
                                          right: 16.w,
                                          child: Column(
                                            crossAxisAlignment: isArabic
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                details.name ?? packageTitle,
                                                style: AppTextStyle.setPoppinsTextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                                textAlign:
                                                    isArabic ? TextAlign.right : TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // 🧾 المحتوى
                                    Padding(
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // ⏱️ المدة
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w, vertical: 8.h),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  isArabic ? 'المدة التقديرية' : 'ESTIMATE',
                                                  style: AppTextStyle.setPoppinsTextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.lightGrey,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '3D 2N',
                                                  style: AppTextStyle.setPoppinsTextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.mainBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 24.h),
                                          // 📖 الوصف
                                          Text(
                                            isArabic ? 'الوصف' : 'Description',
                                            style: AppTextStyle.setPoppinsTextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.mainBlack,
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Text(
                                            details.description ?? (isArabic
                                                ? 'لا يوجد وصف متاح'
                                                : 'No description available'),
                                            style: AppTextStyle.setPoppinsTextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.lightGrey,
                                            ),
                                            textAlign:
                                                isArabic ? TextAlign.right : TextAlign.left,
                                          ),
                                          SizedBox(height: 24.h),
                                          // 📅 اختيار التاريخ
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                isArabic ? 'اختر التاريخ' : 'Choose date',
                                                style: AppTextStyle.setPoppinsTextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.mainBlack,
                                                ),
                                              ),
                                              Icon(
                                                Icons.info_outline,
                                                size: 18.sp,
                                                color: AppColor.lightGrey,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 14.w,
                                              vertical: 12.h,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey[300]!,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  isArabic
                                                      ? 'اختر التاريخ المناسب لك'
                                                      : 'Select your preferred dates',
                                                  style:
                                                      AppTextStyle.setPoppinsTextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.lightGrey,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 18.sp,
                                                  color: AppColor.lightGrey,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 80.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // 🔘 زر الحجز
                              Positioned(
                                bottom: 20.h,
                                left: 20.w,
                                right: 20.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(isArabic
                                                  ? 'جارٍ فتح واتساب...'
                                                  : 'Opening WhatsApp...'),
                                            ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF1D8DEF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24.r),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14.h),
                                          ),
                                          child: Text(
                                            isArabic
                                                ? 'احجز الآن عبر واتساب'
                                                : 'Book Now via WhatsApp',
                                            style: AppTextStyle
                                                .setPoppinsTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if (state is PackageError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
