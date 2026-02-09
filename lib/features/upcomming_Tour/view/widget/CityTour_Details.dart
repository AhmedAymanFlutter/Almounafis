import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/view/widget/utils/Utils_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../manager/tour_cubit.dart';
import '../../manager/tour_state.dart';
import 'utils/Utils_image.dart';
import '../../../localization/manager/localization_cubit.dart';

class CityTourDetailsPage extends StatefulWidget {
  final String tourIdOrSlug;
  final String? tourTitle;

  const CityTourDetailsPage({
    super.key,
    required this.tourIdOrSlug,
    this.tourTitle,
  });

  @override
  State<CityTourDetailsPage> createState() => _CityTourDetailsPageState();
}

class _CityTourDetailsPageState extends State<CityTourDetailsPage> {
  @override
  void initState() {
    super.initState();
    // ✅ استدعاء الداتا مرة واحدة فقط عند الدخول للصفحة
    context.read<CityTourCubit>().getCityTourDetails(widget.tourIdOrSlug);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CityTourCubit, CityTourState>(
        builder: (context, state) {
          if (state is SingleCityTourLoading) {
            return _buildLoadingShimmer();
          } else if (state is SingleCityTourLoaded) {
            final tour = state.cityTour;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼 Cover Image
                  buildCoverImage(
                    (tour.coverImage?.isNotEmpty == true)
                        ? tour.coverImage!
                        : 'https://yourcdn.com/images/default_cover.jpg', // 🔁 fallback image
                    context,
                    countryName: isArabic
                        ? tour.titleAr ?? ''
                        : tour.title ?? '',
                    arabicName: tour.titleAr ?? '',
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📝 Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'الوصف' : 'Description',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            HtmlContentWidget(
                              htmlContent: isArabic
                                  ? (tour.descriptionArFlutter ??
                                        tour.descriptionAr ??
                                        '<p>لا يوجد وصف متاح</p>')
                                  : (tour.descriptionFlutter ??
                                        tour.description ??
                                        '<p>No description available</p>'),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              textColor: AppColor.secondaryBlack,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),

                        // ✅ Includes
                        if ((isArabic ? tour.includesAr : tour.includes) !=
                                null &&
                            (isArabic
                                ? tour.includesAr!.isNotEmpty
                                : tour.includes!.isNotEmpty))
                          buildListSection(
                            title: isArabic
                                ? 'ما هو المشمول'
                                : 'What\'s Included',
                            items: (isArabic ? tour.includesAr : tour.includes)!
                                .cast<String>(),
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                            context: context,
                          ),

                        // ❌ Excludes
                        if ((isArabic ? tour.excludesAr : tour.excludes) !=
                                null &&
                            (isArabic
                                ? tour.excludesAr!.isNotEmpty
                                : tour.excludes!.isNotEmpty))
                          buildListSection(
                            title: isArabic
                                ? 'ما هو غير المشمول'
                                : 'What\'s Excluded',
                            items: (isArabic ? tour.excludesAr : tour.excludes)!
                                .cast<String>(),
                            icon: Icons.cancel,
                            iconColor: Colors.red,
                            context: context,
                          ),

                        // 🏷 Tags
                        if ((isArabic ? tour.tagsAr : tour.tags) != null &&
                            (isArabic
                                ? tour.tagsAr!.isNotEmpty
                                : tour.tags!.isNotEmpty))
                          buildTagsSection(
                            (isArabic ? tour.tagsAr! : tour.tags!),
                            context,
                          ),

                        // 📸 Image Gallery
                        if (tour.images != null && tour.images!.isNotEmpty)
                          buildImageGallery(context, tour.images!),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CityTourError) {
            return _buildErrorState(context, state.message, isArabic);
          }

          return Center(
            child: Text(isArabic ? 'حالة غير معروفة' : 'Unknown state'),
          );
        },
      ),
      bottomNavigationBar: buildBookButton(context),
    );
  }

  /// ⚠️ Error State UI
  Widget _buildErrorState(BuildContext context, String message, bool isArabic) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<CityTourCubit>().getCityTourDetails(
                  widget.tourIdOrSlug,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.mainBlack,
              ),
              child: Text(isArabic ? 'إعادة المحاولة' : 'Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔄 Loading Shimmer
  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.grey.shade400,
            colorOpacity: 0.3,
            enabled: true,
            child: Container(height: 250.h, color: Colors.grey[300]),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    color: Colors.grey.shade400,
                    colorOpacity: 0.3,
                    enabled: true,
                    child: Container(
                      height: 20.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
