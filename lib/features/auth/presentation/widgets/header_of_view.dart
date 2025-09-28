import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderOfView extends StatelessWidget {
  const HeaderOfView({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.setPoppinsBlack(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
