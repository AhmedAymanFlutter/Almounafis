import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/home/manager/country_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../home/manager/country_cubit.dart';
import '../../localization/manager/localization_cubit.dart';
import 'widget/build_Booking_Button.dart';
import 'widget/build_Info_Card.dart';
import 'widget/build_Styled_Cover_Image.dart';
import 'widget/country_cities_widget.dart';
import 'widget/country_restaurants_section.dart';
import 'widget/country_places_to_visit_section.dart';
import 'widget/country_things_to_do_section.dart';
import 'widget/related_countries_widget.dart';
import 'widget/shimmer_widget.dart';
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
    // نجيب اللغة الحالية
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Scaffold(
      bottomNavigationBar: buildBookButton(context),
      body: BlocBuilder<CountryCubit, CountryState>(
        builder: (context, state) {
          if (state is SingleCountryLoading) {
            return buildLoadingShimmer();
          } else if (state is SingleCountryLoaded) {
            final country = state.country;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStyledCoverImage(context, country),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: buildInfoCard(
                                icon: Icons.flag,
                                label: isArabic ? 'الرمز' : 'Code',
                                value: country.code ?? 'N/A',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: buildInfoCard(
                                icon: Icons.public,
                                label: isArabic ? 'القارة' : 'Continent',
                                // نتأكد إنها موجودة، أو fallback
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
                                label: isArabic ? 'العملة' : 'Currency',
                                value: country.currency ?? 'N/A',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: buildInfoCard(
                                icon: Icons.language,
                                label: isArabic ? 'اللغة' : 'Language',
                                value: country.language ?? 'N/A',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        SizedBox(height: 24.h),
                        Text(
                          isArabic ? 'نبذة عن البلد' : 'About',
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
                                    '<p>لا توجد معلومات حالياً</p>')
                              : (country.description ??
                                    country.descriptionAr ??
                                    '<p>No description available</p>'),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textColor: AppColor.secondaryBlack,
                        ),

                        // جاليري الصور
                        if (country.images?.gallery != null &&
                            country.images!.gallery!.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Text(
                            isArabic ? 'المعرض' : 'Gallery',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 120.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: country.images!.gallery!.length,
                              itemBuilder: (context, index) {
                                final imageUrl =
                                    country.images!.gallery![index].url ?? '';
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl,
                                      width: 150.w,
                                      height: 120.h,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Shimmer(
                                        duration: const Duration(seconds: 2),
                                        color: Colors.grey.shade400,
                                        colorOpacity: 0.3,
                                        enabled: true,
                                        child: Container(
                                          width: 150.w,
                                          height: 120.h,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: 150.w,
                                            height: 120.h,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.error),
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        // Cities in this country
                        SizedBox(height: 24.h),
                        CountryCitiesWidget(
                          countryId: country.sId ?? '',
                          countryName: isArabic
                              ? (country.nameAr ?? country.name ?? '')
                              : (country.name ?? ''),
                        ),

                        // Guide Sections
                        if (state.guideResponse?.data != null) ...[
                          if (state
                                  .guideResponse!
                                  .data!
                                  .restaurants
                                  ?.isNotEmpty ??
                              false) ...[
                            SizedBox(height: 24.h),
                            CountryRestaurantsSection(
                              restaurants:
                                  state.guideResponse!.data!.restaurants!,
                            ),
                          ],
                          if (state
                                  .guideResponse!
                                  .data!
                                  .placesToVisit
                                  ?.isNotEmpty ??
                              false) ...[
                            SizedBox(height: 24.h),
                            CountryPlacesToVisitSection(
                              placesToVisit:
                                  state.guideResponse!.data!.placesToVisit!,
                            ),
                          ],
                          if (state
                                  .guideResponse!
                                  .data!
                                  .thingsToDo
                                  ?.isNotEmpty ??
                              false) ...[
                            SizedBox(height: 24.h),
                            CountryThingsToDoSection(
                              thingsToDo:
                                  state.guideResponse!.data!.thingsToDo!,
                            ),
                          ],
                        ],

                        // Packages Section
                        if (state.packages != null &&
                            state.packages!.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? 'باقات سياحية' : 'Tour Packages',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SizedBox(
                                  height: 340.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.packages!.length,
                                    itemBuilder: (context, index) {
                                      final packageData =
                                          state.packages![index];
                                      final package = Data.fromJson(
                                        packageData as Map<String, dynamic>,
                                      );

                                      return Padding(
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: SizedBox(
                                          width: 300.w,
                                          child: PackageCardView(
                                            package: package,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                Routes.packageDetailsView,
                                                arguments: {
                                                  'slug':
                                                      package.slug ??
                                                      package.sId ??
                                                      '',
                                                  'packageTitle': isArabic
                                                      ? (package.nameAr ??
                                                            package.name ??
                                                            '')
                                                      : (package.name ?? ''),
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Related Countries Section
                        SizedBox(height: 32.h),
                        RelatedCountriesWidget(
                          relatedCountries: country.relatedCountries,
                          isArabic: isArabic,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
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
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
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
    );
  }
}
