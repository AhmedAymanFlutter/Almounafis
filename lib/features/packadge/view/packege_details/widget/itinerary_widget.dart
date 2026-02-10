import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/packadge/data/model/package_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItineraryWidget extends StatelessWidget {
  final List<Itinerary> itinerary;
  final bool isArabic;

  const ItineraryWidget({
    super.key,
    required this.itinerary,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? 'جدول الرحلة' : 'Itinerary',
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColor.mainBlack,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itinerary.length,
          itemBuilder: (context, index) {
            final day = itinerary[index];
            final isLast = index == itinerary.length - 1;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Vertical Line (Behind everything)
                if (!isLast)
                  Positioned(
                    top: 28.w, // Start below the circle
                    bottom:
                        -24.h -
                        4.h, // Extend to next item (covering bottom padding)
                    left: 13
                        .w, // Center of 28.w circle (14) - half of 2.w line (1) = 13
                    child: Container(
                      width: 2.w,
                      color: AppColor.lightGrey.withOpacity(0.3),
                    ),
                  ),

                // Content
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline Indicator Circle
                      Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.mainColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // Content Card
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColor.lightGrey.withOpacity(0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              childrenPadding: EdgeInsets.fromLTRB(
                                16.w,
                                0,
                                16.w,
                                16.h,
                              ),
                              initiallyExpanded: index == 0,
                              shape: const Border(), // Remove default borders
                              collapsedShape: const Border(),
                              title: Text(
                                isArabic
                                    ? (day.titleAr ?? 'اليوم ${day.day}')
                                    : (day.title ?? 'Day ${day.day}'),
                                style: AppTextStyle.setPoppinsTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.mainBlack,
                                ),
                              ),
                              children: [
                                if (day.description != null ||
                                    day.descriptionAr != null)
                                  Text(
                                    isArabic
                                        ? (day.descriptionAr ??
                                              day.description ??
                                              '')
                                        : (day.description ?? ''),
                                    style: AppTextStyle.setPoppinsTextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.secondaryBlack,
                                      height: 1.6,
                                    ),
                                  ),

                                if (day.activities != null &&
                                    day.activities!.isNotEmpty) ...[
                                  SizedBox(height: 16.h),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children: day.activities!.map((activity) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.mainColor.withOpacity(
                                            0.05,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          border: Border.all(
                                            color: AppColor.mainColor
                                                .withOpacity(0.1),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.local_activity,
                                              size: 14.sp,
                                              color: AppColor.mainColor,
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              isArabic
                                                  ? (activity.nameAr ??
                                                        activity.name ??
                                                        '')
                                                  : (activity.name ?? ''),
                                              style:
                                                  AppTextStyle.setPoppinsTextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColor.mainColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
