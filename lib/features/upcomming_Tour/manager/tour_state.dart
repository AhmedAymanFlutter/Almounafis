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

// ✅ إضافة حالة تفاصيل الجولة
class SingleCityTourLoading extends CityTourState {}

class SingleCityTourLoaded extends CityTourState {
  final Data cityTour;
  final String message;

  const SingleCityTourLoaded({
    required this.cityTour,
    required this.message,
  });

  @override
  List<Object?> get props => [cityTour, message];
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
class CityTourFiltered extends CityTourState {
  final List<Data> filteredTours;
  const CityTourFiltered(this.filteredTours);

  @override
  List<Object?> get props => [filteredTours];
}
