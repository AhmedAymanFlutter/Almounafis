import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/home/presentation/views/see_All_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GuidedTourCard extends StatelessWidget {
  final String title, location, imageUrl, tag;

  const GuidedTourCard({
    super.key,
    required this.title,
    required this.location, 
    required this.imageUrl,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SeeAllPage()),
                (route) => false,
              );                
      },
      child: Container(
        width:240,
        height: 277,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey, width: 1), // إطار خفيف
          color: AppColor.primaryWhite, // لون الخلفية أبيض
          borderRadius: BorderRadius.circular(20), // حواف مستديرة أصغر قليلاً
          boxShadow: [
            BoxShadow(
              color: AppColor.lightGrey.withOpacity(0.3), // ظل خفيف
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. حاوية الصورة
            ClipRRect(
              borderRadius:  BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                height:150,
                width: 240, 
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 277,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          SizedBox(height: 4),
                          Text(
                            'Failed to load image',
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // 2. منطقة المعلومات
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                               
                  // العنوان
                  Text(
                    title,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // الموقع
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColor.secondaryBlack, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            location,
                            style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 10, fontWeight: FontWeight.w300),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                                            
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}