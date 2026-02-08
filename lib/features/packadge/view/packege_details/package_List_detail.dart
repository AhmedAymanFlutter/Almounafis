import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/helper/html_helper.dart'; // Import HtmlHelper
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../localization/manager/localization_cubit.dart';
import '../../data/repo/package_repo.dart';
import '../../manager/package_cubit.dart';
import '../../manager/package_state.dart';
import 'widget/build_book_btn.dart';
import 'widget/itinerary_widget.dart';
import 'widget/inclusions_widget.dart';

class PackageDetailsView extends StatelessWidget {
  final String slug;
  final String packageTitle;

  const PackageDetailsView({
    super.key,
    required this.slug,
    required this.packageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PackageCubit(PackageTypeRepo())..getPackageDetails(slug),
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
                    // Access PackageDetailsData directly
                    final details = state.packageDetails;

                    // Determine fields based on language
                    final title = isArabic
                        ? (details.titleAr ?? details.title)
                        : (details.title ?? packageTitle);
                    final descriptionHtml = isArabic
                        ? (details.descriptionAr ?? details.description)
                        : details.description;
                    final description = HtmlHelper.stripHtml(
                      descriptionHtml ?? '',
                    );

                    final price = details.pricing?.price ?? 'N/A';
                    final currency = details.pricing?.currency ?? '';
                    final imageUrl = details.images?.coverImage?.url ?? '';

                    return Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 56,
                        ),
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
                                          borderRadius: BorderRadius.circular(
                                            30.r,
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            height: 650.h,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      height: 650.h,
                                                      color: Colors.grey[300],
                                                      child: const Icon(
                                                        Icons.broken_image,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      ),
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
                                              bottomRight: Radius.circular(
                                                30.r,
                                              ),
                                            ),
                                            child: Container(
                                              height: 650.h,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black.withOpacity(
                                                      0.6,
                                                    ),
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
                                                color: Colors.white.withOpacity(
                                                  0.9,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(
                                                  isArabic ? 3.14159 : 0,
                                                ),
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
                                                title ?? '',
                                                style:
                                                    AppTextStyle.setPoppinsTextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                textAlign: isArabic
                                                    ? TextAlign.right
                                                    : TextAlign.left,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ⏱️ المدة / السعر
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: 8.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  isArabic ? ' السعر' : 'Price',
                                                  style:
                                                      AppTextStyle.setPoppinsTextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.lightGrey,
                                                      ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '$price $currency',
                                                  style:
                                                      AppTextStyle.setPoppinsTextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            AppColor.mainBlack,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 24.h),
                                          // 📖 الوصف
                                          Text(
                                            isArabic ? 'الوصف' : 'Description',
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.mainBlack,
                                                ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Text(
                                            description.isNotEmpty
                                                ? description
                                                : (isArabic
                                                      ? 'لا يوجد وصف متاح'
                                                      : 'No description available'),
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColor.lightGrey,
                                                ),
                                            textAlign: isArabic
                                                ? TextAlign.right
                                                : TextAlign.left,
                                          ),

                                          if (details.itinerary != null &&
                                              details
                                                  .itinerary!
                                                  .isNotEmpty) ...[
                                            SizedBox(height: 24.h),
                                            ItineraryWidget(
                                              itinerary: details.itinerary!,
                                              isArabic: isArabic,
                                            ),
                                          ],

                                          if ((details.includes != null &&
                                                  details
                                                      .includes!
                                                      .isNotEmpty) ||
                                              (details.excludes != null &&
                                                  details
                                                      .excludes!
                                                      .isNotEmpty)) ...[
                                            SizedBox(height: 24.h),
                                            InclusionsWidget(
                                              includes: details.includes,
                                              excludes: details.excludes,
                                              isArabic: isArabic,
                                            ),
                                          ],

                                          SizedBox(
                                            height: 100.h,
                                          ), // Bottom padding for button
                                        ],
                                      ),
                                    ),
                                  ],
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
