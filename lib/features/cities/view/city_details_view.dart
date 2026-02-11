import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_details_header.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_info_section.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_tours_section.dart';
// Gallery section import removed as it is now in the header
import 'package:almonafs_flutter/features/cities/view/widgets/related_cities_section.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_restaurants_section.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_places_to_visit_section.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_things_to_do_section.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/cities/resources/city_strings.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';

class CityDetailsView extends StatelessWidget {
  final String idOrSlug;
  final String cityName;

  const CityDetailsView({
    super.key,
    required this.idOrSlug,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, languageState) {
        final isArabic = languageState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: const Color(0xFFF5F7FA), // Light grey background
              body: BlocBuilder<CityCubit, CityState>(
                builder: (context, state) {
                  if (state is CityDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CityDetailsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CityDetailsLoaded) {
                    final city = state.cityDetailsResponse.data;
                    if (city == null) {
                      return const Center(child: Text("No Data Available"));
                    }

                    return NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              // 1. Header with Gallery Carousel
                              CityDetailsHeader(city: city, isArabic: isArabic),

                              // 2. Pinned TabBar
                              SliverPersistentHeader(
                                delegate: _SliverAppBarDelegate(
                                  TabBar(
                                    labelColor: AppColor.mainColor,
                                    unselectedLabelColor:
                                        AppColor.secondaryGrey,
                                    indicatorColor: AppColor.mainColor,
                                    labelStyle: AppTextStyle.setPoppinsBlack(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    unselectedLabelStyle:
                                        AppTextStyle.setPoppinsBlack(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    tabs: [
                                      Tab(
                                        text: isArabic
                                            ? CityStringsAr.overview
                                            : CityStringsEn.overview,
                                      ),
                                      Tab(
                                        text: isArabic
                                            ? CityStringsAr.tours
                                            : CityStringsEn.tours,
                                      ),
                                      Tab(
                                        text: isArabic
                                            ? CityStringsAr.guide
                                            : CityStringsEn.guide,
                                      ),
                                    ],
                                  ),
                                ),
                                pinned: true,
                              ),
                            ];
                          },
                      body: TabBarView(
                        children: [
                          _buildOverviewTab(city, isArabic),
                          _buildToursTab(city),
                          _buildGuideTab(state, isArabic),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverviewTab(CityDetails city, bool isArabic) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description Section
          CityInfoSection(city: city, isArabic: isArabic),

          SizedBox(height: 24.h),

          // Related Cities Section
          if (city.relatedCities?.isNotEmpty == true) ...[
            RelatedCitiesSection(
              relatedCities: city.relatedCities!,
              isArabic: isArabic,
            ),
            SizedBox(height: 24.h),
          ],

          // Add extra padding at bottom to ensure content isn't hidden
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildToursTab(CityDetails city) {
    if (city.cityTours == null || city.cityTours!.isEmpty) {
      return Center(
        child: Text(
          "No tours available",
          style: AppTextStyle.setPoppinssecondaryGery(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: CityToursSection(tours: city.cityTours!),
    );
  }

  Widget _buildGuideTab(CityDetailsLoaded state, bool isArabic) {
    final guideData = state.cityGuideResponse?.data;
    if (guideData == null ||
        (guideData.restaurants?.isEmpty == true &&
            guideData.placesToVisit?.isEmpty == true &&
            guideData.thingsToDo?.isEmpty == true)) {
      return Center(
        child: Text(
          "Guide info not available",
          style: AppTextStyle.setPoppinssecondaryGery(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (guideData.placesToVisit?.isNotEmpty == true) ...[
            Text(
              isArabic
                  ? CityStringsAr.placesToVisit
                  : CityStringsEn.placesToVisit,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            CityPlacesToVisitSection(placesToVisit: guideData.placesToVisit!),
            SizedBox(height: 24.h),
          ],

          if (guideData.thingsToDo?.isNotEmpty == true) ...[
            Text(
              isArabic ? CityStringsAr.thingsToDo : CityStringsEn.thingsToDo,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            CityThingsToDoSection(thingsToDo: guideData.thingsToDo!),
            SizedBox(height: 24.h),
          ],

          if (guideData.restaurants?.isNotEmpty == true) ...[
            Text(
              isArabic ? CityStringsAr.restaurants : CityStringsEn.restaurants,
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            CityRestaurantsSection(restaurants: guideData.restaurants!),
            SizedBox(height: 24.h),
          ],
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: const Color(
        0xFFF5F7FA,
      ), // Match background color for sticky effect
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
