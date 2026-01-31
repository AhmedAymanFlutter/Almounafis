import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../upcomming_Tour/data/model/city_tour.dart';

class ModernTourCard extends StatelessWidget {
  final CityTourData tour;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String tag;

  const ModernTourCard({
    super.key,
    required this.tour,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    // Extract duration if available or use default logic
    String durationText = "12 Days"; // Default fallback
    if (tour.duration != null) {
      if (tour.duration!.type != null) {
        durationText = "${tour.duration!.hours ?? ''} ${tour.duration!.type}";
      } else {
        durationText = "${tour.duration!.hours ?? ''} Hours";
      }
    }

    return Container(
      width: 200.w, // Fixed width for horizontal list
      margin: EdgeInsets.only(
        right: 16.w,
      ), // Right margin for horizontal application
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 140.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    height: 140.h,
                    color: Colors.grey[200],
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
              // Duration/Tag Badge (Top Right)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColor.secondaryblue,
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        durationText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Details Section
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: AppColor.secondaryblue,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        // Use subtitle or location if available, fallback to subtitle logic
                        // In original call, subtitle passed tour.description.
                        // Ideally we want location here to match Country Card.
                        // But let's stick to what we have or try to use cityName if in tour.
                        tour.cityName ?? tour.cityNameAr ?? subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
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
}
