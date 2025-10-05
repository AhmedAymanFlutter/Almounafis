import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_style.dart' show AppTextStyle;

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onTap,
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.secondaryBlack,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}
