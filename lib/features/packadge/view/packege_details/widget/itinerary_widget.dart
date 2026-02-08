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
            return Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Indicator
                  Column(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.w,
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
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (index != itinerary.length - 1)
                        Container(
                          width: 2.w,
                          height: 60.h,
                          color: AppColor.lightGrey.withOpacity(0.3),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? (day.titleAr ?? 'اليوم ${day.day}')
                              : (day.title ?? 'Day ${day.day}'),
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mainBlack,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        if (day.description != null ||
                            day.descriptionAr != null)
                          Text(
                            isArabic
                                ? (day.descriptionAr ?? day.description ?? '')
                                : (day.description ?? ''),
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColor.secondaryBlack,
                              height: 1.5,
                            ),
                          ),
                        if (day.activities != null &&
                            day.activities!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: day.activities!.map((activity) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.offWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColor.lightGrey.withOpacity(
                                        0.3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    isArabic
                                        ? (activity.nameAr ??
                                              activity.name ??
                                              '')
                                        : (activity.name ?? ''),
                                    style: AppTextStyle.setPoppinsTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.secondaryBlack,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
