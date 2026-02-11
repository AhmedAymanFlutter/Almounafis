import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/resources/viator_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourOptionsSection extends StatelessWidget {
  final ViatorTour tour;

  const TourOptionsSection({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    if (tour.productOptions == null || tour.productOptions!.isEmpty) {
      return const SizedBox.shrink();
    }

    final isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          isArabic
              ? ViatorStringsAr.productOptions
              : ViatorStringsEn.productOptions,
        ),
        Column(
          children: tour.productOptions!
              .map(
                (option) => Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.lightGrey.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title ?? '',
                        style: AppTextStyle.setPoppinsBlack(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      HtmlContentWidget(
                        htmlContent: option.description ?? '',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        textColor: AppColor.secondaryBlack,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
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
