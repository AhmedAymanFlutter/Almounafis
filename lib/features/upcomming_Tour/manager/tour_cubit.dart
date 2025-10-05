import 'package:bloc/bloc.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';

import '../data/model/city_tour.dart';
import '../data/repo/city_repo_tour.dart';
import 'tour_state.dart';

class CityTourCubit extends Cubit<CityTourState> {
  final CityTourRepository _repository;

  CityTourCubit({required CityTourRepository repository})
      : _repository = repository,
        super(CityTourInitial());

  Future<void> getAllCities() async { // Renamed from getAllCountries
    emit(CityTourLoading());
    
    try {
      final ApiResponse response = await _repository.getAllcityTours();
      
      if (response.status) {
        if (response.data is AllCityTour) {
          final AllCityTour allCityTour = response.data as AllCityTour;
          final tours = allCityTour.data ?? [];
          
          if (tours.isNotEmpty) {
            emit(CityTourLoaded(
              allCityTour: allCityTour,
              message: response.message,
            ));
          } else {
            emit(CityTourEmpty(
              message: 'لا توجد جولات متاحة حالياً',
            ));
          }
        } else {
          emit(CityTourError(
            message: 'نوع البيانات غير متوقع: ${response.data.runtimeType}',
            statusCode: response.statusCode,
          ));
        }
      } else {
        emit(CityTourError(
          message: response.message ,
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      emit(CityTourError(
        message: 'حدث خطأ أثناء تحميل المدن: $e',
        statusCode: 500,
      ));
    }
  }

  // Update refresh method name too
  Future<void> refreshCities() async {
    await getAllCities();
  }
}

  // Get country by ID (when you uncomment the method in repository)
  // Future<void> getCountry(String countryId) async {
  //   emit(CityTourLoading());
  //   
  //   try {
  //     final ApiResponse response = await _repository.getCountry(countryId);
  //     
  //     if (response.status) {
  //       if (response.data is GetSingleCountry) {
  //         final GetSingleCountry country = response.data as GetSingleCountry;
  //         
  //         emit(SingleCountryLoaded(
  //           country: country,
  //           message: response.message ?? 'تم تحميل بيانات الدولة بنجاح',
  //         ));
  //       } else {
  //         emit(CityTourError(
  //           message: 'نوع البيانات غير متوقع',
  //           statusCode: response.statusCode,
  //         ));
  //       }
  //     } else {
  //       emit(CityTourError(
  //         message: response.message ?? 'فشل في تحميل بيانات الدولة',
  //         statusCode: response.statusCode,
  //       ));
  //     }
  //   } catch (e) {
  //     emit(CityTourError(
  //       message: 'حدث خطأ أثناء تحميل بيانات الدولة: $e',
  //       statusCode: 500,
  //     ));
  //   }
  // }
