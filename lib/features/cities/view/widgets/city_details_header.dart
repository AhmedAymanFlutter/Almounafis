import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CityDetailsHeader extends StatelessWidget {
  final CityDetails city;

  const CityDetailsHeader({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500.h,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: const BackButton(color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Hero Image
              if (city.images?.isNotEmpty == true)
                Image.network(
                  city.images!.first.url ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),

              // Gradient Overlay
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black12,
                      Colors.transparent,
                      Colors.black54,
                      Colors.black87,
                    ],
                    stops: [0.0, 0.4, 0.8, 1.0],
                  ),
                ),
              ),

              // Content Overlay
              Positioned(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // City & Country Name
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city.name ?? "",
                            style: AppTextStyle.setPoppinsWhite(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (city.country != null)
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 16,
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    city.country?.name ?? "",
                                    style: AppTextStyle.setPoppinsWhite(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Weather Widget
                    if (city.weather != null)
                      WeatherWidget(
                        weather: city.weather,
                        bestTime: city.bestTimeToVisit,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
