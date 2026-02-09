import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';

abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final CityResponse cityResponse;
  final bool isLoadingMore;

  CityLoaded(this.cityResponse, {this.isLoadingMore = false});
}

class CityError extends CityState {
  final String message;

  CityError(this.message);
}

class CityDetailsLoading extends CityState {}

class CityDetailsLoaded extends CityState {
  final CityDetailsResponse cityDetailsResponse;
  final CityGuideResponse? cityGuideResponse;

  CityDetailsLoaded(this.cityDetailsResponse, {this.cityGuideResponse});
}

class CityDetailsError extends CityState {
  final String message;

  CityDetailsError(this.message);
}
