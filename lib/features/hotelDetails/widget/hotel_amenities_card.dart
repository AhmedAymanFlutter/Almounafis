import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';

import '../../localization/manager/localization_cubit.dart';

class HotelAmenitiesCard extends StatelessWidget {
  final dynamic hotel;

  const HotelAmenitiesCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;
    final amenities = hotel.amenities ?? [];

    if (amenities.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          isArabic ? 'لا توجد خدمات متاحة' : 'No amenities available',
          style: AppTextStyle.setPoppinsSecondaryBlack(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic ? 'الخدمات والمرافق' : 'Amenities',
              style: AppTextStyle.setPoppinsSecondaryBlack(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: amenities.map<Widget>((amenity) {
                final amenityName = amenity.name ?? '';

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.lightPurple.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColor.lightPurple.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getAmenityIcon(amenity.name ?? ''),
                        size: 18,
                        color: AppColor.lightPurple,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        amenityName,
                        style: TextStyle(
                          color: AppColor.lightPurple,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAmenityIcon(String key) {
    switch (key.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'pool':
      case 'swimming_pool':
        return Icons.pool;
      case 'parking':
        return Icons.local_parking;
      case 'restaurant':
        return Icons.restaurant;
      case 'gym':
      case 'fitness':
        return Icons.fitness_center;
      case 'spa':
        return Icons.spa;
      case 'bar':
        return Icons.local_bar;
      case 'room_service':
        return Icons.room_service;
      case 'laundry':
        return Icons.local_laundry_service;
      case 'airport_shuttle':
        return Icons.airport_shuttle;
      case 'business_center':
        return Icons.business_center;
      case 'pets':
      case 'pet_friendly':
        return Icons.pets;
      case 'air_conditioning':
      case 'ac':
        return Icons.ac_unit;
      case 'breakfast':
        return Icons.free_breakfast;
      default:
        return Icons.check_circle_outline;
    }
  }
}
