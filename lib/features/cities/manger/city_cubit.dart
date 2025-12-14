import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  final CityRepository _repository;

  CityCubit(this._repository) : super(CityInitial());

  Future<void> getCities() async {
    try {
      emit(CityLoading());
      final response = await _repository.fetchCities();

      if (response.success == true && response.data != null) {
        emit(CityLoaded(response));
      } else {
        emit(CityError(response.message ?? "Unknown error occurred"));
      }
    } catch (e) {
      emit(CityError("Failed to fetch data: $e"));
    }
  }

  Future<void> getCityDetails(String idOrSlug) async {
    try {
      emit(CityDetailsLoading());
      final response = await _repository.fetchCityDetails(idOrSlug);

      if (response.success == true && response.data != null) {
        emit(CityDetailsLoaded(response));
      } else {
        emit(CityDetailsError(response.message ?? "Unknown error occurred"));
      }
    } catch (e) {
      emit(CityDetailsError("Failed to fetch details: $e"));
    }
  }
}
