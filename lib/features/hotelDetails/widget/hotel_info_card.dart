import 'package:almonafs_flutter/features/hotelDetails/widget/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/manager/localization_cubit.dart';

class HotelInfoCard extends StatelessWidget {
  final dynamic hotel;

  const HotelInfoCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Name and Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Name
                Expanded(
                  child: Text(
                    _getLocalizedHotelName(hotel, isArabic),
                    style: AppTextStyle.setPoppinsSecondaryBlack(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 12.w),
                // Star Rating
                StarRating(rating: hotel.starRating ?? 0),
              ],
            ),
            
            SizedBox(height: 12.h),
            
            // Location Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon - positioned based on language
                if (!isArabic) ...[
                  Icon(Icons.location_on, size: 18.sp, color: Colors.grey),
                  SizedBox(width: 6.w),
                ],
                
                // Address Text
                Expanded(
                  child: Text(
                    _getLocalizedAddress(hotel, isArabic),
                    style: AppTextStyle.setPoppinsSecondlightGrey(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // Icon - positioned based on language
                if (isArabic) ...[
                  SizedBox(width: 6.w),
                  Icon(Icons.location_on, size: 18.sp, color: Colors.grey),
                ],
              ],
            ),

            // Additional Hotel Info (if available)
            if (_hasAdditionalInfo(hotel, isArabic)) ...[
              SizedBox(height: 8.h),
              _buildAdditionalInfo(context, hotel, isArabic),
            ],
          ],
        ),
      ),
    );
  }

  // Get localized hotel name
  String _getLocalizedHotelName(dynamic hotel, bool isArabic) {
    if (hotel.nameAr != null && isArabic && hotel.nameAr!.isNotEmpty) {
      return hotel.nameAr!;
    } else if (hotel.name != null && hotel.name!.isNotEmpty) {
      return hotel.name!;
    } else if (hotel.titleAr != null && isArabic && hotel.titleAr!.isNotEmpty) {
      return hotel.titleAr!;
    } else if (hotel.title != null && hotel.title!.isNotEmpty) {
      return hotel.title!;
    }
    return isArabic ? 'اسم الفندق' : 'Hotel Name';
  }

  // Get localized address
  String _getLocalizedAddress(dynamic hotel, bool isArabic) {
    if (hotel.addressAr != null && isArabic && hotel.addressAr!.isNotEmpty) {
      return hotel.addressAr!;
    } else if (hotel.addressAr != null && isArabic && hotel.addressAr!.isNotEmpty) {
      return hotel.addressAr!;
    } else if (hotel.addressAr != null && hotel.addressAr!.isNotEmpty) {
      return hotel.addressAr!;
    } else if (hotel.address != null && hotel.address!.isNotEmpty) {
      return hotel.address!;
    } else if (hotel.locationAr != null && isArabic && hotel.locationAr!.isNotEmpty) {
      return hotel.locationAr!;
    } else if (hotel.location != null && hotel.location!.isNotEmpty) {
      return hotel.location!;
    }
    return isArabic ? 'العنوان غير متوفر' : 'Address not available';
  }

  // Check if additional info is available
  bool _hasAdditionalInfo(dynamic hotel, bool isArabic) {
    return (hotel.description != null && hotel.description!.isNotEmpty) ||
           (hotel.descriptionAr != null && hotel.descriptionAr!.isNotEmpty) ||
           (hotel.phone != null && hotel.phone!.isNotEmpty) ||
           (hotel.email != null && hotel.email!.isNotEmpty);
  }

  // Build additional hotel information
  Widget _buildAdditionalInfo(BuildContext context, dynamic hotel, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description (if available)
        if ((hotel.description != null && hotel.description!.isNotEmpty) ||
            (hotel.descriptionAr != null && hotel.descriptionAr!.isNotEmpty))
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              _getLocalizedDescription(hotel, isArabic),
              style: AppTextStyle.setPoppinsSecondlightGrey(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        // Contact Info Row
        if ((hotel.phone != null && hotel.phone!.isNotEmpty) ||
            (hotel.email != null && hotel.email!.isNotEmpty))
          Row(
            children: [
              if (!isArabic && hotel.phone != null && hotel.phone!.isNotEmpty) ...[
                Icon(Icons.phone, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(
                  hotel.phone!,
                  style: AppTextStyle.setPoppinsSecondlightGrey(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (hotel.email != null && hotel.email!.isNotEmpty) 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
              
              if (hotel.email != null && hotel.email!.isNotEmpty) 
                Expanded(
                  child: Text(
                    hotel.email!,
                    style: AppTextStyle.setPoppinsSecondlightGrey(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              
              if (isArabic && hotel.phone != null && hotel.phone!.isNotEmpty) ...[
                if (hotel.email != null && hotel.email!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                Text(
                  hotel.phone!,
                  style: AppTextStyle.setPoppinsSecondlightGrey(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.phone, size: 14.sp, color: Colors.grey),
              ],
            ],
          ),
      ],
    );
  }

  // Get localized description
  String _getLocalizedDescription(dynamic hotel, bool isArabic) {
    if (hotel.descriptionAr != null && isArabic && hotel.descriptionAr!.isNotEmpty) {
      return hotel.descriptionAr!;
    } else if (hotel.description != null && hotel.description!.isNotEmpty) {
      return hotel.description!;
    } else if (hotel.shortDescriptionAr != null && isArabic && hotel.shortDescriptionAr!.isNotEmpty) {
      return hotel.shortDescriptionAr!;
    } else if (hotel.shortDescription != null && hotel.shortDescription!.isNotEmpty) {
      return hotel.shortDescription!;
    }
    return '';
  }
}