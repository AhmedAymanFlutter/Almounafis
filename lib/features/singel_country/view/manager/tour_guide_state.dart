import 'package:almonafs_flutter/features/singel_country/data/model/tour_guide_model.dart';
import 'package:equatable/equatable.dart';

abstract class TourGuideState extends Equatable {
  const TourGuideState();

  @override
  List<Object> get props => [];
}

class TourGuideInitial extends TourGuideState {}

class TourGuideLoading extends TourGuideState {}

class TourGuideLoaded extends TourGuideState {
  final TourGuideData tourGuideData;
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
