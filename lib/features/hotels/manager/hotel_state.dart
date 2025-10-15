import '../data/model/city_tour.dart';

abstract class HotelState {}

// Initial state
class HotelInitial extends HotelState {}

// States for getting all hotels
class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final GitHotelModel hotels;
  HotelLoaded(this.hotels);
}

class HotelFiltered extends HotelState {
  final List<Data> filteredHotels;
  HotelFiltered(this.filteredHotels);
}

class HotelEmpty extends HotelState {
  final String message;
  HotelEmpty(this.message);
}

class HotelError extends HotelState {
  final String message;
  HotelError(this.message);
}

// States for hotel details
class HotelDetailsLoading extends HotelState {}

class HotelDetailsLoaded extends HotelState {
  final Data hotelDetails;
  HotelDetailsLoaded(this.hotelDetails);
}

class HotelDetailsError extends HotelState {
  final String message;
  HotelDetailsError(this.message);
}
