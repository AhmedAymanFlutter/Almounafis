import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_style.dart';


class CardLangWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final double? iconWidth;
  final double? iconHeight;

  const CardLangWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.iconColor,
    this.iconWidth = 24, // Default width
    this.iconHeight = 24, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 15, 25, 13),
        child: Container(
            margin: const EdgeInsets.only(top: 256, left: 30),

          width: 370,
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.lightGrey, width: 1),
            color: color ?? Colors.white,
          ),
          child: Row(
            children: [
            
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              //   SvgPicture.asset(
              //   iconPath,
              //   width: iconWidth,
              //   height: iconHeight,
              //   colorFilter: iconColor != null
              //       ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              //       : null,
              // ),
              
            ],
          ),
        ),
      ),
    );
  }
}