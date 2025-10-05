import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../singel_country/view/CountryDetailsPage.dart';

class GuidedTourCard extends StatelessWidget {
  final String title, location, imageUrl, tag;
  final String countryId; // ✅ Add this parameter

  const GuidedTourCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.tag,
    required this.countryId, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ✅ Navigate to details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetailsPage(
              countryIdOrSlug: countryId,
              countryName: location,
            ),
          ),
        );
      },
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey, width: 1),
          color: AppColor.primaryWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.lightGrey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 150,
                width: 240,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 2),
                  color: Colors.grey.shade400,
                  colorOpacity: 0.3,
                  enabled: true,
                  child: Container(
                    height: 150,
                    width: 240,
                    color: Colors.grey[300],
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 150,
                  width: 240,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColor.secondaryBlack, size: 14.sp),
                      SizedBox(width: 4.w),
                      Expanded( 
                        child: Text(
                          location,
                          style: AppTextStyle.setPoppinsSecondaryBlack(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}