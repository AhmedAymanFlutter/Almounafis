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

  Map<String, dynamic> toJson() {
    // ✅ نظف الـ dates من المسافات
    final cleanDepartureDate = departureDate.replaceAll(' ', '');
    final cleanReturnDate = returnDate?.replaceAll(' ', '');

    return {
      'tripType': tripType,
      'origin': origin,
      'destination': destination,
      'departureDate': cleanDepartureDate, 
      if (cleanReturnDate != null && cleanReturnDate.isNotEmpty) 
        'returnDate': cleanReturnDate,
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