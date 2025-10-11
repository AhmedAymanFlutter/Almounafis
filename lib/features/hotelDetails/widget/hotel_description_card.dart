import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import '../../localization/manager/localization_cubit.dart';

class HotelDescriptionCard extends StatelessWidget {
  final dynamic hotel;

  const HotelDescriptionCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    // اختيار الوصف المناسب (عربي أو إنجليزي)
    final String description = hotel.descriptionFlutter ??
        hotel.descriptionArFlutter ??
        (isArabic ? 'لا يوجد وصف متاح حالياً' : 'No description available');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic ? 'الوصف' : 'Description',
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description.trim(),
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                 
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
