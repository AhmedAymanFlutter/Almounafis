import 'package:almonafs_flutter/core/helper/text_helper.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: AppColor.lightGrey),
      ),
      color: AppColor.primaryWhite,
      child: ListTile(
        leading: CircleAvatar(
          radius: 28.r,
          backgroundImage: AssetImage("assets/images/download.png"),
        ),
        title: Text(
          TextHelper.yourPhoto,
          style: AppTextStyle.setPoppinsSecondaryBlack(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          TextHelper.addPhoto,
          style: AppTextStyle.setPoppinsSecondlightGrey(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
