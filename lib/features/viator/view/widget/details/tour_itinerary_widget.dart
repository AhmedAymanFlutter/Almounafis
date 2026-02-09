import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/core/widgets/html_content_widget.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TourItineraryWidget extends StatelessWidget {
  final Itinerary itinerary;

  const TourItineraryWidget({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    if (itinerary.itineraryItems == null || itinerary.itineraryItems!.isEmpty) {
      return const SizedBox();
    }
    return Column(
      children: itinerary.itineraryItems!.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == itinerary.itineraryItems!.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: const BoxDecoration(
                    color: AppColor.mainColor, // lightBlue
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 60.h,
                    color: AppColor.lightGrey.withOpacity(0.5),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HtmlContentWidget(
                      htmlContent: item.description ?? '<p></p>',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.secondaryBlack,
                    ),
                    if (item.duration != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Duration: ${item.duration!.fixedDurationInMinutes} mins',
                        style: AppTextStyle.setPoppinssecondaryGery(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
