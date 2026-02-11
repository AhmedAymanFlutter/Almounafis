import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourCancellationSection extends StatelessWidget {
  final ViatorTour tour;

  const TourCancellationSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    if (tour.cancellationPolicy == null) {
      return const SizedBox.shrink();
    }

    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          isArabic
              ? ViatorStringsAr.cancellationPolicy
              : ViatorStringsEn.cancellationPolicy,
        ),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.primaryWhite,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HtmlContentWidget(
                htmlContent: tour.cancellationPolicy!.description ?? '<p></p>',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                textColor: AppColor.secondaryBlack,
              ),
              if (tour.cancellationPolicy!.cancelIfBadWeather == true)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 16.sp,
                        color: AppColor.secondaryGrey,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          isArabic
                              ? ViatorStringsAr.goodWeatherRequired
                              : ViatorStringsEn.goodWeatherRequired,
                          style: AppTextStyle.setPoppinssecondaryGery(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (tour.cancellationPolicy!.cancelIfInsufficientTravelers ==
                  true)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 16.sp,
                        color: AppColor.secondaryGrey,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          isArabic
                              ? ViatorStringsAr.minTravelersRequired
                              : ViatorStringsEn.minTravelersRequired,
                          style: AppTextStyle.setPoppinssecondaryGery(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (tour.cancellationPolicy!.refundEligibility != null)
                ...tour.cancellationPolicy!.refundEligibility!.map(
                  (r) => Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16.sp,
                          color: AppColor.secondaryGrey,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            isArabic
                                ? '${r.percentageRefundable}% ${ViatorStringsAr.refundIfCancelled} ${r.dayRangeMin} ${ViatorStringsAr.daysPrior}'
                                : '${r.percentageRefundable}% ${ViatorStringsEn.refundIfCancelled} ${r.dayRangeMin} ${ViatorStringsEn.daysPrior}',
                            style: AppTextStyle.setPoppinssecondaryGery(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
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
