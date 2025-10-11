import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import '../../localization/manager/localization_cubit.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final double? iconSize;

  const ContactRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: iconSize ?? 18,
              color: iconColor ?? Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: AppTextStyle.setPoppinsSecondaryBlack(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
