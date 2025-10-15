import 'package:flutter/material.dart';
import '../../../../core/theme/app_color.dart';
import '../widget/date_field.dart';
import '../widget/dropdown_field.dart';
import '../widget/glass_card.dart';
import '../widget/passenger_counter.dart';


class DateCard extends StatelessWidget {
  final bool isArabic;
  final bool isRoundTrip;
  final TextEditingController departureDateController;
  final TextEditingController? returnDateController;
  final Function(int) onAdultsChanged;
  final Function(int) onChildrenChanged;
  final Function(int) onInfantsChanged;
  final Function(String?) onAirlineChanged;
  final Function(String?) onClassChanged;

  const DateCard({
    super.key,
    required this.isArabic,
    required this.isRoundTrip,
    required this.departureDateController,
    this.returnDateController,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onInfantsChanged,
    required this.onAirlineChanged,
    required this.onClassChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderText(),
          const SizedBox(height: 16),
          _buildDateFields(),
          const SizedBox(height: 16),
          _buildPassengerAndDropdowns(),
        ],
      ),
    );
  }

  /// 🟦 Header Text
  Widget _buildHeaderText() {
    final text = isRoundTrip
        ? (isArabic ? 'أدخل تواريخ الذهاب والعودة' : 'Enter Departure and Return Dates')
        : (isArabic ? 'اختر تاريخ الرحلة' : 'Select the travel date');

    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColor.secondaryblue,
      ),
    );
  }

  /// 🟩 Date Fields
  Widget _buildDateFields() {
    final departureLabel = isArabic ? 'تاريخ المغادرة' : 'Departure Date';
    final returnLabel = isArabic ? 'تاريخ العودة' : 'Return Date';

    if (isRoundTrip && returnDateController != null) {
      return Row(
        children: [
          Expanded(child: DateField(label: departureLabel, controller: departureDateController)),
          const SizedBox(width: 12),
          Expanded(child: DateField(label: returnLabel, controller: returnDateController!)),
        ],
      );
    }

    return DateField(label: departureLabel, controller: departureDateController);
  }

  /// 🟨 Passenger and Dropdowns
  Widget _buildPassengerAndDropdowns() {
    return Column(
      children: [
        PassengerCounterDropdown(
          onAdultsChanged: onAdultsChanged,
          onChildrenChanged: onChildrenChanged,
          onInfantsChanged: onInfantsChanged,
        ),
        const SizedBox(height: 8),
        DropdownField(
          label: isArabic ? 'شركات الطيران' : 'Airlines',
          onChanged: onAirlineChanged,
        ),
        const SizedBox(height: 8),
        DropdownField(
          label: isArabic ? 'الدرجة' : 'Class',
          onChanged: onClassChanged,
        ),
      ],
    );
  }
}
