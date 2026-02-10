import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
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
              backgroundColor: AppColor.mainWhite, // Changed to match theme
              body: BlocBuilder<PackageCubit, PackageState>(
                builder: (context, state) {
                  if (state is PackageDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PackageDetailsLoaded) {
                    final details = state.packageDetails;

                    // Text Fields
                    final title = isArabic
                        ? (details.titleAr ?? details.title)
                        : (details.title ?? packageTitle);
                    final description = isArabic
                        ? (details.descriptionAr ?? details.description)
                        : details.description;

                    // Pricing & Duration
                    final price = details.pricing?.price ?? 'N/A';
                    final currency = details.pricing?.currency ?? '';
                    final durationDays = details.duration?.days;
                    final durationNights = details.duration?.nights;
                    final minGroup = details.availability?.minGroupSize;

                    // Images
                    final imageUrl = details.images?.coverImage?.url ?? '';
                    final gallery = details.images?.gallery ?? [];

                    return CustomScrollView(
                      slivers: [
                        // 1. Sliver App Bar with Image & Gallery Button
                        SliverAppBar(
                          expandedHeight: 300.h,
                          pinned: true,
                          leading: IconButton(
                            icon: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Container(color: Colors.grey[300]),
                                ),
                                // Gradient Overlay
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                ),
                                // Gallery Button (if gallery exists)
                                if (gallery.isNotEmpty)
                                  Positioned(
                                    bottom: 20.h,
                                    right: isArabic ? null : 20.w,
                                    left: isArabic ? 20.w : null,
                                    child: GestureDetector(
                                      onTap: () {
                                        // TODO: Open Gallery View
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            20.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.photo_library,
                                              color: Colors.white,
                                              size: 16.sp,
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              '${gallery.length} ${isArabic ? 'صور' : 'Photos'}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 2. Title & Rating (Future consideration)
                                Text(
                                  title ?? '',
                                  style: AppTextStyle.setPoppinsTextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.mainBlack,
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                // 3. Info Chips (Duration, Group, Location)
                                Row(
                                  children: [
                                    if (durationDays != null)
                                      _buildInfoChip(
                                        Icons.access_time,
                                        isArabic
                                            ? '$durationDays أيام / $durationNights ليالي'
                                            : '$durationDays Days / $durationNights Nights',
                                      ),
                                    if (minGroup != null) ...[
                                      SizedBox(width: 8.w),
                                      _buildInfoChip(
                                        Icons.group,
                                        isArabic
                                            ? 'مجموعة: $minGroup+'
                                            : 'Group: $minGroup+',
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 24.h),

                                // 4. Price Section
                                Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: AppColor.lightBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColor.lightBlue.withOpacity(
                                        0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isArabic
                                                ? 'يبدأ من'
                                                : 'Starts from',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColor.secondaryBlack,
                                            ),
                                          ),
                                          Text(
                                            '$price $currency',
                                            style:
                                                AppTextStyle.setPoppinsTextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColor.mainColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      // Discount Badge if exists
                                      if ((details
                                                  .pricing
                                                  ?.discountPercentage ??
                                              0) >
                                          0)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                          child: Text(
                                            '${details.pricing!.discountPercentage}% ${isArabic ? 'خصم' : 'OFF'}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h),

                                // 5. Description
                                Text(
                                  isArabic ? 'عن الرحلة' : 'About the trip',
                                  style: AppTextStyle.setPoppinsTextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.mainBlack,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                HtmlContentWidget(
                                  htmlContent:
                                      description ??
                                      (isArabic
                                          ? 'لا يوجد وصف متاح'
                                          : 'No description available'),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColor.secondaryBlack,
                                ),
                                SizedBox(height: 24.h),

                                // 6. Itinerary
                                if (details.itinerary != null &&
                                    details.itinerary!.isNotEmpty) ...[
                                  ItineraryWidget(
                                    itinerary: details.itinerary!,
                                    isArabic: isArabic,
                                  ),
                                  SizedBox(height: 24.h),
                                ],

                                // 7. Inclusions & Exclusions
                                if ((details.includes?.isNotEmpty ?? false) ||
                                    (details.excludes?.isNotEmpty ??
                                        false)) ...[
                                  InclusionsWidget(
                                    includes: details.includes,
                                    excludes: details.excludes,
                                    isArabic: isArabic,
                                  ),
                                  SizedBox(height: 24.h),
                                ],

                                // 8. Available Dates (Simple List for now)
                                if (details
                                        .availability
                                        ?.availableDates
                                        ?.isNotEmpty ??
                                    false) ...[
                                  Text(
                                    isArabic
                                        ? 'المواعيد المتاحة'
                                        : 'Available Dates',
                                    style: AppTextStyle.setPoppinsTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.mainBlack,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children: details
                                        .availability!
                                        .availableDates!
                                        .map((date) {
                                          return Chip(
                                            label: Text(date),
                                            backgroundColor: AppColor.offWhite,
                                            side: BorderSide(
                                              color: AppColor.lightGrey
                                                  .withOpacity(0.3),
                                            ),
                                          );
                                        })
                                        .toList(),
                                  ),
                                  SizedBox(height: 24.h),
                                ],

                                SizedBox(height: 80.h), // Bottom Padding
                              ],
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.offWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColor.secondaryBlack),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColor.secondaryBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
