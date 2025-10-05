 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;

Widget buildStyledCoverImage(BuildContext context, dynamic country) {
    return Stack(
      children: [
        // Cover Image
        if (country.imageCover != null)
          CachedNetworkImage(
            imageUrl: country.imageCover!,
            height: 400.h,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer(
              duration: const Duration(seconds: 2),
              color: Colors.grey.shade400,
              colorOpacity: 0.3,
              enabled: true,
              child: Container(
                height: 400.h,
                color: Colors.grey[300],
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: 400.h,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.error, color: Colors.red, size: 50),
              ),
            ),
          ),

        // Gradient Overlay
        Container(
          height: 400.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
              stops: [0.5, 1.0],
            ),
          ),
        ),

        // Back Button
        Positioned(
          top: 40.h,
          left: 16.w,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44.w,
              height: 44.h,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child:SvgPicture.asset('assets/icons/arrowback.svg',width: 24.w,height: 24.h,fit: BoxFit.scaleDown,)
            ),
          ),
        ),

        // Weather indicator (optional - you can replace with actual weather data)
        Positioned(
          top: 40.h,
          right: 16.w,
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

        // Country Name at Bottom
        Positioned(
          bottom: 60.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                country.name ?? 'Unknown Country',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              if (country.nameAr != null) ...[
                SizedBox(height: 4.h),
                Text(
                  country.nameAr!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.9),
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
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

        // Location Icon at Bottom Right
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 18.sp,
                  color: Colors.red,
                ),
                SizedBox(width: 4.w),
                Text(
                  country.continent ?? 'Unknown',
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
    );
  }
