

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/AirLine_data.dart';
import '../data/repo/AirLine_repo.dart';
import 'Airine_state.dart';


class FilterCubit extends Cubit<FilterState> {
  final FlightFilterRepository repository;
  FlightFilter currentFilter = FlightFilter();

  FilterCubit(this.repository) : super(const FilterInitial());

  Future<void> loadFilterOptions(String filterType, bool isArabic) async {
    try {
      emit(const FilterLoading());
      
      if (filterType == 'Airlines') {
        // Load airlines from API
        final response = await repository.getAirlines();
        
        if (response.status && response.data is Map<String, dynamic>) {
          final model = AirLineModel.fromJson(response.data as Map<String, dynamic>);
          final airlines = model.data ?? [];
          final airlineNames = airlines.map((a) => a.name ?? '').toList();
          
          emit(AirlinesLoaded(airlines.cast<AirLineData>()));
        } else {
          emit(FilterError(response.message ));
        }
      } else {
        // Load static options
        final options = repository.getFilterOptions(filterType, isArabic);
        emit(FilterOptionsLoaded(options: options, filterType: filterType));
      }
    } catch (e) {
      emit(FilterError('Failed to load options: $e'));
    }
  }
  void updateFilterField({
    String? airline,
    String? passengerCount,
    String? travelClass,
    double? minPrice,
    double? maxPrice,
    String? departureTime,
    String? arrivalTime,
  }) {
    currentFilter = currentFilter.copyWith(
      airline: airline,
      passengerCount: passengerCount,
      travelClass: travelClass,
      minPrice: minPrice,
      maxPrice: maxPrice,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
    );
    emit(FilterChanged(currentFilter));
  }

  void clearAllFilters() {
    currentFilter = FlightFilter();
    emit(FilterChanged(currentFilter));
  }
}
