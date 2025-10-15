import 'package:equatable/equatable.dart';
import '../data/model/Airplane_City_model.dart';

abstract class AirPlaneCitysState extends Equatable {
  const AirPlaneCitysState();

  @override
  List<Object?> get props => [];
}

class AirPlaneCitysInitial extends AirPlaneCitysState {}

class AirPlaneCitysLoading extends AirPlaneCitysState {}

class AirPlaneCitysSuccess extends AirPlaneCitysState {
  final List<GetCitesAirplane> cities;

  const AirPlaneCitysSuccess(this.cities);

  @override
  List<Object?> get props => [cities];
}

class AirPlaneCitysError extends AirPlaneCitysState {
  final String message;

  const AirPlaneCitysError(this.message);

  @override
  List<Object?> get props => [message];
}
