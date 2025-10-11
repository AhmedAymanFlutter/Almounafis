import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildBookButton(dynamic country) {
  final String countryName = country.name ?? country.nameAr ?? 'Country';

  return InkWell(
    onTap: () async {
      final query = Uri.encodeComponent(countryName);
      final Uri googleMapsUrl =
          Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(
          googleMapsUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('❌ Could not open Google Maps.');
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 12.w),
          Text(
            'Book Now',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16.sp),
        ],
      ),
    ),
  );
}
