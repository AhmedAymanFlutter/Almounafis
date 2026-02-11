import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourHeaderSection extends StatelessWidget {
  final ViatorTour tour;

  const TourHeaderSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tour.title ?? '',
          style: AppTextStyle.setPoppinsBlack(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 22.sp),
            SizedBox(width: 6.w),
            Text(
              '${tour.rating?.average ?? 0}',
              style: AppTextStyle.setPoppinsBlack(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' (${tour.rating?.count ?? 0} ${isArabic ? ViatorStringsAr.reviews : ViatorStringsEn.reviews})',
              style: AppTextStyle.setPoppinssecondaryGery(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        if (tour.tags != null && tour.tags!.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: tour.tags!
                .map(
                  (tag) => Chip(
                    label: Text(
                      tag.name ?? '',
                      style: AppTextStyle.setPoppinsSecondaryBlack(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    backgroundColor: AppColor.lightGrey.withOpacity(0.1),
                    side: BorderSide.none,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
                .toList(),
          ),
        ],
        if (tour.supplier != null) ...[
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.business, color: AppColor.secondaryblue, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                '${isArabic ? ViatorStringsAr.supplier : ViatorStringsEn.supplier}: ${tour.supplier!.name}',
                style: AppTextStyle.setPoppinsBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }
}
