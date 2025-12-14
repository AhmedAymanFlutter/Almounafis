import 'package:flutter/material.dart';
import '../widget/trip_type_button.dart';

Widget buildTripTypeSection({
  required bool isArabic,
  required bool isRoundTrip,
  required VoidCallback onSelectRoundTrip,
  required VoidCallback onSelectOneWay,
}) {
  return Row(
    children: [
      Expanded(
        child: TripTypeButton(
          label: isArabic ? 'ذهاب وعودة' : 'Round Trip',
          icon: Icons.sync,
          isSelected: isRoundTrip,
          onTap: onSelectRoundTrip,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TripTypeButton(
          label: isArabic ? 'ذهاب فقط' : 'One Way',
          icon: Icons.arrow_forward,
          isSelected: !isRoundTrip,
          onTap: onSelectOneWay,
        ),
      ),
    ],
  );
}
