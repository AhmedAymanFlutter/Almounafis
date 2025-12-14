import 'package:almonafs_flutter/features/flightScreen/data/model/AirLine_data.dart';

abstract class AirlineState {}

class AirlineInitial extends AirlineState {}

class AirlineLoading extends AirlineState {}

class AirlineLoaded extends AirlineState {
  final List<AirLineData> airlines;
  AirlineLoaded(this.airlines);
}

// Used when searching within the list
class AirlineFiltered extends AirlineState {
  final List<AirLineData> filteredAirlines;
  AirlineFiltered(this.filteredAirlines);
}

class AirlineEmpty extends AirlineState {
  final String message;
  AirlineEmpty(this.message);
}

class AirlineError extends AirlineState {
  final String message;
  AirlineError(this.message);
}
