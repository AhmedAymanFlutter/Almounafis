import 'package:almonafs_flutter/features/flightScreen/data/model/AirLine_data.dart';
import 'package:almonafs_flutter/features/flightScreen/data/repo/AirLine_repo.dart';
import 'package:almonafs_flutter/features/flightScreen/manager/Airine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AirlineCubit extends Cubit<AirlineState> {
  final AirlineRepository repo;

  // Cache to store all airlines for local searching
  List<AirLineData> _allAirlines = [];

  AirlineCubit(this.repo) : super(AirlineInitial());

  /// Fetch airlines from API
  Future<void> fetchAirlines() async {
    if (isClosed) return;
    emit(AirlineLoading());

    final response = await repo.getAllAirlines();

    if (isClosed) return;

    if (response.status) {
      // The repository now returns the parsed model in 'data'
      final model = response.data as AirLineModel;

      if (model.data != null && model.data!.isNotEmpty) {
        _allAirlines = model.data!; // Save to local list
        emit(AirlineLoaded(_allAirlines));
      } else {
        emit(AirlineEmpty('No airlines available'));
      }
    } else {
      emit(AirlineError(response.message));
    }
  }

  /// Local Search Logic
  void searchAirlines(String query, bool isArabic) {
    if (query.isEmpty) {
      emit(AirlineLoaded(_allAirlines));
      return;
    }

    final filtered = _allAirlines.where((airline) {
      final name = isArabic ? (airline.nameAr ?? '') : (airline.name ?? '');

      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filtered.isEmpty) {
      emit(AirlineEmpty(isArabic ? 'لا توجد نتائج' : 'No results found'));
    } else {
      emit(AirlineFiltered(filtered));
    }
  }
}
