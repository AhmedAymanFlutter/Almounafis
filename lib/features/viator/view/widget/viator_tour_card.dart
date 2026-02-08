import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViatorTourCard extends StatelessWidget {
  final ViatorTour tour;
  final bool isArabic;
  final double? width;

  const ViatorTourCard({
    super.key,
    required this.tour,
    required this.isArabic,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? (tour.titleAr ?? tour.title) : tour.title;
    final cityName = tour.city?.name ?? '';
    final price = tour.price;
    final rating = tour.rating;

    return Container(
      width: width ?? 200.w,
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: tour.coverImage != null
                ? CachedNetworkImage(
                    imageUrl: tour.coverImage!,
                    height: 110.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(height: 110.h, color: Colors.grey[200]),
                    errorWidget: (context, url, error) => Container(
                      height: 110.h,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  )
                : Container(
                    height: 110.h,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
          ),

          // Details
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.mainBlack,
                  ),
                ),
                SizedBox(height: 8.h),

                // Location
                if (cityName.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14.sp,
                        color: AppColor.secondaryGrey,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          cityName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.secondaryGrey,
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 8.h),

                // Price & Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    if (price != null)
                      Text(
                        '${price.amount} ${price.currency}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.secondaryblue,
                        ),
                      ),

                    // Rating
                    if (rating != null)
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.sp, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text(
                            '${rating.average}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.mainBlack,
                            ),
                          ),
                        ],
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
