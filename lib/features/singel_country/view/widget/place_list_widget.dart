import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/singel_country/data/model/tour_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceListWidget extends StatelessWidget {
  final String title;
  final List<Place> places;
  final bool isArabic;

  const PlaceListWidget({
    super.key,
    required this.title,
    required this.places,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.mainBlack,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 240.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: places.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: isArabic ? 0 : 12.w,
                  left: isArabic ? 12.w : 0,
                ),
                child: _buildPlaceCard(context, places[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceCard(BuildContext context, Place place) {
    // Get cover image or first image
    String imageUrl = '';
    if (place.images != null && place.images!.isNotEmpty) {
      final cover = place.images!.firstWhere(
        (img) => img.isCover == true,
        orElse: () => place.images!.first,
      );
      imageUrl = cover.url ?? '';
    }

    return GestureDetector(
      onTap: () async {
        if (place.bookingUrl != null && place.bookingUrl!.isNotEmpty) {
          final Uri url = Uri.parse(place.bookingUrl!);
          if (!await launchUrl(url)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not launch URL')),
            );
          }
        } else {
          // Show simple details dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(place.name ?? ''),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(height: 12.h),
                    Text(place.description ?? 'No description available.'),
                    if (place.location?.address != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        'Address: ${place.location!.address}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 120.h,
                      width: 200.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer(
                        duration: const Duration(seconds: 2),
                        color: Colors.grey.shade400,
                        colorOpacity: 0.3,
                        enabled: true,
                        child: Container(
                          height: 120.h,
                          width: 200.w,
                          color: Colors.grey[300],
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 120.h,
                        width: 200.w,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    )
                  : Container(
                      height: 120.h,
                      width: 200.w,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
            ),

            // Details
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name ?? '',
                    style: AppTextStyle.setPoppinsTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.mainBlack,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (place.type != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      place.type!,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.secondaryGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (place.rating != null) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14.sp, color: Colors.amber),
                        SizedBox(width: 4.w),
                        Text(
                          '${place.rating}',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.mainBlack,
                          ),
                        ),
                        if (place.reviewsCount != null)
                          Text(
                            ' (${place.reviewsCount})',
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.secondaryGrey,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
