import 'package:flutter/material.dart';
import '../helper/booking_helper.dart'; // ✅ adjust this import path if needed

class SearchButton extends StatelessWidget {
  final bool isArabic;
  final BuildContext contextRef; // pass parent context
  final dynamic selectedFromCity;
  final dynamic selectedToCity;
  final TextEditingController departureDateController;
  final TextEditingController? returnDateController;
  final bool isRoundTrip;
  final int adultsCount;
  final int childrenCount;
  final int infantsCount;
  final String? selectedClass;
  final String? selectedAirlineId;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController whatsappController;

  const SearchButton({
    super.key,
    required this.isArabic,
    required this.contextRef,
    required this.selectedFromCity,
    required this.selectedToCity,
    required this.departureDateController,
    this.returnDateController,
    required this.isRoundTrip,
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    required this.selectedClass,
    required this.selectedAirlineId,
    required this.emailController,
    required this.phoneController,
    required this.whatsappController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A8EEA), Color(0xFF102E4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _onSearchPressed,
          child: Center(
            child: Text(
              isArabic ? 'ابحث عن رحلتك' : 'Search for your trip',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSearchPressed() {
    BookingHelper.handleSearchButtonPress(
      contextRef,
      isArabic,
      selectedFromCity: selectedFromCity,
      selectedToCity: selectedToCity,
      departureDateController: departureDateController,
      returnDateController: returnDateController ?? TextEditingController(),
      isRoundTrip: isRoundTrip,
      adultsCount: adultsCount,
      childrenCount: childrenCount,
      infantsCount: infantsCount,
      selectedClass: selectedClass,
      selectedAirlineId: selectedAirlineId,
      emailController: emailController,
      phoneController: phoneController,
      whatsappController: whatsappController,
    );
  }
}
