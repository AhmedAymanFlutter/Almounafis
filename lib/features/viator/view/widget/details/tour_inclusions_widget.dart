import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourInclusionsWidget extends StatelessWidget {
  final List<Inclusion> inclusions;

  const TourInclusionsWidget({super.key, required this.inclusions});

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
        children: inclusions.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, size: 20.sp, color: Colors.green),
                SizedBox(width: 12.w),
                Expanded(
                  child: HtmlContentWidget(
                    htmlContent:
                        item.otherDescription ?? item.description ?? '<p></p>',
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
