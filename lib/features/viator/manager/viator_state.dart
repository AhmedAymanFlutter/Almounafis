import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';

abstract class ViatorState {}

class ViatorInitial extends ViatorState {}

class ViatorLoading extends ViatorState {}

class ViatorLoaded extends ViatorState {
  final List<ViatorTour> tours;
  final Pagination? pagination;
  final Map<String, dynamic> activeFilters;

  ViatorLoaded({
    required this.tours,
    this.pagination,
    this.activeFilters = const {},
  });
}

class ViatorError extends ViatorState {
  final String message;

  ViatorError(this.message);
}
