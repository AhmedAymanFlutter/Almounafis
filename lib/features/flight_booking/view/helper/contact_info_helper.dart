import 'package:almonafs_flutter/features/flight_booking/data/model/Flight_Booking_Request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flightScreen/data/model/AirLine_data.dart';
import '../../manager/flight_booking_cubit.dart';
import '../../manager/flight_booking_state.dart';


class ContactInfoHelper {
  static void handleBookingState(BuildContext context, FlightBookingState state) {
    if (state is FlightBookingSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال الحجز بنجاح ✅'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (state is FlightBookingError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static void submitBooking({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required FlightBookingRequest bookingRequest,
    required AirLineData? selectedAirline,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController whatsappController,
    required String countryCode,
  }) {
    if (!(formKey.currentState?.validate() ?? false)) return;

    final updatedRequest = FlightBookingRequest(
      origin: bookingRequest.origin,
      destination: bookingRequest.destination,
      tripType: bookingRequest.tripType,
      departureDate: bookingRequest.departureDate,
      returnDate: bookingRequest.returnDate,
      adults: bookingRequest.adults,
      children: bookingRequest.children,
      infants: bookingRequest.infants,
      travelClass: bookingRequest.travelClass,
      airlinePreference: selectedAirline?.sId ?? selectedAirline?.id,
      bookingMethod: 'form',
      contactInfo: {
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "countryCode": countryCode,
        "whatsapp": whatsappController.text.trim(),
      },
    );

    debugPrint('📤 Booking Request: ${updatedRequest.toJson()}');
    context.read<FlightBookingCubit>().submitBooking(updatedRequest);
  }
}
