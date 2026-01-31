import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/router/routes.dart';
import '../../localization/manager/localization_cubit.dart';

class UpcomingTourCard extends StatelessWidget {
  final CityTourData tour;
  final String title, subtitle, imageUrl, tag;

  const UpcomingTourCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tag,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, languageState) {
        final isArabic = languageState == AppLanguage.arabic;
        final bool hasImage = imageUrl.isNotEmpty;

        return InkWell(
          onTap: () {
            final tourIdentifier = tour.id ?? tour.sId ?? '';

            if (tourIdentifier.isNotEmpty) {
              Navigator.pushNamed(
                context,
                Routes.cityTourDetails,
                arguments: {
                  'tourIdOrSlug': tourIdentifier,
                  'tourTitle': tour.title,
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isArabic ? 'معرف الجولة غير متاح' : 'Tour ID not available',
                  ),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(24.r),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF1F5F9), // Light blue-grey shadow
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                // 🖼️ Modern Image Section
                Container(
                  width: 110.w,
                  height: 130.h,
                  margin: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      hasImage
                          ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[100],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  _buildPlaceholder(isArabic),
                            )
                          : _buildPlaceholder(isArabic),

                      // subtle gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 📝 Content Section
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tag Pill
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.lightPurple.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.lightPurple,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // Title
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1E293B), // Slate 800
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: isArabic
                              ? TextAlign.right
                              : TextAlign.left,
                        ),

                        SizedBox(height: 8.h),

                        // Subtitle with Icon
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                subtitle,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: isArabic
                                    ? TextAlign.right
                                    : TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Arrow Action
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Icon(
                      isArabic
                          ? Icons.arrow_back_ios_new_rounded
                          : Icons.arrow_forward_ios_rounded,
                      size: 14.sp,
                      color: AppColor.mainBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder(bool isArabic) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey[300],
            size: 28.sp,
          ),
        ],
      ),
    );
  }
}
