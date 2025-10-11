import 'package:almonafs_flutter/features/hotelDetails/widget/star_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../localization/manager/localization_cubit.dart';

class HotelHeader extends StatelessWidget {
  
  final dynamic hotel;
  final List<String> images;

  const HotelHeader({
    super.key,
    required this.hotel,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    final imageUrl = images.isNotEmpty
        ? images.first
        : 'https://via.placeholder.com/400x300';

    return Padding(
      padding: EdgeInsets.only(left: 15.w, top: 77.h, right: 15.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // Cover Image
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
                child: Container(
                  height: 650.h,
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 650.h,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.error, color: Colors.red, size: 50),
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              height: 650.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
              left: isArabic ? null : 16.w, // Swap position for RTL
              right: isArabic ? 16.w : null, // Swap position for RTL
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
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isArabic ? 3.14159 : 0), // Flip for RTL
                    child: SvgPicture.asset(
                      'assets/icons/arrowback.svg',
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),

            // Rating Badge
            Positioned(
              top: 40.h,
              left: isArabic ? 16.w : null, // Swap position for RTL
              right: isArabic ? null : 16.w, // Swap position for RTL
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StarRating(rating: hotel.starRating)
              ),
            ),

            // Hotel Name
            Positioned(
              bottom: 60.h,
              left: 16.w,
              right: 16.w,
              child: Text(
                _getLocalizedHotelName(hotel, isArabic),
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
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ),

            // Hotel Location/Address
            if (hotel.address != null || hotel.location != null)
              Positioned(
                bottom: 30.h,
                left: 16.w,
                right: 16.w,
                child: Text(
                  _getLocalizedAddress(hotel, isArabic),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // Image Count Badge
            Positioned(
              bottom: 16.h,
              right: isArabic ? null : 16.w, // Swap position for RTL
              left: isArabic ? 16.w : null, // Swap position for RTL
              child: InkWell(
                onTap: () => _showImageGallery(context, isArabic),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.photo_library,
                          size: 18, color: Colors.blueAccent),
                      SizedBox(width: 4.w),
                      Text(
                        isArabic ? 
                          '${images.length}+ صورة' : 
                          '${images.length}+',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get localized hotel name
  String _getLocalizedHotelName(dynamic hotel, bool isArabic) {
    if (hotel.nameAr != null && isArabic) {
      return hotel.nameAr;
    } else if (hotel.name != null) {
      return hotel.name;
    }
    return isArabic ? 'اسم الفندق' : 'Hotel Name';
  }

  // Get localized address
  String _getLocalizedAddress(dynamic hotel, bool isArabic) {
    if (hotel.addressAr != null && isArabic) {
      return hotel.addressAr;
    } else if (hotel.address != null) {
      return hotel.address;
    } else if (hotel.locationAr != null && isArabic) {
      return hotel.locationAr;
    } else if (hotel.location != null) {
      return hotel.location;
    }
    return isArabic ? 'العنوان غير متوفر' : 'Address not available';
  }

  // Bottom Sheet Gallery with Arabic support
  void _showImageGallery(BuildContext context, bool isArabic) {
    if (images.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              // Gallery Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isArabic ? 'معرض الصور' : 'Image Gallery',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        InteractiveViewer(
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                        // Image Counter
                        Positioned(
                          top: 16.h,
                          right: isArabic ? null : 16.w,
                          left: isArabic ? 16.w : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w, 
                              vertical: 6.h
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isArabic ? 
                                '${index + 1} من ${images.length}' : 
                                '${index + 1} of ${images.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}