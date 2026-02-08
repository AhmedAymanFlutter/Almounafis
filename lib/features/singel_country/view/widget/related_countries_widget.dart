import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/singel_country/data/model/country_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RelatedCountriesWidget extends StatelessWidget {
  final List<RelatedCountry>? relatedCountries;
  final bool isArabic;

  const RelatedCountriesWidget({
    super.key,
    required this.relatedCountries,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    if (relatedCountries == null || relatedCountries!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            isArabic
                ? 'وجهات سياحية أخرى حول العالم'
                : 'Other Tourist Destinations Around the World',
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.mainBlack,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: relatedCountries!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: isArabic ? 0 : 12.w,
                  left: isArabic ? 12.w : 0,
                ),
                child: _buildCountryCard(context, relatedCountries![index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountryCard(BuildContext context, RelatedCountry country) {
    final countryName = isArabic
        ? (country.nameAr ?? country.name ?? '')
        : (country.name ?? '');
    final imageUrl = country.coverImage?.url ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.countryDetails,
          arguments: {
            'countryIdOrSlug': country.slug ?? country.sId ?? country.name,
            'countryName': countryName,
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
              // Country Image
              if (imageUrl.isNotEmpty)
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
                      Icons.public,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Container(
                  height: 200.h,
                  width: 280.w,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.public,
                    size: 50,
                    color: Colors.white,
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
              // Country Name and Info
              Positioned(
                bottom: 16.h,
                left: 16.w,
                right: 16.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      countryName,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          isArabic ? 'استكشف البلد' : 'Explore Country',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
