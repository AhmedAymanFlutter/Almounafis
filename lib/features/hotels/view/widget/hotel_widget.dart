import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../config/router/routes.dart';
import '../../../hotelDetails/view/HotelDetailsScreen.dart';
import '../../data/model/city_tour.dart';
import '../../manager/hotel_cubit.dart';
import '../../manager/hotel_state.dart';
import '../../../localization/manager/localization_cubit.dart';

Widget buildContent(BuildContext context, HotelState state) {
  final isArabic = context.watch<LanguageCubit>().isArabic;

  // ✅ حالة التحميل
  if (state is HotelLoading) {
    return Center(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer(
              color: Colors.grey.shade400,
              colorOpacity: 0.3,
              enabled: true,
              child: Container(
                width: 370,
                height: 87,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ حالة الخطأ
  if (state is HotelError) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<HotelCubit>().getAllHotels(),
            child: Text(isArabic ? 'إعادة المحاولة' : 'Retry'),
          ),
        ],
      ),
    );
  }

  // ✅ حالة عدم وجود بيانات
  if (state is HotelEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isArabic ? 'لا توجد فنادق متاحة' : state.message,
            style: AppTextStyle.setPoppinsSecondaryBlack(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<HotelCubit>().getAllHotels(),
            child: Text(isArabic ? 'أعد المحاولة' : 'Try Again'),
          ),
        ],
      ),
    );
  }

  // ✅ حالة النتائج بعد الفلترة (البحث)
  if (state is HotelFiltered) {
    final hotels = state.filteredHotels;

    if (hotels.isEmpty) {
      return Center(
        child: Text(
          isArabic ? 'لم يتم العثور على فنادق' : 'No hotels found',
          style: AppTextStyle.setPoppinsSecondaryBlack(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hotels.length,
      itemBuilder: (context, index) {
        return _buildHotelCard(context, hotels[index], isArabic);
      },
    );
  }

  // ✅ الحالة العادية (عرض كل الفنادق)
  if (state is HotelLoaded) {
    final hotels = state.hotels.data ?? [];

    if (hotels.isEmpty) {
      return Center(
        child: Text(
          isArabic ? 'لا توجد فنادق متاحة حالياً' : 'No hotels found',
          style: AppTextStyle.setPoppinsSecondaryBlack(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<HotelCubit>().refreshHotels(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return _buildHotelCard(context, hotels[index], isArabic);
        },
      ),
    );
  }

  return const Center(child: CircularProgressIndicator());
}

Widget _buildHotelCard(BuildContext context, Data hotel, bool isArabic) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelDetailsScreen(
            hotelId: hotel.id ?? hotel.sId ?? '',
          ),
        ),
      );
    },
    child: Container(
      width: 384,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x66000000),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.hotelDetails,
              arguments: {
                'hotelId': hotel.id ?? hotel.sId ?? '',
              },
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 11.0, top: 23.0, bottom: 24.0, right: 11),
                child: Container(
                  width: 81,
                  height: 77,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        hotel.images != null && hotel.images!.isNotEmpty
                            ? hotel.images!.first
                            : 'https://via.placeholder.com/100x120',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الاسم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              isArabic
                                  ? (hotel.nameAr ?? hotel.name ?? 'اسم الفندق')
                                  : (hotel.name ?? 'Hotel Name'),
                              style: AppTextStyle.setPoppinsSecondaryBlack(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // العنوان
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              hotel.fullAddress ??
                                  hotel.address ??
                                  (isArabic
                                      ? 'العنوان غير متاح'
                                      : 'Address not available'),
                              style: AppTextStyle.setPoppinsSecondlightGrey(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // السعر والتقييم
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$${hotel.priceRange?.min ?? 0}',
                                  style: AppTextStyle.setPoppinsDeepPurple(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: isArabic ? ' /الليلة' : ' /night',
                                  style: AppTextStyle.setPoppinsSecondlightGrey(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.amber[700], size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${hotel.starRating ?? 0}',
                                style: TextStyle(
                                  color: Colors.amber[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
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
