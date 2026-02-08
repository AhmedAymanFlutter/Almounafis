import 'package:almonafs_flutter/features/flightScreen/data/model/AirLine_data.dart';
import 'package:almonafs_flutter/features/flightScreen/manager/AirLine_cubit.dart';
import 'package:almonafs_flutter/features/flight_booking/data/repo/Flight_Booking_Repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../flight_booking/data/model/Flight_Booking_Request.dart';
import '../../../flight_booking/manager/flight_booking_cubit.dart';
import '../../../flight_booking/view/Contact_Info_View.dart';
import '../../manager/Airine_state.dart';

class BookingHelper {
  static void handleSearchButtonPress(
    BuildContext context,
    bool isArabic, {
    required String fromCity,
    required String toCity,
    required TextEditingController departureDateController,
    required TextEditingController returnDateController,
    required bool isRoundTrip,
    required int adultsCount,
    required int childrenCount,
    required int infantsCount,
    required String? selectedClass,
    required String? selectedAirlineId,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController whatsappController,
  }) {
    // ✅ Validation checks
    if (fromCity.trim().isEmpty) {
      _showError(
        context,
        isArabic
            ? 'الرجاء إدخال مدينة المغادرة'
            : 'Please enter departure city',
      );
      return;
    }
    if (toCity.trim().isEmpty) {
      _showError(
        context,
        isArabic
            ? 'الرجاء إدخال مدينة الوصول'
            : 'Please enter destination city',
      );
      return;
    }
    if (departureDateController.text.isEmpty) {
      _showError(
        context,
        isArabic
            ? 'الرجاء اختيار تاريخ المغادرة'
            : 'Please select departure date',
      );
      return;
    }
    if (isRoundTrip && returnDateController.text.isEmpty) {
      _showError(
        context,
        isArabic ? 'الرجاء اختيار تاريخ العودة' : 'Please select return date',
      );
      return;
    }

    // ✅ Build request
    final bookingRequest = FlightBookingRequest(
      origin: fromCity.trim(),
      destination: toCity.trim(),
      tripType: isRoundTrip ? 'round-trip' : 'one-way',
      departureDate: departureDateController.text,
      returnDate: isRoundTrip ? returnDateController.text : null,
      adults: adultsCount,
      children: childrenCount,
      infants: infantsCount,
      travelClass: selectedClass ?? 'economy',
      airlinePreference: selectedAirlineId,
      contactInfo: {
        "email": emailController.text,
        "phone": phoneController.text,
        "countryCode": "+20",
        "whatsapp": whatsappController.text,
      },
      bookingMethod: "form",
    );

    // ✅ Fetch selected airline
    final selectedAirlineData = _getAirlineById(context, selectedAirlineId);

    // ✅ Navigate to Contact Info view
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => FlightBookingCubit(FlightBookingRepositoryImpl()),
          child: ContactInfoView(
            bookingRequest: bookingRequest,
            selectedAirline: selectedAirlineData,
            fromCity: fromCity,
            toCity: toCity,
          ),
        ),
      ),
    );
  }

  // 🔹 Helper to find airline by ID
  static AirLineData? _getAirlineById(BuildContext context, String? airlineId) {
    if (airlineId == null) return null;

    final cubit = context.read<AirlineCubit>();
    final state = cubit.state;

    if (state is AirlineLoaded) {
      try {
        return state.airlines.firstWhere(
          (airline) => (airline.id ?? airline.sId) == airlineId,
        );
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // 🔹 Show error snackbar
  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
