import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_text_style.dart' show AppTextStyle;

class MenuItemWidget extends StatelessWidget {
  final String iconPath; // Changed from IconData to String for SVG path
  final String title;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final double? iconWidth;
  final double? iconHeight;

  const MenuItemWidget({
    super.key,
    required this.iconPath,
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
        padding: const EdgeInsets.fromLTRB(19, 13, 19, 13),
        child: Container(
          width: 370,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.lightGrey, width: 1),
            color: color ?? Colors.white,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: iconWidth,
                height: iconHeight,
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
              const SizedBox(width: 16),
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
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}