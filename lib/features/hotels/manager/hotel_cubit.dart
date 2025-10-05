import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/city_tour.dart';
import '../data/repo/hotel_repo_tour.dart';
import 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _repository;

  HotelCubit({required HotelRepository repository})
      : _repository = repository,
        super(HotelInitial());

  // Safe emit method to prevent emitting after close
  void _safeEmit(HotelState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  Future<void> getAllHotels() async {
    _safeEmit(HotelLoading());

    try {
      final ApiResponse response = await _repository.getAllHotels();
      
      // Check if cubit is closed before proceeding
      if (isClosed) return;
      
      if (response.status) {
        if (response.data is GitHotelModel) {
          final GitHotelModel allHotelData = response.data as GitHotelModel;
          final hotels = allHotelData.data ?? [];

          if (hotels.isNotEmpty) {
            _safeEmit(HotelLoaded(
              hotels: allHotelData,
              message: response.message,
            ));
          } else {
            _safeEmit(HotelEmpty(
              message: 'No hotels available',
            ));
          }
        } else {
          _safeEmit(HotelError(
            message: 'Unexpected data type: ${response.data.runtimeType}',
            statusCode: response.statusCode,
          ));
        }
      } else {
        _safeEmit(HotelError(
          message: response.message,
          statusCode: response.statusCode,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      _safeEmit(HotelError(
        message: 'Error loading hotels: $e',
        statusCode: 500,
      ));
    }
  }

  Future<void> refreshHotels() async {
    await getAllHotels();
  }
}