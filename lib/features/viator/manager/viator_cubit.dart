import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/data/repo/viator_repo.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViatorCubit extends Cubit<ViatorState> {
  final ViatorRepository repository;

  Map<String, dynamic> _currentFilters = {};

  ViatorCubit(this.repository) : super(ViatorInitial());

  Future<void> fetchTours({
    String? search,
    String? city,
    double? minRating,
    String? cancellationType,
    String? sort,
    int page = 1,
    int limit = 10,
    String lang = 'en',
    bool isRefresh = false,
  }) async {
    // If not refreshing and already loading, return (optional debouncing)
    // if (state is ViatorLoading && !isRefresh) return;

    if (!isRefresh) {
      emit(ViatorLoading());
    }

    // Update local filters if provided
    if (search != null) _currentFilters['search'] = search;
    if (city != null) _currentFilters['city'] = city;
    if (minRating != null) _currentFilters['minRating'] = minRating;
    if (cancellationType != null)
      _currentFilters['cancellationType'] = cancellationType;
    if (sort != null) _currentFilters['sort'] = sort;

    // Use current filters if not provided in arguments, else use arguments
    final effectiveSearch = search ?? _currentFilters['search'];
    final effectiveCity = city ?? _currentFilters['city'];
    final effectiveMinRating = minRating ?? _currentFilters['minRating'];
    final effectiveCancellationType =
        cancellationType ?? _currentFilters['cancellationType'];
    final effectiveSort = sort ?? _currentFilters['sort'];

    try {
      final ApiResponse response = await repository.getTours(
        search: effectiveSearch,
        city: effectiveCity,
        minRating: effectiveMinRating,
        cancellationType: effectiveCancellationType,
        sort: effectiveSort,
        page: page,
        limit: limit,
        lang: lang,
      );

      if (response.status && response.data != null) {
        final viatorResponse = response.data as ViatorTourResponse;

        emit(
          ViatorLoaded(
            tours: viatorResponse.tours ?? [],
            pagination: viatorResponse.pagination,
            activeFilters: Map.from(_currentFilters),
          ),
        );
      } else {
        emit(ViatorError(response.message));
      }
    } catch (e) {
      emit(ViatorError(e.toString()));
    }
  }

  void updateFilter(String key, dynamic value) {
    if (value == null || (value is String && value.isEmpty)) {
      _currentFilters.remove(key);
    } else {
      _currentFilters[key] = value;
    }
    fetchTours(isRefresh: false); // Trigger fetch with new filters
  }

  void clearFilters() {
    _currentFilters.clear();
    fetchTours(isRefresh: false);
  }
}
