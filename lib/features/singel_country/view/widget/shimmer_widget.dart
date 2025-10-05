import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;

Widget buildLoadingShimmer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.grey.shade400,
            colorOpacity: 0.3,
            enabled: true,
            child: Container(
              height: 400.h,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Shimmer(
                        duration: const Duration(seconds: 2),
                        color: Colors.grey.shade400,
                        colorOpacity: 0.3,
                        enabled: true,
                        child: Container(
                          height: 80.h,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Shimmer(
                        duration: const Duration(seconds: 2),
                        color: Colors.grey.shade400,
                        colorOpacity: 0.3,
                        enabled: true,
                        child: Container(
                          height: 80.h,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }