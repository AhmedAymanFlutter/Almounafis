import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourAboutSection extends StatelessWidget {
  final ViatorTour tour;

  const TourAboutSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tour.itinerary?.duration?.fixedDurationInMinutes != null) ...[
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.primaryWhite,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_filled,
                  size: 20.sp,
                  color: AppColor.secondaryblue,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${tour.itinerary!.duration!.fixedDurationInMinutes! ~/ 60}h ${tour.itinerary!.duration!.fixedDurationInMinutes! % 60}m',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        _buildSectionTitle(
          isArabic ? ViatorStringsAr.description : ViatorStringsEn.description,
        ),
        HtmlContentWidget(
          htmlContent: tour.description ?? '<p>No description available.</p>',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          textColor: AppColor.secondaryGrey,
        ),
        SizedBox(height: 24.h),

        if (tour.pricingInfo != null && tour.pricingInfo!.ageBands != null) ...[
          _buildSectionTitle(
            isArabic
                ? ViatorStringsAr.pricingAndAges
                : ViatorStringsEn.pricingAndAges,
          ),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: tour.pricingInfo!.ageBands!.map((band) {
              return Chip(
                backgroundColor: AppColor.primaryWhite,
                side: BorderSide(color: AppColor.lightGrey.withOpacity(0.3)),
                avatar: Icon(
                  Icons.person_outline,
                  size: 18.sp,
                  color: AppColor.secondaryblue,
                ),
                label: Text(
                  '${band.ageBand} (${band.startAge}-${band.endAge})',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyle.setPoppinsBlack(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
