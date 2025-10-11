import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/packadge/data/model/package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageCardView extends StatelessWidget {
  final Data package;
  final VoidCallback onTap;

  const PackageCardView({
    super.key,
    required this.package,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 421.w,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColor.mainWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.secondaryGrey,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🖼️ Image (styled like Figma)
          Container(
            width: 420.w,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                children: [
                  Image.network(
                    package.imageCover ?? '',
                    width: 420.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 420.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),

                  /// Overlay gradient for readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),

                  /// Category tag (top-left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "Travel",
                        style: AppTextStyle.setPoppinsTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondaryBlack,
                        ),
                      ),
                    ),
                  ),

                  /// Rating (top-right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text("4.5", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),

                  /// Text on image (bottom)
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.name ?? 'Package',
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mainWhite,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          package.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.setPoppinsTextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColor.mainWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 📦 Button below image
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Center(
              child: OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(114.w, 28.h),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                  side: const BorderSide(color: Color(0XFF1D8DEF), width: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  foregroundColor: const Color(0XFF1D8DEF),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  "Package Details",
                  style: AppTextStyle.setPoppinsTextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0XFF1D8DEF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
