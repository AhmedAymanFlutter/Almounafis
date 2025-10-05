import 'package:equatable/equatable.dart';
import '../data/model/city_tour.dart';
abstract class CityTourState extends Equatable {
  const CityTourState();

  @override
  List<Object?> get props => [];
}

class CityTourInitial extends CityTourState {}

class CityTourLoading extends CityTourState {}

class CityTourLoaded extends CityTourState {
  final AllCityTour allCityTour;
  final String message;

  const CityTourLoaded({
    required this.allCityTour,
    required this.message,
  });

  @override
  List<Object?> get props => [allCityTour, message];
}

class CityTourError extends CityTourState {
  final String message;
  final int? statusCode;

  const CityTourError({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}
class CityTourEmpty extends CityTourState {
  final String message;

  const CityTourEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}

// If you need single country state later, you can add:
class SingleCountryLoaded extends CityTourState {
  // final GetSingleCountry country;
  // final String message;
  
  // const SingleCountryLoaded({
  //   required this.country,
  //   required this.message,
  // });
  
  // @override
  // List<Object?> get props => [country, message];
}