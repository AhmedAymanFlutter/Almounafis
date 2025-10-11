import 'package:flutter/material.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/manager/localization_cubit.dart';

class HotelRoomsCard extends StatelessWidget {
  final dynamic hotel;

  const HotelRoomsCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;
    final roomTypes = hotel.roomTypes ?? [];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? 'أنواع الغرف' : 'Room Types',
                  style: AppTextStyle.setPoppinsSecondaryBlack(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Room count badge
                if (roomTypes.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.blue[100]!),
                    ),
                    child: Text(
                      isArabic ? '${roomTypes.length} نوع' : '${roomTypes.length} types',
                      style: AppTextStyle.setPoppinsDeepPurple(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(height: 12.h),
            
            // Rooms List or Empty State
            if (roomTypes.isEmpty)
              _buildEmptyState(isArabic)
            else
              ...roomTypes.map<Widget>((room) => _buildRoomItem(context, room, isArabic)),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomItem(BuildContext context, dynamic room, bool isArabic) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Name and Capacity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _getLocalizedRoomName(room, isArabic),
                    style: AppTextStyle.setPoppinsSecondaryBlack(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                ),
                if (room.capacity != null) ...[
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.green[100]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 12.sp, color: Colors.green[600]),
                        SizedBox(width: 2.w),
                        Text(
                          '${room.capacity}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[700],
                          ),
                        ),
                        if (room.capacity! > 1) ...[
                          SizedBox(width: 2.w),
                          Text(
                            isArabic ? 'أشخاص' : 'people',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green[600],
                            ),
                          ),
                        ] else ...[
                          SizedBox(width: 2.w),
                          Text(
                            isArabic ? 'شخص' : 'person',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),

            // Room Description
            if (_hasRoomDescription(room, isArabic)) ...[
              SizedBox(height: 6.h),
              Text(
                _getLocalizedRoomDescription(room, isArabic),
                style: AppTextStyle.setPoppinsSecondlightGrey(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Room Features (if available)
            if (_hasRoomFeatures(room)) ...[
              SizedBox(height: 8.h),
              _buildRoomFeatures(room, isArabic),
            ],

            // Room Price (if available)
            if (_hasRoomPrice(room)) ...[
              SizedBox(height: 8.h),
              _buildRoomPrice(context, room, isArabic),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Icon(Icons.hotel, size: 40.sp, color: Colors.grey[400]),
          SizedBox(height: 8.h),
          Text(
            isArabic ? 'لا توجد غرف متاحة' : 'No rooms available',
            style: AppTextStyle.setPoppinsSecondlightGrey(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            isArabic ? 'سيتم إضافة الغرف قريباً' : 'Rooms will be added soon',
            style: AppTextStyle.setPoppinsSecondlightGrey(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRoomFeatures(dynamic room, bool isArabic) {
    final features = room.features ?? room.amenities ?? [];
    if (features.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: features.take(3).map<Widget>((feature) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            _getLocalizedFeature(feature, isArabic),
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRoomPrice(BuildContext context, dynamic room, bool isArabic) {
    final price = room.price ?? room.rate;
    final currency = room.currency ?? 'USD';
    final currencySymbol = _getCurrencySymbol(currency);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isArabic ? 'السعر:' : 'Price:',
          style: AppTextStyle.setPoppinsSecondlightGrey(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$currencySymbol${_safeToDouble(price).toStringAsFixed(2)}',
          style: AppTextStyle.setPoppinsDeepPurple(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Helper methods
  String _getLocalizedRoomName(dynamic room, bool isArabic) {
    if (room.nameAr != null && isArabic && room.nameAr!.isNotEmpty) {
      return room.nameAr!;
    } else if (room.name != null && room.name!.isNotEmpty) {
      return room.name!;
    } else if (room.typeAr != null && isArabic && room.typeAr!.isNotEmpty) {
      return room.typeAr!;
    } else if (room.type != null && room.type!.isNotEmpty) {
      return room.type!;
    }
    return isArabic ? 'نوع الغرفة' : 'Room Type';
  }

  bool _hasRoomDescription(dynamic room, bool isArabic) {
    return (room.descriptionAr != null && room.descriptionAr!.isNotEmpty && isArabic) ||
           (room.description != null && room.description!.isNotEmpty);
  }

  String _getLocalizedRoomDescription(dynamic room, bool isArabic) {
    if (room.descriptionAr != null && isArabic && room.descriptionAr!.isNotEmpty) {
      return room.descriptionAr!;
    }
    return room.description ?? '';
  }

  bool _hasRoomFeatures(dynamic room) {
    final features = room.features ?? room.amenities ?? [];
    return features.isNotEmpty;
  }

  String _getLocalizedFeature(dynamic feature, bool isArabic) {
    if (feature is String) {
      // Simple feature string
      return feature;
    } else if (feature is Map) {
      // Feature with localization
      if (isArabic && feature['ar'] != null) {
        return feature['ar'];
      }
      return feature['en'] ?? feature['name'] ?? 'Feature';
    }
    return 'Feature';
  }

  bool _hasRoomPrice(dynamic room) {
    return room.price != null || room.rate != null;
  }

  double _safeToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'USD': return '\$';
      case 'EUR': return '€';
      case 'GBP': return '£';
      case 'SAR': return 'ر.س';
      case 'AED': return 'د.إ';
      case 'EGP': return 'ج.م';
      default: return '\$';
    }
  }
}