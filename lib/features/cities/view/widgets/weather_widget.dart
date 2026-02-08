import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherWidget extends StatelessWidget {
  final Weather? weather;
  final BestTimeToVisit? bestTime;

  const WeatherWidget({
    super.key,
    required this.weather,
    required this.bestTime,
  });

  @override
  Widget build(BuildContext context) {
    if (weather == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2), // Glassmorphism
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Temperature and Condition
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${weather?.currentTemp?.toStringAsFixed(0) ?? '--'}°C",
                style: AppTextStyle.setPoppinsWhite(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.thermostat, color: Colors.white, size: 24),
            ],
          ),
          Text(
            weather?.condition ?? "Clear",
            style: AppTextStyle.setPoppinsWhite(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 12.h),
          Divider(color: Colors.white24, height: 1),
          SizedBox(height: 12.h),

          // Details: Wind & Humidity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherDetail(
                Icons.air,
                "${weather?.windSpeed ?? '-'} km/h",
                "Wind",
              ),
              _buildWeatherDetail(
                Icons.water_drop_outlined,
                "${weather?.humidity ?? '-'}%",
                "Humidity",
              ),
            ],
          ),

          if (bestTime?.months?.isNotEmpty == true) ...[
            SizedBox(height: 12.h),
            Divider(color: Colors.white24, height: 1),
            SizedBox(height: 12.h),
            Text(
              "Best time to visit",
              style: AppTextStyle.setPoppinsWhite(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: bestTime!.months!.take(4).map((month) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    month,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            SizedBox(width: 4.w),
            Text(
              value,
              style: AppTextStyle.setPoppinsWhite(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 10.sp),
        ),
      ],
    );
  }
}
