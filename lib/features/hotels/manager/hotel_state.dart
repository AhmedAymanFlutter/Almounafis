import 'package:equatable/equatable.dart';
import '../data/model/city_tour.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final GitHotelModel hotels; // This should be GitHotelModel
  final String message;

  const HotelLoaded({
    required this.hotels,
    required this.message,
  });

  @override
  List<Object?> get props => [hotels, message];
}

class HotelError extends HotelState {
  final String message;
  final int? statusCode;

  const HotelError({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

class HotelEmpty extends HotelState {
  final String message;

  const HotelEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}