import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/city_tour.dart';
import '../data/repo/Hotel_repo_tour.dart';
import 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository repo;
  
  HotelCubit(this.repo) : super(HotelInitial());

  Future<void> getAllHotels() async {
    if (isClosed) return;
    emit(HotelLoading());
    
    final response = await repo.getAllHotels();
    if (isClosed) return;

    if (response.status) {
      final hotels = response.data as GitHotelModel;
      if (hotels.data != null && hotels.data!.isNotEmpty) {
        emit(HotelLoaded(hotels));
      } else {
        emit(HotelEmpty('No hotels available'));
      }
    } else {
      emit(HotelError(response.message));
    }
  }

  Future<void> getHotelDetails(String hotelId) async {
    if (isClosed) return;
    emit(HotelDetailsLoading());
    
    final response = await repo.getHotelDetails(hotelId);
    if (isClosed) return;

    if (response.status) {
      final hotelDetails = response.data as Data;
      emit(HotelDetailsLoaded(hotelDetails));
    } else {
      emit(HotelDetailsError(response.message));
    }
  }

  Future<void> getFeaturedHotels({int limit = 6}) async {
    if (isClosed) return;
    emit(HotelLoading());
    
    final response = await repo.getFeaturedHotels(limit: limit);
    if (isClosed) return;

    if (response.status) {
      final hotels = response.data as GitHotelModel;
      if (hotels.data != null && hotels.data!.isNotEmpty) {
        emit(HotelLoaded(hotels));
      } else {
        emit(HotelEmpty('No featured hotels available'));
      }
    } else {
      emit(HotelError(response.message));
    }
  }

  Future<void> getHotelsByCity(String cityId) async {
    if (isClosed) return;
    emit(HotelLoading());
    
    final response = await repo.getHotelsByCity(cityId);
    if (isClosed) return;

    if (response.status) {
      final hotels = response.data as GitHotelModel;
      if (hotels.data != null && hotels.data!.isNotEmpty) {
        emit(HotelLoaded(hotels));
      } else {
        emit(HotelEmpty('No hotels available in this city'));
      }
    } else {
      emit(HotelError(response.message));
    }
  }

  Future<void> searchHotels({
    String? cityId,
    double? minPrice,
    double? maxPrice,
    int? rating,
    String? amenities,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    if (isClosed) return;
    emit(HotelLoading());
    
    final response = await repo.searchHotels(
      cityId: cityId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      rating: rating,
      amenities: amenities,
      sort: sort,
      page: page,
      limit: limit,
    );
    if (isClosed) return;

    if (response.status) {
      final hotels = response.data as GitHotelModel;
      if (hotels.data != null && hotels.data!.isNotEmpty) {
        emit(HotelLoaded(hotels));
      } else {
        emit(HotelEmpty('No hotels match your search criteria'));
      }
    } else {
      emit(HotelError(response.message));
    }
  }

  Future<void> refreshHotels() async {
    await getAllHotels();
  }
}
