import 'package:almonafs_flutter/features/getAilplaneState/data/model/Airplane_City_model.dart';
import 'package:almonafs_flutter/features/getAilplaneState/data/repo/Airplan_city_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../getAilplaneState/manager/airplane_citys_state.dart';

class AirPlaneCitysCubit extends Cubit<AirPlaneCitysState> {
  final AirplaneCitsRepository _repository;

  AirPlaneCitysCubit(this._repository) : super(AirPlaneCitysInitial());

  Future<void> getAirPlaneCitys() async {
    emit(AirPlaneCitysLoading());
    try {
      final response = await _repository.getAirplaneCities();

      if (response.status && response.data != null) {
        final data = response.data;
        final List<GetCitesAirplane> cities = (data as List)
            .map((e) => GetCitesAirplane.fromJson(e))
            .toList();

        emit(AirPlaneCitysSuccess(cities));
      } else {
        emit(AirPlaneCitysError(response.message ));
      }
    } catch (e) {
      emit(AirPlaneCitysError("حدث خطأ أثناء تحميل المدن: $e"));
    }
  }
}
