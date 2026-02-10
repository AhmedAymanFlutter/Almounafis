import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class ModernCountryCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final String currency;
  final String location;
  final String countryId;

  const ModernCountryCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.currency,
    required this.location,
    required this.countryId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 16.w),
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
                child: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 140.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          height: 140.h,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Container(
                        height: 140.h,
                        width: double.infinity,
                        color: Colors.grey[200],
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
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.setPoppinsBlack(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
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
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.setPoppinssecondaryGery(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
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
