import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InclusionsWidget extends StatelessWidget {
  final List<String>? includes;
  final List<String>? excludes;
  final bool isArabic;

  const InclusionsWidget({
    super.key,
    this.includes,
    this.excludes,
    required this.isArabic,
  });

  @override
  @override
  Widget build(BuildContext context) {
    if ((includes == null || includes!.isEmpty) &&
        (excludes == null || excludes!.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includes != null && includes!.isNotEmpty)
          _buildTable(
            context,
            title: isArabic ? 'السعر يشمل' : 'Included',
            items: includes!,
            isIncluded: true,
          ),

        if (includes != null &&
            includes!.isNotEmpty &&
            excludes != null &&
            excludes!.isNotEmpty)
          SizedBox(height: 24.h),

        if (excludes != null && excludes!.isNotEmpty)
          _buildTable(
            context,
            title: isArabic ? 'السعر لا يشمل' : 'Excluded',
            items: excludes!,
            isIncluded: false,
          ),
      ],
    );
  }

  Widget _buildTable(
    BuildContext context, {
    required String title,
    required List<String> items,
    required bool isIncluded,
  }) {
    final themeColor = isIncluded ? Colors.green : Colors.red;
    final headerColor = themeColor.withOpacity(0.1);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isIncluded ? Icons.check_circle_outline : Icons.highlight_off,
                  color: themeColor,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: themeColor,
                  ),
                ),
              ],
            ),
          ),
          // Table Body
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == items.length - 1;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                        bottom: BorderSide(
                          color: AppColor.lightGrey.withOpacity(0.1),
                        ),
                      ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: AppColor.secondaryBlack.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyle.setPoppinsTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.secondaryBlack,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
