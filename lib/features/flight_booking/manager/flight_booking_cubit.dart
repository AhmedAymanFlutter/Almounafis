

import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/features/flight_booking/manager/flight_booking_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/Flight_Booking_Request.dart';
import '../data/repo/Flight_Booking_Repo.dart';

class FlightBookingCubit extends Cubit<FlightBookingState> {
  final FlightBookingRepository repository;

  FlightBookingCubit(this.repository) : super(const FlightBookingInitial());

  Future<void> submitBooking(FlightBookingRequest request) async {
  emit(FlightBookingLoading());
  try {
    print('🚀 FlightBookingCubit: Starting submission...');
    print('📤 Request data: ${request.toJson()}');
    
    final ApiResponse response = await repository.submitBooking(request);
    
    if (response.status) {
      print('✅ Booking successful');
      
      // Extract booking reference from response if available
      String bookingRef = '';
      if (response.data is Map && response.data['bookingReference'] != null) {
        bookingRef = response.data['bookingReference'];
      }
      
      emit(FlightBookingSuccess(
        bookingReference: bookingRef,
        message: response.message,
      ));
    } else {
      print('❌ Booking failed: ${response.message}');
      emit(FlightBookingError(message: response.message));
    }
  } catch (e) {
    print('❌ Cubit Error: $e');
    emit(FlightBookingError(message: 'حدث خطأ أثناء الحجز: $e'));
  }
}
}