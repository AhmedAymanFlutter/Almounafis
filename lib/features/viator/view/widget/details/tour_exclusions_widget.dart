import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourExclusionsWidget extends StatelessWidget {
  final List<Exclusion> exclusions;

  const TourExclusionsWidget({super.key, required this.exclusions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.lightGrey.withOpacity(0.3)),
      ),
      child: Column(
        children: exclusions.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.close, size: 20.sp, color: Colors.redAccent),
                SizedBox(width: 12.w),
                Expanded(
                  child: HtmlContentWidget(
                    htmlContent: item.description ?? '<p></p>',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: AppColor.secondaryBlack,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
