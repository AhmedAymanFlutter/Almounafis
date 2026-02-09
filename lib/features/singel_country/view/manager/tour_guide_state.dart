import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';
import 'package:equatable/equatable.dart';

abstract class TourGuideState extends Equatable {
  const TourGuideState();

  @override
  List<Object> get props => [];
}

class TourGuideInitial extends TourGuideState {}

class TourGuideLoading extends TourGuideState {}

class TourGuideLoaded extends TourGuideState {
  final CityGuideData tourGuideData;
  const TourGuideLoaded(this.tourGuideData);

  @override
  List<Object> get props => [tourGuideData];
}

class TourGuideError extends TourGuideState {
  final String message;
  const TourGuideError(this.message);

  @override
  List<Object> get props => [message];
}
