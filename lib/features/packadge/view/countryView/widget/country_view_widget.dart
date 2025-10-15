import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../localization/manager/localization_cubit.dart';

class CountryCard extends StatelessWidget {
  final String countryName;
  final String countryId;
  final String countryImage;
  final VoidCallback onTap;

  const CountryCard({
    super.key,
    required this.countryName,
    required this.countryId,
    required this.countryImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
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
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            /// 🖼️ Image
            Container(
              width: 500.w,
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
                    /// Background Image
                    Image.network(
                      countryImage,
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
                        child: const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
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

                    /// Location Tag (RTL / LTR)
                    Positioned(
                      top: 10,
                      left: isArabic ? null : 10,
                      right: isArabic ? 10 : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          textDirection:
                              isArabic ? TextDirection.rtl : TextDirection.ltr,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 12,
                              color: AppColor.secondaryBlack,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              isArabic ? "وجهة" : "Destination",
                              style: AppTextStyle.setPoppinsTextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.secondaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Rating (Top corner)
                    Positioned(
                      top: 10,
                      right: isArabic ? null : 10,
                      left: isArabic ? 10 : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 14),
                            SizedBox(width: 4.w),
                            Text(
                              "4.8",
                              style: AppTextStyle.setPoppinsTextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColor.secondaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Country Name & Description
                    Positioned(
                      left: isArabic ? null : 16.w,
                      right: isArabic ? 16.w : null,
                      bottom: 16.h,
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            countryName,
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.mainWhite,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            isArabic
                                ? "اكتشف الباقات الرائعة في هذه الدولة"
                                : "Explore amazing packages in this country",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.setPoppinsTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: AppColor.mainWhite,
                            ),
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                    side: const BorderSide(
                      color: Color(0XFF1D8DEF),
                      width: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    foregroundColor: const Color(0XFF1D8DEF),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    isArabic ? "عرض الباقات" : "View Packages",
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
      ),
    );
  }
}
