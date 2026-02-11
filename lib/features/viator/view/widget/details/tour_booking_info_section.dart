import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourBookingInfoSection extends StatelessWidget {
  final ViatorTour tour;

  const TourBookingInfoSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    if (tour.bookingRequirements == null &&
        tour.bookingConfirmationSettings == null) {
      return const SizedBox.shrink();
    }

    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          isArabic
              ? ViatorStringsAr.bookingRequirements
              : ViatorStringsEn.bookingRequirements,
        ),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColor.primaryWhite,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              if (tour.bookingRequirements != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${isArabic ? ViatorStringsAr.minTravelers : ViatorStringsEn.minTravelers}: ${tour.bookingRequirements!.minTravelersPerBooking}',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      '${isArabic ? ViatorStringsAr.maxTravelers : ViatorStringsEn.maxTravelers}: ${tour.bookingRequirements!.maxTravelersPerBooking}',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                if (tour.bookingRequirements!.requiresAdultForBooking == true)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 16.sp,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            isArabic
                                ? ViatorStringsAr.requiresAdult
                                : ViatorStringsEn.requiresAdult,
                            style: AppTextStyle.setPoppinsSecondaryBlack(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              if (tour.bookingConfirmationSettings != null) ...[
                Divider(),
                Row(
                  children: [
                    Text(
                      '${isArabic ? ViatorStringsAr.confirmationType : ViatorStringsEn.confirmationType}: ',
                      style: AppTextStyle.setPoppinsBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      tour.bookingConfirmationSettings!.confirmationType ?? '',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
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
