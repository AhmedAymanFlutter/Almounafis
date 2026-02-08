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
  Widget build(BuildContext context) {
    if ((includes == null || includes!.isEmpty) &&
        (excludes == null || excludes!.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (includes != null && includes!.isNotEmpty) ...[
          Text(
            isArabic ? 'السعر يشمل' : 'Included',
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.mainBlack,
            ),
          ),
          SizedBox(height: 12.h),
          ...includes!.map((item) => _buildItem(item, true)),
          SizedBox(height: 24.h),
        ],
        if (excludes != null && excludes!.isNotEmpty) ...[
          Text(
            isArabic ? 'السعر لا يشمل' : 'Excluded',
            style: AppTextStyle.setPoppinsTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.mainBlack,
            ),
          ),
          SizedBox(height: 12.h),
          ...excludes!.map((item) => _buildItem(item, false)),
        ],
      ],
    );
  }

  Widget _buildItem(String text, bool isIncluded) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isIncluded ? Icons.check_circle : Icons.cancel,
            color: isIncluded ? Colors.green : Colors.red,
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.setPoppinsTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.secondaryBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
