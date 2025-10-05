import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/home/manager/country_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../home/manager/country_cubit.dart';
import 'widget/build_Booking_Button.dart';
import 'widget/build_Info_Card.dart';
import 'widget/build_Styled_Cover_Image.dart';
import 'widget/shimmer_widget.dart';

class CountryDetailsPage extends StatelessWidget {
  final String countryIdOrSlug;
  final String? countryName;

  const CountryDetailsPage({
    super.key,
    required this.countryIdOrSlug,
    this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    context.read<CountryCubit>().fetchCountryDetails(countryIdOrSlug);

    return Scaffold(
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
                  // Enhanced Cover Image with overlay
                  buildStyledCoverImage(context, country),

                  Padding(
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
                                label: 'Code',
                                value: country.code ?? 'N/A',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: buildInfoCard(
                                icon: Icons.public,
                                label: 'Continent',
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
                                label: 'Currency',
                                value: country.currency ?? 'N/A',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: buildInfoCard(
                                icon: Icons.language,
                                label: 'Language',
                                value: country.language ?? 'N/A',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // booking button
                        buildBookButton(country),
                        SizedBox(height: 24.h),
                        // Description
                        Text(
                          'About',
                  style: AppTextStyle.setPoppinsTextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColor.mainBlack)

                        ),
                        SizedBox(height: 8.h),
                        Text(
                          country.descriptionFlutter ??
                              country.description ??
                              'No description available',
                          style: AppTextStyle.setPoppinsTextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: AppColor.mainBlack)
                        ),
                        // Arabic Description
                        if (country.descriptionArFlutter != null ||
                            country.descriptionAr != null) ...[
                          SizedBox(height: 16.h),                                                  
                        ],
                        // Image Gallery
                        if (country.images != null &&
                            country.images!.isNotEmpty) ...[
                          SizedBox(height: 24.h),
                          Text(
                            'Gallery',
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
                              itemCount: country.images!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: country.images![index],
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

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CountryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<CountryCubit>()
                          .fetchCountryDetails(countryIdOrSlug);
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          return Center(child: Text('Unknown state'));
        },
      ),
    );
  } 
}