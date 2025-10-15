import 'package:almonafs_flutter/core/helper/Fun_helper.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:almonafs_flutter/core/theme/app_color.dart';

import '../../hotels/manager/hotel_cubit.dart';
import '../../hotels/manager/hotel_state.dart';
import '../../localization/manager/localization_cubit.dart';
import '../widget/hotel_amenities_card.dart';
import '../widget/hotel_contact_card.dart';
import '../widget/hotel_description_card.dart';
import '../widget/hotel_header.dart';
import '../widget/hotel_info_card.dart';
import '../widget/hotel_price_card.dart';
import '../widget/hotel_rooms_card.dart';

class HotelDetailsScreen extends StatefulWidget {
  final String hotelId;

  const HotelDetailsScreen({super.key, required this.hotelId});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the API call slightly to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HotelCubit>().getHotelDetails(widget.hotelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelDetailsLoading) {
            return _buildLoadingState();
          }

          if (state is HotelDetailsError) {
            return _buildErrorState(context, state.message);
          }

          if (state is HotelDetailsLoaded) {
            final hotel = state.hotelDetails;
            return _buildHotelDetailsContent(context, hotel);
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelDetailsLoaded) {
            return buildBookButton();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.lightPurple),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Colors.red,
            ),
            SizedBox(height: 16.h),
            Text(
              isArabic ? 'خطأ في تحميل البيانات' : 'Error Loading Data',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<HotelCubit>().getHotelDetails(widget.hotelId),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.lightPurple,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                isArabic ? 'إعادة المحاولة' : 'Try Again',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHotelDetailsContent(BuildContext context, dynamic hotel) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Hotel Header with Images
        SliverToBoxAdapter(
          child: HotelHeader(
            hotel: hotel,
            images: hotel.images ?? [],
          ),
        ),

        // Hotel Details Content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Hotel Basic Info
                HotelInfoCard(hotel: hotel),
                SizedBox(height: 16.h),

                // Price Range
                HotelPriceCard(hotel: hotel),
                SizedBox(height: 16.h),

                // Description
                HotelDescriptionCard(hotel: hotel),
                SizedBox(height: 16.h),

                // Amenities
                if (hotel.amenities?.isNotEmpty ?? false) ...[
                  HotelAmenitiesCard(hotel: hotel),
                  SizedBox(height: 16.h),
                ],

                // Contact Information
                HotelContactCard(hotel: hotel),
                SizedBox(height: 16.h),

                // Room Types
                if (hotel.roomTypes?.isNotEmpty ?? false) ...[
                  HotelRoomsCard(hotel: hotel),
                  SizedBox(height: 16.h),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBookButton() {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
         final globalSettingsState = context.read<GlobalSettingsCubit>().state;

if (globalSettingsState is GlobalSettingsLoaded) {
  WhatsAppService.launchWhatsApp(
    context,
    isArabic: isArabic,
    settings: globalSettingsState.globalSettings,
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isArabic 
          ? "جاري تحميل الإعدادات..." 
          : "Loading settings..."
      ),
    ),
  );
}
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.mainBlack,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          isArabic ? 'احجز الآن' : 'Book Now',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}