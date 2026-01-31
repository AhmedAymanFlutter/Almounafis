import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/router/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../localization/manager/localization_cubit.dart';
import '../../../data/repo/country_repo.dart';
import '../../../manager/country_cubit.dart';
import '../../../manager/country_state.dart';
import '../widget/utils/get_image.dart';
import 'category_filter_list.dart';
import 'modern_country_card.dart';
import 'modern_home_app_bar.dart';
import 'modern_promo_slider.dart';
import 'modern_search_bar.dart';
import 'modern_tour_card.dart';

import '../../../../upcomming_Tour/manager/tour_cubit.dart';
import '../../../../upcomming_Tour/manager/tour_state.dart';
import '../../../../upcomming_Tour/data/repo/city_repo_tour.dart';

class ModernHomeContent extends StatelessWidget {
  const ModernHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CountryCubit(CountryRepository())..fetchAllCountries(),
        ),
        BlocProvider(
          create: (_) =>
              CityTourCubit(repository: CityTourRepository())..getAllCities(),
        ),
      ],
      child: const _ModernHomeBody(),
    );
  }
}

class _ModernHomeBody extends StatelessWidget {
  const _ModernHomeBody();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Slight off-white background
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ModernHomeAppBar(
                  isArabic: isArabic,
                  onMenuTap: () => Scaffold.of(context).openDrawer(),
                  onNotificationTap: () {},
                ),
              ),
              SliverToBoxAdapter(child: ModernSearchBar(isArabic: isArabic)),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              SliverToBoxAdapter(child: ModernPromoSlider(isArabic: isArabic)),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: CategoryFilterList(isArabic: isArabic)),
              SliverToBoxAdapter(child: SizedBox(height: 32.h)),

              // Countries Section
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? "وجهات شائعة" : "Popular Destinations",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.allCountriesPage,
                        ),
                        child: Text(
                          isArabic ? "عرض الكل" : "See All",
                          style: TextStyle(
                            color: AppColor.secondaryblue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 250.h,
                  child: BlocBuilder<CountryCubit, CountryState>(
                    builder: (context, state) {
                      if (state is CountryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CountryLoaded) {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.countries.length,
                          itemBuilder: (context, index) {
                            final country = state.countries[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes
                                      .countryDetails, // Ensure Routes is imported
                                  arguments: {
                                    'countryIdOrSlug': country.id,
                                    'countryName': isArabic
                                        ? (country.nameAr ?? "بدون موقع")
                                        : (country.name ?? "Unknown"),
                                  },
                                );
                              },
                              child: ModernCountryCard(
                                name: isArabic
                                    ? (country.nameAr ?? "")
                                    : (country.name ?? ""),
                                imageUrl: getCountryImageUrl(country),
                                description: isArabic
                                    ? (country.descriptionArFlutter ?? "")
                                    : (country.descriptionFlutter ?? ""),
                                currency: country.currency ?? "",
                                location: isArabic
                                    ? (country.nameAr ?? "")
                                    : (country.name ?? ""),
                                countryId: country.id ?? "",
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(isArabic ? "لا توجد بيانات" : "No Data"),
                        );
                      }
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 32.h)),

              // Tours Section
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? "الجولات القادمة" : "Upcoming Tours",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.allToursPage),
                        child: Text(
                          isArabic ? "عرض الكل" : "See All",
                          style: TextStyle(
                            color: AppColor.secondaryblue,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 280.h,
                  child: BlocBuilder<CityTourCubit, CityTourState>(
                    builder: (context, state) {
                      if (state is CityTourLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final tours = state is CityTourFiltered
                          ? state.filteredTours
                          : (state is CityTourLoaded
                                ? state.allCityTour.data ?? []
                                : []);

                      if (tours.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic ? "لا توجد جولات" : "No tours found",
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: tours.length,
                        itemBuilder: (context, index) {
                          final tour = tours[index];
                          return GestureDetector(
                            onTap: () {
                              final tourIdentifier = tour.id ?? tour.sId ?? '';
                              if (tourIdentifier.isNotEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.cityTourDetails,
                                  arguments: {
                                    'tourIdOrSlug': tourIdentifier,
                                    'tourTitle': tour.title,
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isArabic
                                          ? 'معرف الجولة غير متاح'
                                          : 'Tour ID not available',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: ModernTourCard(
                              tour: tour,
                              title: isArabic
                                  ? tour.titleAr ?? "لا يوجد عنوان"
                                  : tour.title ?? "No title",
                              // Passing description as subtitle, but card uses city/location internally if available
                              subtitle: isArabic
                                  ? tour.descriptionArFlutter ?? "لا يوجد وصف"
                                  : tour.descriptionFlutter ?? "No description",
                              imageUrl: tour.coverImage.toString(),
                              tag:
                                  tour.tags?.join(", ") ??
                                  (isArabic ? "غير متوفر" : "N/A"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
