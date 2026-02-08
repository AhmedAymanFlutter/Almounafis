import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_style.dart';

class CityInfoSection extends StatelessWidget {
  final CityDetails city;

  const CityInfoSection({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description Section
        Text(
          "About ${city.name}",
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          city.descriptionFlutter ??
              city.description?.replaceAll(RegExp(r'<[^>]*>'), '') ??
              "Discover the beauty of ${city.name}.",
          style: AppTextStyle.setPoppinsTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
