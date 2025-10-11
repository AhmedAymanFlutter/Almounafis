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
  Future<void> getCityTourDetails(String tourIdOrSlug) async {
    emit(SingleCityTourLoading());
    
    try {
      final ApiResponse response = await _repository.getCityTourDetails(tourIdOrSlug);
      
      if (response.status) {
        if (response.data is Data) {
          final Data tourData = response.data as Data;
          
          emit(SingleCityTourLoaded(
            cityTour: tourData,
            message: response.message,
          ));
        } else {
          emit(CityTourError(
            message: 'نوع البيانات غير متوقع: ${response.data.runtimeType}',
            statusCode: response.statusCode,
          ));
        }
      } else {
        emit(CityTourError(
          message: response.message,
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      emit(CityTourError(
        message: 'حدث خطأ أثناء تحميل تفاصيل الجولة: $e',
        statusCode: 500,
      ));
    }
  }

 
}

  
