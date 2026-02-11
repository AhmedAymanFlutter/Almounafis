import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_exclusions_widget.dart';
import 'package:almonafs_flutter/features/viator/view/widget/details/tour_inclusions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourAdditionalInfoSection extends StatelessWidget {
  final ViatorTour tour;

  const TourAdditionalInfoSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tour.inclusions != null && tour.inclusions!.isNotEmpty) ...[
          _buildSectionTitle(
            isArabic
                ? ViatorStringsAr.whatsIncluded
                : ViatorStringsEn.whatsIncluded,
          ),
          TourInclusionsWidget(inclusions: tour.inclusions!),
          SizedBox(height: 24.h),
        ],

        if (tour.exclusions != null && tour.exclusions!.isNotEmpty) ...[
          _buildSectionTitle(
            isArabic
                ? ViatorStringsAr.whatsExcluded
                : ViatorStringsEn.whatsExcluded,
          ),
          TourExclusionsWidget(exclusions: tour.exclusions!),
          SizedBox(height: 24.h),
        ],

        if (tour.ticketInfo != null) ...[
          _buildSectionTitle(
            isArabic ? ViatorStringsAr.ticketInfo : ViatorStringsEn.ticketInfo,
          ),
          Text(
            tour.ticketInfo!.ticketTypeDescription ?? '',
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 24.h),
        ],

        if (tour.additionalInfo != null && tour.additionalInfo!.isNotEmpty) ...[
          _buildSectionTitle(
            isArabic
                ? ViatorStringsAr.additionalInfo
                : ViatorStringsEn.additionalInfo,
          ),
          ...tour.additionalInfo!.map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: AppColor.secondaryblue,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      e.description ?? '',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
