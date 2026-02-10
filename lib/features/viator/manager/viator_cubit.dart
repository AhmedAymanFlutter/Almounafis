import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';
import 'package:almonafs_flutter/features/viator/data/repo/viator_repo.dart';
import 'package:almonafs_flutter/features/viator/manager/viator_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViatorCubit extends Cubit<ViatorState> {
  final ViatorRepository repository;

  Map<String, dynamic> _currentFilters = {};

  Map<String, dynamic> get currentFilters => Map.unmodifiable(_currentFilters);

  ViatorCubit(this.repository) : super(ViatorInitial());

  int _currentPage = 1;
  bool _hasReachedMax = false;
  List<ViatorTour> _allTours = [];
  bool _isLoadingMore = false;

  Future<void> fetchTours({
    String? search,
    String? city,
    double? minRating,
    String? cancellationType,
    String? sort,
    int page = 1,
    int limit = 10,
    String? lang,
    bool isRefresh = false,
  }) async {
    // If refreshing or new search/filter, reset pagination
    if (isRefresh || page == 1) {
      _currentPage = 1;
      _hasReachedMax = false;
      _allTours.clear();
      // Only emit loading if not a refresh (pull-to-refresh usually handles its own UI)
      if (!isRefresh) emit(ViatorLoading());
    } else if (state is! ViatorLoaded && state is! ViatorLoading) {
      emit(ViatorLoading());
    }

    // Update local filters if provided
    if (search != null) _currentFilters['search'] = search;
    if (city != null) _currentFilters['city'] = city;
    if (minRating != null) _currentFilters['minRating'] = minRating;
    if (cancellationType != null)
      _currentFilters['cancellationType'] = cancellationType;
    if (sort != null) _currentFilters['sort'] = sort;
    if (lang != null) _currentFilters['lang'] = lang;

    // Use current filters if not provided in arguments, else use arguments
    final effectiveSearch = search ?? _currentFilters['search'];
    final effectiveCity = city ?? _currentFilters['city'];
    final effectiveMinRating = minRating ?? _currentFilters['minRating'];
    final effectiveCancellationType =
        cancellationType ?? _currentFilters['cancellationType'];
    final effectiveSort = sort ?? _currentFilters['sort'];
    final effectiveLang = lang ?? _currentFilters['lang'] ?? 'en';

    try {
      final ApiResponse response = await repository.getTours(
        search: effectiveSearch,
        city: effectiveCity,
        minRating: effectiveMinRating,
        cancellationType: effectiveCancellationType,
        sort: effectiveSort,
        page: _currentPage, // Use class level page
        limit: limit,
        lang: effectiveLang,
      );

      if (response.status && response.data != null) {
        final viatorResponse = response.data as ViatorTourResponse;
        final newTours = viatorResponse.tours ?? [];

        debugPrint('✅ ViatorCubit: Received ${newTours.length} tours');
        if (newTours.isNotEmpty) {
          debugPrint('📌 First tour title: ${newTours[0].title}');
        }

        if (isRefresh || _currentPage == 1) {
          _allTours = newTours;
        } else {
          _allTours.addAll(newTours);
        }

        // Check if we reached max pages
        final pagination = viatorResponse.pagination;
        if (pagination != null) {
          _hasReachedMax = _currentPage >= (pagination.totalPages ?? 1);
        } else {
          _hasReachedMax = newTours.isEmpty;
        }

        debugPrint('🔄 Emitting ViatorLoaded with ${_allTours.length} tours');
        emit(
          ViatorLoaded(
            tours: List.from(_allTours),
            pagination: pagination,
            activeFilters: Map.from(_currentFilters),
            isLoadingMore: false,
          ),
        );
        debugPrint('✅ State emitted successfully');
      } else {
        emit(ViatorError(response.message));
      }
    } catch (e) {
      emit(ViatorError(e.toString()));
    }
  }

  Future<void> loadMoreTours() async {
    if (_hasReachedMax || _isLoadingMore) return;

    try {
      _isLoadingMore = true;
      if (state is ViatorLoaded) {
        emit(
          ViatorLoaded(
            tours: (state as ViatorLoaded).tours,
            pagination: (state as ViatorLoaded).pagination,
            activeFilters: (state as ViatorLoaded).activeFilters,
            isLoadingMore: true,
          ),
        );
      }

      _currentPage++;
      await fetchTours(page: _currentPage);
    } catch (e) {
      _currentPage--;
      if (state is ViatorLoaded) {
        emit(
          ViatorLoaded(
            tours: (state as ViatorLoaded).tours,
            pagination: (state as ViatorLoaded).pagination,
            activeFilters: (state as ViatorLoaded).activeFilters,
            isLoadingMore: false,
          ),
        );
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> fetchTourDetails(
    String productCodeOrSlug, {
    String? lang,
  }) async {
    emit(ViatorLoading());
    try {
      final effectiveLang = lang!;
      debugPrint('🔍 Fetching tour details with lang: $effectiveLang');

      final response = await repository.getTourDetails(
        productCodeOrSlug,
        lang: effectiveLang,
      );
      if (response.status && response.data != null) {
        debugPrint('✅ Tour details loaded successfully');
        emit(ViatorTourDetailsLoaded(response.data));
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
    fetchTours(isRefresh: false, page: 1); // Reset to page 1 for new filters
  }

  void clearFilters() {
    _currentFilters.clear();
    fetchTours(isRefresh: false, page: 1);
  }
}
