class FlightBookingState {
  const FlightBookingState();
}

class FlightBookingInitial extends FlightBookingState {
  const FlightBookingInitial();
}

class FlightBookingLoading extends FlightBookingState {
  const FlightBookingLoading();
}

class FlightBookingSuccess extends FlightBookingState {
  final String bookingReference; // Or whatever data you need
  final String message;
  
  const FlightBookingSuccess({
    this.bookingReference = '',
    this.message = 'تم الحجز بنجاح',
  });
}

class FlightBookingError extends FlightBookingState {
  final String message;
  const FlightBookingError({required this.message});
}