import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/router/routes.dart';
import '../../localization/manager/localization_cubit.dart';

class UpcomingTourCard extends StatelessWidget {
  final Data tour; 
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
                  content: Text(isArabic ? 'معرف الجولة غير متاح' : 'Tour ID not available'),
                ),
              );
            }
          },
          child: Container(
            width: 370.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(color: AppColor.secondaryGrey.withOpacity(0.6)),
            ),
            child: Row(
              children: [
                // Image Container
                Container(
                  width: 80.w,
                  height: double.infinity,
                  padding: EdgeInsets.all(3.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: SizedBox(
                      width: 74.w,
                      height: 70.h,
                      child: hasImage
                          ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 74.w,
                              height: 70.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 74.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) {
                                return _buildPlaceholder(isArabic);
                              },
                            )
                          : _buildPlaceholder(isArabic),
                    ),
                  ),
                ),
                
                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tag
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                        // Title
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          ),
                        ),
                        
                        // Subtitle
                        Flexible(
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                          ),
                        ),
                      ],
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
      width: 74.w,
      height: 81.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, color: Colors.grey, size: 16.sp),
          SizedBox(height: 2.h),
          Text(
            isArabic ? 'لا توجد صورة' : 'No Image',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 8.sp,
            ),
          ),
        ],
      ),
    );
  }
}