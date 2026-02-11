import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/singel_country/data/model/country_details_model.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/home/manager/country_state.dart';
import 'package:almonafs_flutter/features/singel_country/resources/country_strings.dart';
import 'package:almonafs_flutter/features/singel_country/view/widget/country_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/manager/country_cubit.dart';
import '../../localization/manager/localization_cubit.dart';
import 'widget/build_Booking_Button.dart';
import 'widget/build_Info_Card.dart';
import 'widget/country_cities_widget.dart';
import 'widget/country_restaurants_section.dart';
import 'widget/country_places_to_visit_section.dart';
import 'widget/country_things_to_do_section.dart';
import 'widget/related_countries_widget.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/features/packadge/data/model/package_model.dart';
import 'package:almonafs_flutter/features/packadge/view/widget/Package_widget.dart';

class CountryDetailsPage extends StatefulWidget {
  final String countryIdOrSlug;
  final String? countryName;

  const CountryDetailsPage({
    super.key,
    required this.countryIdOrSlug,
    this.countryName,
  });

  @override
  State<CountryDetailsPage> createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CountryCubit>().fetchCountryDetails(widget.countryIdOrSlug);
  }

  @override
  Widget build(BuildContext context) {
    // Get current language
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: buildBookButton(context),
        backgroundColor: const Color(0xFFF5F7FA),
        body: BlocBuilder<CountryCubit, CountryState>(
          builder: (context, state) {
            if (state is SingleCountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SingleCountryLoaded) {
              final country = state.country;

              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        // 1. Header with Gallery Carousel
                        CountryDetailsHeader(
                          country: country,
                          isArabic: isArabic,
                        ),

                        // 2. Pinned TabBar
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              labelColor: AppColor.mainColor,
                              unselectedLabelColor: AppColor.secondaryGrey,
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
                                      ? CountryStringsAr.overview
                                      : CountryStringsEn.overview,
                                ),
                                Tab(
                                  text: isArabic
                                      ? CountryStringsAr.packages
                                      : CountryStringsEn.packages,
                                ),
                                Tab(
                                  text: isArabic
                                      ? CountryStringsAr.guide
                                      : CountryStringsEn.guide,
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
                    _buildOverviewTab(country, isArabic),
                    _buildToursTab(state.packages, isArabic),
                    _buildGuideTab(state, isArabic),
                  ],
                ),
              );
            } else if (state is CountryError || state is SingleCountryError) {
              final errorMessage = state is CountryError
                  ? state.message
                  : (state as SingleCountryError).message;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      errorMessage,
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CountryCubit>().fetchCountryDetails(
                          widget.countryIdOrSlug,
                        );
                      },
                      child: Text(isArabic ? 'أعد المحاولة' : 'Try Again'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildOverviewTab(CountryDetailsData country, bool isArabic) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info Cards
          Row(
            children: [
              Expanded(
                child: buildInfoCard(
                  icon: Icons.flag,
                  label: isArabic
                      ? CountryStringsAr.code
                      : CountryStringsEn.code,
                  value: country.code ?? 'N/A',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: buildInfoCard(
                  icon: Icons.public,
                  label: isArabic
                      ? CountryStringsAr.continent
                      : CountryStringsEn.continent,
                  value: country.continent ?? 'N/A',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: buildInfoCard(
                  icon: Icons.attach_money,
                  label: isArabic
                      ? CountryStringsAr.currency
                      : CountryStringsEn.currency,
                  value: country.currency ?? 'N/A',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: buildInfoCard(
                  icon: Icons.language,
                  label: isArabic
                      ? CountryStringsAr.language
                      : CountryStringsEn.language,
                  value: country.language ?? 'N/A',
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // About Section
          Text(
            isArabic ? CountryStringsAr.about : CountryStringsEn.about,
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.mainBlack,
            ),
          ),
          SizedBox(height: 8.h),
          HtmlContentWidget(
            htmlContent: isArabic
                ? (country.descriptionAr ??
                      country.description ??
                      '<p>${CountryStringsAr.noDescription}</p>')
                : (country.description ??
                      country.descriptionAr ??
                      '<p>${CountryStringsEn.noDescription}</p>'),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            textColor: AppColor.secondaryBlack,
          ),

          // Cities in this country
          SizedBox(height: 24.h),
          CountryCitiesWidget(
            countryId: country.sId ?? '',
            countryName: isArabic
                ? (country.nameAr ?? country.name ?? '')
                : (country.name ?? ''),
          ),

          // Related Countries Section
          SizedBox(height: 32.h),
          if (country.relatedCountries != null &&
              country.relatedCountries!.isNotEmpty)
            RelatedCountriesWidget(
              relatedCountries: country.relatedCountries,
              isArabic: isArabic,
            ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildToursTab(List<dynamic>? packages, bool isArabic) {
    if (packages == null || packages.isEmpty) {
      return Center(
        child: Text(
          isArabic ? CountryStringsAr.noPackages : CountryStringsEn.noPackages,
          style: AppTextStyle.setPoppinssecondaryGery(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final packageData = packages[index];
        final package = Data.fromJson(packageData as Map<String, dynamic>);

        return PackageCardView(
          package: package,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.packageDetailsView,
              arguments: {
                'slug': package.slug ?? package.sId ?? '',
                'packageTitle': isArabic
                    ? (package.nameAr ?? package.name ?? '')
                    : (package.name ?? ''),
              },
            );
          },
        );
      },
    );
  }

  Widget _buildGuideTab(SingleCountryLoaded state, bool isArabic) {
    final guideData = state.guideResponse?.data;
    if (guideData == null ||
        (guideData.restaurants?.isEmpty == true &&
            guideData.placesToVisit?.isEmpty == true &&
            guideData.thingsToDo?.isEmpty == true)) {
      return Center(
        child: Text(
          isArabic
              ? CountryStringsAr.guideNotAvailable
              : CountryStringsEn.guideNotAvailable,
          style: AppTextStyle.setPoppinssecondaryGery(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (guideData.restaurants?.isNotEmpty == true) ...[
            CountryRestaurantsSection(restaurants: guideData.restaurants!),
            SizedBox(height: 24.h),
          ],
          if (guideData.placesToVisit?.isNotEmpty == true) ...[
            CountryPlacesToVisitSection(
              placesToVisit: guideData.placesToVisit!,
            ),
            SizedBox(height: 24.h),
          ],
          if (guideData.thingsToDo?.isNotEmpty == true) ...[
            CountryThingsToDoSection(thingsToDo: guideData.thingsToDo!),
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
      color: const Color(0xFFF5F7FA), // Match background color
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
