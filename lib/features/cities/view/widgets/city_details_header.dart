import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CityDetailsHeader extends StatelessWidget {
  final CityDetails city;

  const CityDetailsHeader({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const BackButton(color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          city.name ?? "",
          style: AppTextStyle.setPoppinsWhite(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        background: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                // Gradient Overlay for Text Readability
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                      stops: [0.6, 1.0],
                    ),
                  ),
                ),
                // Weather Widget Overlay
                if (city.weather != null)
                  Positioned(
                    bottom: 60,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2), // Glassmorphism
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.wb_sunny_rounded,
                            color: Colors.orangeAccent,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${city.weather?.currentTemp ?? '?'}°C",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            city.weather?.condition ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
