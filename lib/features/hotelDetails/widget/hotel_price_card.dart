import 'package:flutter/material.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/manager/localization_cubit.dart';

class HotelPriceCard extends StatelessWidget {
  final dynamic hotel;

  const HotelPriceCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    // Safe type conversion from int to double
    final minPrice = _safeToDouble(hotel.priceRange?.min);
    final maxPrice = _safeToDouble(hotel.priceRange?.max);
    final isSinglePrice = minPrice == maxPrice || maxPrice == 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Price Label
            Text(
              isArabic ? 'نطاق السعر' : 'Price Range',
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Price Range
            RichText(
              text: TextSpan(
                children: [
                  if (isSinglePrice) ..._buildSinglePrice(minPrice, isArabic)
                  else ..._buildPriceRange(minPrice, maxPrice, isArabic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Safe conversion from dynamic to double
  double _safeToDouble(dynamic value) {
    if (value == null) return 0.0;
    
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  List<TextSpan> _buildSinglePrice(double price, bool isArabic) {
    return [
      TextSpan(
        text: '\$${price.toStringAsFixed(price == price.truncate() ? 0 : 2)}',
        style: AppTextStyle.setPoppinsDeepPurple(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      TextSpan(
        text: isArabic ? ' /ليلة' : ' /night',
        style: AppTextStyle.setPoppinsSecondlightGrey(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];
  }

  List<TextSpan> _buildPriceRange(double minPrice, double maxPrice, bool isArabic) {
    final minFormatted = minPrice.toStringAsFixed(minPrice == minPrice.truncate() ? 0 : 2);
    final maxFormatted = maxPrice.toStringAsFixed(maxPrice == maxPrice.truncate() ? 0 : 2);

    if (isArabic) {
      // Arabic: show higher price first
      return [
        TextSpan(
          text: '\$$maxFormatted',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: ' - ',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: '\$$minFormatted',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: ' /ليلة',
          style: AppTextStyle.setPoppinsSecondlightGrey(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ];
    } else {
      // English: show lower price first
      return [
        TextSpan(
          text: '\$$minFormatted',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: ' - ',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: '\$$maxFormatted',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextSpan(
          text: ' /night',
          style: AppTextStyle.setPoppinsSecondlightGrey(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ];
    }
  }
}