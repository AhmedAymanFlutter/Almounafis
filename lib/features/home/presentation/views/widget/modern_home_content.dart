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
import 'modern_country_card.dart';
import 'modern_home_app_bar.dart';

import '../../../../hotels/manager/hotel_cubit.dart';
import '../../../../hotels/manager/hotel_state.dart';
import '../../../../hotels/data/repo/Hotel_repo_tour.dart';
import 'modern_hotel_card.dart';
import 'reviews_section.dart';
import 'package:almonafs_flutter/features/viator/data/repo/viator_repo.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_cubit.dart';
import 'package:almonafs_flutter/features/viator/view/widget/viator_tour_list.dart';

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
          create: (_) => HotelCubit(HotelRepository())..getAllHotels(),
        ),
        BlocProvider(
          create: (_) => ViatorCubit(ViatorRepository())..fetchTours(),
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
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ModernHomeAppBar(
                  isArabic: isArabic,
                  onMenuTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              // Reviews Section
              SliverToBoxAdapter(child: ReviewsSection(isArabic: isArabic)),
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
                        isArabic ? "الجولات المميزة" : "Featured Tours",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.viatorAllToursPage,
                          );
                        },
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

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // Tour List
              SliverToBoxAdapter(
                child: ViatorTourListWidget(isArabic: isArabic),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 32.h)),

              // Hotels Section
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isArabic ? "الفنادق" : "Hotels",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.allHotelsPage),
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
                  child: BlocBuilder<HotelCubit, HotelState>(
                    builder: (context, state) {
                      if (state is HotelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final hotels = state is HotelFiltered
                          ? state.filteredHotels
                          : (state is HotelLoaded
                                ? state.hotels.data ?? []
                                : []);

                      if (hotels.isEmpty) {
                        return Center(
                          child: Text(
                            isArabic ? "لا توجد فنادق" : "No hotels found",
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: hotels.length,
                        itemBuilder: (context, index) {
                          final hotel = hotels[index];
                          return GestureDetector(
                            onTap: () {
                              final hotelIdentifier =
                                  hotel.id ?? hotel.sId ?? '';
                              if (hotelIdentifier.isNotEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.hotelDetails,
                                  arguments: {'hotelId': hotelIdentifier},
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isArabic
                                          ? 'معرف الفندق غير متاح'
                                          : 'Hotel ID not available',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: ModernHotelCard(
                              hotel: hotel,
                              name: isArabic
                                  ? hotel.nameAr ?? hotel.name ?? "فندق"
                                  : hotel.name ?? "Hotel",
                              location: isArabic
                                  ? hotel.addressAr ??
                                        hotel.address ??
                                        hotel.city ??
                                        "الموقع غير متاح"
                                  : hotel.address ??
                                        hotel.city ??
                                        "Location not available",
                              imageUrl:
                                  hotel.imageCover ??
                                  (hotel.images?.isNotEmpty == true
                                      ? hotel.images!.first
                                      : 'https://via.placeholder.com/200x140'),
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
