import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';

import '../../localization/manager/localization_cubit.dart';
import 'contact_row.dart';

class HotelContactCard extends StatelessWidget {
  final dynamic hotel;

  const HotelContactCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    final phone = hotel.phone?.toString() ?? '';
    final email = hotel.email?.toString() ?? '';
    final website = hotel.website?.toString() ?? '';

    final hasContactInfo =
        phone.isNotEmpty || email.isNotEmpty || website.isNotEmpty;

    if (!hasContactInfo) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          isArabic
              ? 'لا توجد معلومات تواصل متاحة'
              : 'No contact information available',
          style: AppTextStyle.setPoppinsSecondaryBlack(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

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
              isArabic ? 'معلومات التواصل' : 'Contact Information',
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            if (phone.isNotEmpty)
              ContactRow(
                icon: Icons.phone,
                text: phone,
              ),

            if (email.isNotEmpty)
              ContactRow(
                icon: Icons.email_outlined,
                text: email,
              ),

            if (website.isNotEmpty)
              ContactRow(
                icon: Icons.language,
                text: website,
              ),
          ],
        ),
      ),
    );
  }
}
