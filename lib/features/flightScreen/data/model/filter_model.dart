class FlightFilter {
  String? airline;
  String? passengerCount;
  String? travelClass;
  double? minPrice;
  double? maxPrice;
  String? departureTime;
  String? arrivalTime;

  FlightFilter({
    this.airline,
    this.passengerCount,
    this.travelClass,
    this.minPrice,
    this.maxPrice,
    this.departureTime,
    this.arrivalTime,
  });

  FlightFilter copyWith({
    String? airline,
    String? passengerCount,
    String? travelClass,
    double? minPrice,
    double? maxPrice,
    String? departureTime,
    String? arrivalTime,
  }) {
    return FlightFilter(
      airline: airline ?? this.airline,
      passengerCount: passengerCount ?? this.passengerCount,
      travelClass: travelClass ?? this.travelClass,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  bool get hasActiveFilters {
    return airline != null ||
        passengerCount != null ||
        travelClass != null ||
        minPrice != null ||
        maxPrice != null ||
        departureTime != null ||
        arrivalTime != null;
  }

  @override
  String toString() {
    return 'FlightFilter(airline: $airline, passengerCount: $passengerCount, travelClass: $travelClass)';
  }
}