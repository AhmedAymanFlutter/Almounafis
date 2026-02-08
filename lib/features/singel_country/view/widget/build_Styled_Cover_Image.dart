import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;

import '../../../../config/router/routes.dart';
import '../../../localization/manager/localization_cubit.dart';

Widget buildStyledCoverImage(BuildContext context, dynamic country) {
  final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

  // Safely get image URL based on model type
  final String? imageUrl = country.images?.coverImage?.url;

  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 77, right: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: [
          // ✅ Cover Image
          if (imageUrl != null && imageUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 650.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer(
                duration: const Duration(seconds: 2),
                color: Colors.grey.shade400,
                colorOpacity: 0.3,
                enabled: true,
                child: Container(height: 400.h, color: Colors.grey[300]),
              ),
              errorWidget: (context, url, error) => Container(
                height: 650.h,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                ),
              ),
            ),

          // ✅ Gradient Overlay
          Container(
            height: 650.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                stops: const [0.5, 1.0],
              ),
            ),
          ),

          // ✅ Back Button
          Positioned(
            top: 40.h,
            left: isArabic ? null : 16.w,
            right: isArabic ? 16.w : null,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.home),
              child: Container(
                width: 44.w,
                height: 44.h,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/arrowback.svg',
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),

          // ✅ Weather indicator
          Positioned(
            top: 40.h,
            left: isArabic ? 16.w : null,
            right: isArabic ? null : 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.wb_sunny, size: 20.sp, color: Colors.orange),
                  SizedBox(width: 4.w),
                  Text(
                    '25°',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Country Name (يدعم العربية)
          Positioned(
            bottom: 60.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic
                      ? (country.nameAr ?? 'دولة غير معروفة')
                      : (country.name ?? 'Unknown Country'),
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                if (!isArabic && country.nameAr != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    country.nameAr!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white.withOpacity(0.9),
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ✅ Location Label
          Positioned(
            bottom: 16.h,
            right: isArabic ? null : 16.w,
            left: isArabic ? 16.w : null,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 18.sp, color: Colors.red),
                  SizedBox(width: 4.w),
                  Text(
                    isArabic
                        ? (country?.continent ?? 'غير معروف')
                        : (country?.continent ?? 'Unknown'),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
