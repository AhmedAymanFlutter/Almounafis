import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/model/city_tour.dart';
import '../../manager/hotel_cubit.dart';
import '../../manager/hotel_state.dart';

Widget buildContent(BuildContext context, HotelState state) { // Added context parameter
  if (state is HotelLoading) {
    return  Center(child: ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 8, // number of shimmer cards
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return  Shimmer(
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
        );
      },
    ));
  }

  if (state is HotelError) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<HotelCubit>().getAllHotels(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  if (state is HotelEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<HotelCubit>().getAllHotels(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  if (state is HotelLoaded) {
    final hotels = state.hotels.data ?? [];
    
    if (hotels.isEmpty) {
      return Center(
        child: Text(
          'No hotels found',
          style: AppTextStyle.setPoppinsSecondaryBlack(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      );
    }
    
    return RefreshIndicator(
      onRefresh: () => context.read<HotelCubit>().refreshHotels(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return _buildHotelCard(hotels[index]);
        },
      ),
    );
  }

  // Handle initial state
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildHotelCard(Data hotel) {
  return Container(
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
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hotel Image
        Padding(
          padding: const EdgeInsets.only(left: 11.0, top: 23.0, bottom: 24.0),
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
        
        // Hotel Details
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Name and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hotel.name ?? 'Hotel Name',
                        style: AppTextStyle.setPoppinsSecondaryBlack(
                          fontSize: 14, 
                          fontWeight: FontWeight.w500
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),                 
                const SizedBox(height: 8),              
                // Address
                Text(
                  hotel.fullAddress ?? 
                  hotel.address ?? 
                  'Address not available',
                  style: AppTextStyle.setPoppinsSecondlightGrey(
                    fontSize: 12, 
                    fontWeight: FontWeight.w400
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),                 
                const SizedBox(height: 12),                
                // Price
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
                              fontWeight: FontWeight.bold
                            )
                          ),
                          TextSpan(
                            text: ' /night',
                            style: AppTextStyle.setPoppinsSecondlightGrey(
                              fontSize: 12, 
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${hotel.starRating ?? 0} Stars',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}