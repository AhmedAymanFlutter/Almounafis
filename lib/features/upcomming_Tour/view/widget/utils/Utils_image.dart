import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../config/router/routes.dart';
import '../../../../localization/manager/localization_cubit.dart';

Widget buildCoverImage(
  String imageUrl,
  BuildContext context, {
  String? countryName,
  String? arabicName,
  String? continent,
  String? continentAr,
}) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 77, right: 15),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        children: [
          // 🖼 Cover Image
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

          //  Gradient Overlay
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
                stops: const [0.5, 1.0],
              ),
            ),
          ),

          // 🔙 Back Button
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
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(isArabic ? 3.14159 : 0),
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

          // ☀️ Weather indicator
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

          // 🏙 Country Name (localized)
          if (countryName != null)
            Positioned(
              bottom: 60.h,
              left: 16.w,
              right: 16.w,
              child: Column(
                crossAxisAlignment:
                    isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic && arabicName != null ? arabicName : countryName,
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
                ],
              ),
            ),

          // 🌍 Continent (localized)
          if (continent != null)
            Positioned(
              bottom: 16.h,
              left: isArabic ? 16.w : null,
              right: isArabic ? null : 16.w,
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isArabic)
                      const Icon(Icons.location_on, color: Colors.red, size: 18),
                    SizedBox(width: 4.w),
                    Text(
                      isArabic && continentAr != null ? continentAr : continent,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isArabic) SizedBox(width: 4.w),
                    if (isArabic)
                      const Icon(Icons.location_on, color: Colors.red, size: 18),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

/// 🖼 Small Image Gallery Section
Widget buildImageGallery(BuildContext context, List<String> images) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  return Column(
    crossAxisAlignment:
        isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        isArabic ? 'معرض الصور' : 'Gallery',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      SizedBox(height: 12.h),
      SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: isArabic,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                right: isArabic ? 0 : 12.w,
                left: isArabic ? 12.w : 0,
              ),
              child: GestureDetector(
                onTap: () => _showImageGallery(context, images, index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: images[index],
                    width: 150.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer(
                      duration: const Duration(seconds: 2),
                      color: Colors.grey.shade400,
                      colorOpacity: 0.3,
                      enabled: true,
                      child: Container(
                        width: 150.w,
                        height: 120.h,
                        color: Colors.grey[300],
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 150.w,
                      height: 120.h,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

/// 📸 Full-Screen Image Viewer
void _showImageGallery(BuildContext context, List<String> images, int startIndex) {
  final isArabic = context.read<LanguageCubit>().isArabic;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      PageController controller = PageController(initialPage: startIndex);
      int currentIndex = startIndex;

      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        InteractiveViewer(
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                        // 📊 Image Counter
                        Positioned(
                          top: 20.h,
                          left: isArabic ? null : 20.w,
                          right: isArabic ? 20.w : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isArabic
                                  ? '${currentIndex + 1} من ${images.length}'
                                  : '${currentIndex + 1} of ${images.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // ❌ Close Button
                Positioned(
                  top: 20.h,
                  left: isArabic ? 20.w : null,
                  right: isArabic ? null : 20.w,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
