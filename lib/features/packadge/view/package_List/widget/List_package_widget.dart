import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../localization/manager/localization_cubit.dart';

class PackageCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final VoidCallback onTap;

  const PackageCard({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h, left: 4.w, right: 4.w),
          height: 110.h,
          decoration: BoxDecoration(
            color: AppColor.secondaryblue, // Vibrant blue
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.secondaryblue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              //  Image Section with white background "pop" effect
              Container(
                width: 125.w,
                color: Colors.white,
                child: ClipPath(
                  clipper: _ModernCurvedClipper(),
                  child: image.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Container(color: Colors.grey[200]),
                ),
              ),

              // 💙 Package Details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.setPoppinsTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Expanded(
                        child: Text(
                          // Simple text instead of HTML for cleaner look in small cards
                          description.replaceAll(RegExp(r'<[^>]*>'), ''),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isArabic ? "شركة المنافس" : "Almounafies",
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Icon(
                            isArabic
                                ? Icons.arrow_back_ios_new
                                : Icons.arrow_forward_ios,
                            size: 14.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modern slanted/curved clipper for the image section
class _ModernCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    // Add a slight curve or slant for a dynamic look
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.5,
      size.width,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
