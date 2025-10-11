
import 'package:equatable/equatable.dart';

import '../data/model/AirLine_data.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {
  const FilterInitial();
}

class FilterLoading extends FilterState {
  const FilterLoading();
}

class FilterOptionsLoaded extends FilterState {
  final List<String> options;
  final String filterType;

  const FilterOptionsLoaded({
    required this.options,
    required this.filterType,
  });

  @override
  List<Object?> get props => [options, filterType];
}

class AirlinesLoaded extends FilterState {
  final List<AirLineData> airlines;

  const AirlinesLoaded(this.airlines);

  @override
  List<Object?> get props => [airlines];
}

class FilterChanged extends FilterState {
  final FlightFilter filter;

  const FilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class FilterError extends FilterState {
  final String message;

  const FilterError(this.message);

  @override
  List<Object?> get props => [message];
}