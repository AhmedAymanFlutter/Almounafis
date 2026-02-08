import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CountryCitiesWidget extends StatefulWidget {
  final String countryId;
  final String countryName;

  const CountryCitiesWidget({
    super.key,
    required this.countryId,
    required this.countryName,
  });

  @override
  State<CountryCitiesWidget> createState() => _CountryCitiesWidgetState();
}

class _CountryCitiesWidgetState extends State<CountryCitiesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CityCubit>().getCitiesByCountry(widget.countryId);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return BlocBuilder<CityCubit, CityState>(
      builder: (context, state) {
        if (state is CityLoading) {
          return _buildLoadingState();
        } else if (state is CityLoaded) {
          final cities = state.cityResponse.data?.cities ?? [];

          if (cities.isEmpty) {
            return _buildEmptyState(isArabic);
          }

          return _buildCitiesGrid(cities, isArabic);
        } else if (state is CityError) {
          return _buildErrorState(state.message, isArabic);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    return Column(
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
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Shimmer(
              duration: const Duration(seconds: 2),
              color: Colors.grey.shade400,
              colorOpacity: 0.3,
              enabled: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCitiesGrid(List<City> cities, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic
              ? 'المدن في ${widget.countryName}'
              : 'Cities in ${widget.countryName}',
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.mainBlack,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: isArabic ? 0 : 12.w,
                  left: isArabic ? 12.w : 0,
                ),
                child: _buildCityCard(cities[index], isArabic),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityCard(City city, bool isArabic) {
    final imageUrl = city.imagesObject?.coverImage?.url ?? '';
    final cityName = isArabic
        ? (city.nameAr ?? city.name ?? '')
        : (city.name ?? '');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.cityDetailsPage,
          arguments: {
            'idOrSlug': city.slug ?? city.id ?? city.name,
            'cityName': cityName,
          },
        );
      },
      child: Container(
        width: 280.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // City Image
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: 200.h,
                width: 280.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 2),
                  color: Colors.grey.shade400,
                  colorOpacity: 0.3,
                  enabled: true,
                  child: Container(
                    height: 200.h,
                    width: 280.w,
                    color: Colors.grey[300],
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200.h,
                  width: 280.w,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.location_city,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              // Gradient Overlay
              Container(
                height: 200.h,
                width: 280.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),
              // City Name and Info
              Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityName,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (city.weather != null) ...[
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 16.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${city.weather!.currentTemp?.toInt() ?? '--'}°C',
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Location Icon (top right)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.location_on,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Icon(
              Icons.location_city_outlined,
              size: 60.sp,
              color: AppColor.lightGrey.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              isArabic ? 'لا توجد مدن متاحة' : 'No cities available',
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.secondaryGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, bool isArabic) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 60.sp, color: Colors.red),
            SizedBox(height: 16.h),
            Text(
              message,
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.secondaryGrey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context.read<CityCubit>().getCitiesByCountry(widget.countryId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isArabic ? 'أعد المحاولة' : 'Try Again',
                style: AppTextStyle.setPoppinsTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
