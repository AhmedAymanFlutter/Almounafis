class FlightBookingRequest {
  final String origin;
  final String destination;
  final String tripType;
  final String departureDate;
  final String? returnDate;
  final int adults;
  final int children;
  final int infants;
  final String travelClass;
  final String? airlinePreference;
  final Map<String, dynamic> contactInfo;
  final String bookingMethod;

  FlightBookingRequest({
    required this.origin,
    required this.destination,
    required this.tripType,
    required this.departureDate,
    this.returnDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.travelClass,
    this.airlinePreference,
    required this.contactInfo,
    required this.bookingMethod,
  });

  // Helper method to convert date from dd-MM-yyyy to ISO 8601
  String _convertToISODate(String dateStr) {
    try {
      // Remove spaces and split the date
      final cleanDate = dateStr.replaceAll(' ', '');
      final parts = cleanDate.split('-');

      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        final year = parts[2];

        // Return ISO 8601 format with time
        return '$year-$month-${day}T08:00:00.000Z';
      }

      // If format is wrong, return as is
      return cleanDate;
    } catch (e) {
      return dateStr;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'tripType': tripType,
      'origin': {
        'city': origin,
        'cityAr': origin,
        'airport': origin,
        'airportCode': origin,
      },
      'destination': {
        'city': destination,
        'cityAr': destination,
        'airport': destination,
        'airportCode': destination,
      },
      'departureDate': _convertToISODate(departureDate),
      if (returnDate != null && returnDate!.isNotEmpty)
        'returnDate': _convertToISODate(returnDate!),
      'passengers': {
        'adults': adults,
        'children': children,
        'infants': infants,
      },
      if (airlinePreference != null && airlinePreference!.isNotEmpty)
        'airlinePreference': airlinePreference,
      'travelClass': travelClass,
      'contactInfo': {
        'email': contactInfo['email'],
        'phone': contactInfo['phone'],
        'countryCode': contactInfo['countryCode'],
        if (contactInfo['whatsapp'] != null &&
            (contactInfo['whatsapp'] as String).isNotEmpty)
          'whatsapp': contactInfo['whatsapp'],
      },
      'bookingMethod': bookingMethod,
    };
  }
}
