import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/city_tour.dart';
import '../data/repo/Hotel_repo_tour.dart';
import 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository repo;
  List<Data> _allHotels = []; // ✅ نخزّن هنا كل الفنادق بعد التحميل

  HotelCubit(this.repo) : super(HotelInitial());

  Future<void> getAllHotels() async {
    if (isClosed) return;
    emit(HotelLoading());

    final response = await repo.getAllHotels();
    if (isClosed) return;

    if (response.status) {
      final hotels = response.data as GitHotelModel;
      if (hotels.data != null && hotels.data!.isNotEmpty) {
        _allHotels = hotels.data!; // ✅ حفظ جميع الفنادق الأصلية
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
        _allHotels = hotels.data!;
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
        _allHotels = hotels.data!;
        emit(HotelLoaded(hotels));
      } else {
        emit(HotelEmpty('No hotels available in this city'));
      }
    } else {
      emit(HotelError(response.message));
    }
  }

  /// 🔍 البحث المحلي (داخل النتائج الموجودة)
  void localSearchHotels(String query, bool isArabic) {
    if (query.isEmpty) {
      // رجّع الفنادق الأصلية كلها
      emit(HotelLoaded(GitHotelModel(data: _allHotels)));
      return;
    }

    final filtered = _allHotels.where((hotel) {
      final name = isArabic ? (hotel.nameAr ?? '') : (hotel.name ?? '');
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filtered.isEmpty) {
      emit(HotelEmpty(isArabic ? "لم يتم العثور على فنادق" : "No hotels found"));
    } else {
      emit(HotelLoaded(GitHotelModel(data: filtered)));
    }
  }

  /// 🔎 البحث عبر API (للبحث المتقدم أو الفلاتر)
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
        _allHotels = hotels.data!;
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
