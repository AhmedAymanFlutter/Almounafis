import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';

class ModernHomeAppBar extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onMenuTap;
  final VoidCallback onNotificationTap;

  const ModernHomeAppBar({
    super.key,
    required this.isArabic,
    required this.onMenuTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Button with Glassmorphism
          _buildGlassIconButton(icon: Icons.menu, onTap: onMenuTap),

          Column(
            children: [
              Text(
                isArabic ? 'الموقع الحالي' : 'Current Location',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColor.secondaryblue,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    isArabic
                        ? 'الرياض, السعودية'
                        : 'Riyadh, Saudi Arabia', // Placeholder
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Notification Button
          _buildGlassIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationTap,
            hasBadge: true,
          ),
        ],
      ),
    );
  }

  Widget _buildGlassIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.black87, size: 24.sp),
            if (hasBadge)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
