import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourReviewsWidget extends StatelessWidget {
  final ReviewData reviews;

  const TourReviewsWidget({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.reviewCountTotals == null) return const SizedBox();

    // Sort by rating descending (5 stars first)
    final sortedReviews = List<ReviewCountTotals>.from(
      reviews.reviewCountTotals!,
    );
    sortedReviews.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));

    return Column(
      children: sortedReviews.map((item) {
        final percentage =
            (reviews.totalReviews != null && reviews.totalReviews! > 0)
            ? (item.count! / reviews.totalReviews!)
            : 0.0;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              SizedBox(
                width: 45.w,
                child: Text(
                  '${item.rating} Star',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 8.h,
                    backgroundColor: AppColor.primaryWhite,
                    color: AppColor.mainColor,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 30.w,
                child: Text(
                  '(${item.count})',
                  style: AppTextStyle.setPoppinssecondaryGery(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
