import 'package:bloc/bloc.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import '../data/model/city_tour.dart';
import '../data/repo/city_repo_tour.dart';
import 'tour_state.dart';

class CityTourCubit extends Cubit<CityTourState> {
  final CityTourRepository _repository;
  List<Data> _allTours = [];

  CityTourCubit({required CityTourRepository repository})
      : _repository = repository,
        super(CityTourInitial());

  Future<void> getAllCities() async {
    if (isClosed) return;
    emit(CityTourLoading());

    try {
      final ApiResponse response = await _repository.getAllcityTours();
      if (isClosed) return;

      if (response.status) {
        if (response.data is AllCityTour) {
          final AllCityTour allCityTour = response.data as AllCityTour;
          final tours = allCityTour.data ?? [];

          if (tours.isNotEmpty) {
            _allTours = tours; // ✅ خزّن الجولات الأصلية
            if (isClosed) return;
            emit(CityTourLoaded(
              allCityTour: allCityTour,
              message: response.message,
            ));
          } else {
            if (isClosed) return;
            emit(CityTourEmpty(message: 'لا توجد جولات متاحة حالياً'));
          }
        } else {
          if (isClosed) return;
          emit(CityTourError(
            message: 'نوع البيانات غير متوقع: ${response.data.runtimeType}',
            statusCode: response.statusCode,
          ));
        }
      } else {
        if (isClosed) return;
        emit(CityTourError(
          message: response.message,
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CityTourError(
        message: 'حدث خطأ أثناء تحميل المدن: $e',
        statusCode: 500,
      ));
    }
  }

  Future<void> refreshCities() async {
    await getAllCities();
  }

  Future<void> getCityTourDetails(String tourIdOrSlug) async {
    if (isClosed) return;
    emit(SingleCityTourLoading());

    try {
      final ApiResponse response =
          await _repository.getCityTourDetails(tourIdOrSlug);
      if (isClosed) return;

      if (response.status) {
        if (response.data is Data) {
          final Data tourData = response.data as Data;
          if (isClosed) return;
          emit(SingleCityTourLoaded(
            cityTour: tourData,
            message: response.message,
          ));
        } else {
          if (isClosed) return;
          emit(CityTourError(
            message: 'نوع البيانات غير متوقع: ${response.data.runtimeType}',
            statusCode: response.statusCode,
          ));
        }
      } else {
        if (isClosed) return;
        emit(CityTourError(
          message: response.message,
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CityTourError(
        message: 'حدث خطأ أثناء تحميل تفاصيل الجولة: $e',
        statusCode: 500,
      ));
    }
  }

  void searchTours(String query, bool isArabic) {
    if (isClosed) return;

    if (query.isEmpty) {
      emit(CityTourLoaded(
        allCityTour: AllCityTour(data: _allTours),
        message: 'عرض جميع الجولات',
      ));
      return;
    }

    final filtered = _allTours.where((tour) {
      final name = isArabic ? (tour.titleAr ?? '') : (tour.title ?? '');
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(CityTourFiltered(filtered));
  }
}
