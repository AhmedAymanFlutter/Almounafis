import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourLogisticsSection extends StatelessWidget {
  final ViatorTour tour;

  const TourLogisticsSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    if (tour.logistics == null) {
      return const SizedBox.shrink();
    }

    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          isArabic
              ? ViatorStringsAr.meetingAndPickup
              : ViatorStringsEn.meetingAndPickup,
        ),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tour.logistics!.redemption != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: AppColor.secondaryblue,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic
                                ? ViatorStringsAr.redemptionResults
                                : ViatorStringsEn.redemptionResults,
                            style: AppTextStyle.setPoppinsSecondaryBlack(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (tour.logistics!.redemption!.specialInstructions !=
                              null)
                            Text(
                              tour.logistics!.redemption!.specialInstructions!,
                              style: AppTextStyle.setPoppinsSecondaryBlack(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 16.h),
              ],
              if (tour.logistics!.travelerPickup != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: AppColor.secondaryblue,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic
                                ? ViatorStringsAr.pickupDetails
                                : ViatorStringsEn.pickupDetails,
                            style: AppTextStyle.setPoppinsSecondaryBlack(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (tour
                                  .logistics!
                                  .travelerPickup!
                                  .allowCustomTravelerPickup ==
                              true)
                            Text(
                              isArabic
                                  ? ViatorStringsAr.customPickupAvailable
                                  : ViatorStringsEn.customPickupAvailable,
                              style: AppTextStyle.setPoppinsSecondaryBlack(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(height: 16.h),
              ],
              if (tour.logistics!.start != null)
                ...tour.logistics!.start!.map(
                  (p) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColor.secondaryblue,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            '${isArabic ? ViatorStringsAr.start : ViatorStringsEn.start}: ${p.description ?? ""}',
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
              if (tour.logistics!.end != null)
                ...tour.logistics!.end!.map(
                  (p) => Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          color: AppColor.secondaryblue,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            '${isArabic ? ViatorStringsAr.end : ViatorStringsEn.end}: ${p.description ?? ""}',
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
