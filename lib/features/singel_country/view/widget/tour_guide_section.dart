import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/home/data/repo/country_repo.dart';
import 'package:almonafs_flutter/features/singel_country/view/manager/tour_guide_cubit.dart';
import 'package:almonafs_flutter/features/singel_country/view/manager/tour_guide_state.dart';
import 'package:almonafs_flutter/features/singel_country/view/widget/place_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TourGuideSection extends StatelessWidget {
  final String countrySlug;
  final bool isArabic;

  const TourGuideSection({
    super.key,
    required this.countrySlug,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourGuideCubit(
        // Assuming CountryRepository is available in the context via RepositoryProvider
        context.read<CountryRepository>(),
      )..fetchTourGuides(countrySlug),
      child: BlocBuilder<TourGuideCubit, TourGuideState>(
        builder: (context, state) {
          if (state is TourGuideLoading) {
            return _buildLoadingShimmer();
          } else if (state is TourGuideLoaded) {
            final data = state.tourGuideData;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Introduction
                if (data.introduction != null &&
                    data.introduction!.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'مقدمة' : 'Introduction',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColor.mainBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          data.introduction!,
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.secondaryBlack,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                // Restaurants
                if (data.restaurants != null &&
                    data.restaurants!.isNotEmpty) ...[
                  PlaceListWidget(
                    title: isArabic ? 'أفضل المطاعم' : 'Top Restaurants',
                    places: data.restaurants!,
                    isArabic: isArabic,
                  ),
                  SizedBox(height: 24.h),
                ],

                // Places to Visit
                if (data.placesToVisit != null &&
                    data.placesToVisit!.isNotEmpty) ...[
                  PlaceListWidget(
                    title: isArabic ? 'أماكن للزيارة' : 'Places to Visit',
                    places: data.placesToVisit!,
                    isArabic: isArabic,
                  ),
                  SizedBox(height: 24.h),
                ],

                // Things to Do
                if (data.thingsToDo != null && data.thingsToDo!.isNotEmpty) ...[
                  PlaceListWidget(
                    title: isArabic ? 'أنشطة مقترحة' : 'Things to Do',
                    places: data.thingsToDo!,
                    isArabic: isArabic,
                  ),
                  SizedBox(height: 24.h),
                ],
              ],
            );
          } else if (state is TourGuideError) {
            // Show error message or empty space
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Center(child: Text(state.message)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.grey.shade400,
            colorOpacity: 0.3,
            enabled: true,
            child: Container(
              height: 24.h,
              width: 150.w,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    color: Colors.grey.shade400,
                    colorOpacity: 0.3,
                    enabled: true,
                    child: Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
