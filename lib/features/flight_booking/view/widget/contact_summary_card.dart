import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../flightScreen/data/model/AirLine_data.dart';
import '../../data/model/Flight_Booking_Request.dart';

class ContactSummaryCard extends StatelessWidget {
  final FlightBookingRequest bookingRequest;
  final AirLineData? selectedAirline;
  final String fromCity;
  final String toCity;

  const ContactSummaryCard({
    super.key,
    required this.bookingRequest,
    this.selectedAirline,
    required this.fromCity,
    required this.toCity,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state == AppLanguage.arabic;

    final fromCityName = fromCity.isEmpty
        ? (isArabic ? 'غير محددة' : 'Not specified')
        : fromCity;

    final toCityName = toCity.isEmpty
        ? (isArabic ? 'غير محددة' : 'Not specified')
        : toCity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'ملخص الرحلة' : 'Trip Summary',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildRow(isArabic ? 'من:' : 'From:', fromCityName),
          _buildRow(isArabic ? 'إلى:' : 'To:', toCityName),
          _buildRow(
            isArabic ? 'التاريخ:' : 'Date:',
            bookingRequest.departureDate,
          ),
          if (bookingRequest.returnDate != null)
            _buildRow(
              isArabic ? 'العودة:' : 'Return:',
              bookingRequest.returnDate!,
            ),
          _buildRow(
            isArabic ? 'نوع الرحلة:' : 'Trip Type:',
            bookingRequest.tripType,
          ),
          _buildRow(
            isArabic ? 'الدرجة:' : 'Class:',
            bookingRequest.travelClass,
          ),
          _buildRow(
            isArabic ? 'شركة الطيران:' : 'Airline:',
            selectedAirline?.nameAr ??
                selectedAirline?.name ??
                (isArabic ? 'غير محددة' : 'Not specified'),
          ),
          _buildRow(
            isArabic ? 'الركاب:' : 'Passengers:',
            '${bookingRequest.adults} ${isArabic ? 'بالغ' : 'Adults'}, '
            '${bookingRequest.children} ${isArabic ? 'أطفال' : 'Children'}, '
            '${bookingRequest.infants} ${isArabic ? 'رضع' : 'Infants'}',
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
