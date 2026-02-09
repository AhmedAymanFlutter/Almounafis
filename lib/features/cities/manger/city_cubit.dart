import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'city_state.dart';
import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';

class CityCubit extends Cubit<CityState> {
  final CityRepository _repository;

  CityCubit(this._repository) : super(CityInitial());

  int _currentPage = 1;
  bool _hasReachedMax = false;
  List<City> _allCities = [];
  bool _isLoadingMore = false;
  SeoPage? _firstPageSeo;

  Future<void> getCities({bool isRefresh = false, int limit = 10}) async {
    try {
      if (isRefresh) {
        _currentPage = 1;
        _hasReachedMax = false;
        _allCities.clear();
        _firstPageSeo = null;
        emit(CityLoading());
      } else if (state is! CityLoaded && state is! CityLoading) {
        emit(CityLoading());
      }

      final response = await _repository.fetchCities(
        page: _currentPage,
        limit: limit,
      );

      if (isClosed) return;

      if (response.success == true && response.data != null) {
        final newCities = response.data?.cities ?? [];

        if (isRefresh || _currentPage == 1) {
          _allCities = newCities;
          _firstPageSeo = response.seoPage;
        } else {
          _allCities.addAll(newCities);
        }

        final pagination = response.data?.pagination;
        if (pagination != null) {
          _hasReachedMax = _currentPage >= (pagination.pages ?? 1);
        } else {
          _hasReachedMax = newCities.isEmpty;
        }

        // Ensure we display all cities accumulated so far
        response.data?.cities = List.from(_allCities);
        // Ensure SEO data persists if the new response misses it
        if (response.seoPage == null) {
          response.seoPage = _firstPageSeo;
        }

        emit(CityLoaded(response));
      } else {
        emit(CityError(response.message ?? "Unknown error occurred"));
      }
    } catch (e) {
      if (!isClosed) emit(CityError("Failed to fetch data: $e"));
    }
  }

  Future<void> loadMoreCities() async {
    if (_hasReachedMax || _isLoadingMore) return;
    try {
      _isLoadingMore = true;
      // Emit loading state to show spinner
      if (state is CityLoaded) {
        emit(
          CityLoaded((state as CityLoaded).cityResponse, isLoadingMore: true),
        );
      }

      _currentPage++;
      final response = await _repository.fetchCities(page: _currentPage);

      if (isClosed) return;

      if (response.success == true && response.data != null) {
        final newCities = response.data?.cities ?? [];
        _allCities.addAll(newCities);

        final pagination = response.data?.pagination;
        if (pagination != null) {
          _hasReachedMax = _currentPage >= (pagination.pages ?? 1);
        } else {
          _hasReachedMax = newCities.isEmpty;
        }

        response.data?.cities = List.from(_allCities);
        // Persist SEO info for UI stability
        if (response.seoPage == null) {
          response.seoPage = _firstPageSeo;
        }

        emit(CityLoaded(response, isLoadingMore: false));
      } else {
        // If load more fails, revert page and stop loading
        _currentPage--;
        if (state is CityLoaded) {
          emit(
            CityLoaded(
              (state as CityLoaded).cityResponse,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      _currentPage--;
      if (state is CityLoaded) {
        emit(
          CityLoaded((state as CityLoaded).cityResponse, isLoadingMore: false),
        );
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> getCityDetails(String idOrSlug) async {
    try {
      emit(CityDetailsLoading());

      // Fetch city details and guide data concurrently
      final responses = await Future.wait([
        _repository.fetchCityDetails(idOrSlug),
        _repository.fetchCityGuide(idOrSlug),
      ]);

      final detailsResponse = responses[0] as CityDetailsResponse;
      var guideResponse = responses[1] as CityGuideResponse;

      if (isClosed) return;

      if (detailsResponse.success == true && detailsResponse.data != null) {
        // If guide fetch failed or returned null, we still show details
        // But here we assume successful fetch if Future.wait succeeds
        emit(
          CityDetailsLoaded(detailsResponse, cityGuideResponse: guideResponse),
        );
      } else {
        emit(
          CityDetailsError(detailsResponse.message ?? "Unknown error occurred"),
        );
      }
    } catch (e) {
      if (!isClosed) emit(CityDetailsError("Failed to fetch details: $e"));
    }
  }

  /// Get cities filtered by country ID
  Future<void> getCitiesByCountry(String countryId) async {
    try {
      emit(CityLoading());
      final response = await _repository.fetchCitiesByCountry(countryId);

      if (isClosed) return;

      if (response.success == true && response.data != null) {
        // Note: We are not using pagination logic here for now as per current requirements
        emit(CityLoaded(response));
      } else {
        emit(CityError(response.message ?? "No cities found"));
      }
    } catch (e) {
      if (!isClosed) emit(CityError("Failed to fetch cities: $e"));
    }
  }
}
