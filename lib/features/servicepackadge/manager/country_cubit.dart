import 'package:almonafs_flutter/features/servicepackadge/data/model/getAllcountry.dart' show ServicesModel, Data;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/Service_repo.dart';
import 'country_state.dart';


class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository repository;
  
  int _currentPage = 1;
  bool _hasReachedMax = false;
  final List<Data> _allServices = [];

  ServicesCubit({required this.repository}) : super(ServicesInitial());

  Future<void> getServices({bool loadMore = false, int limit = 10}) async {
    try {
      if (!loadMore) {
        _currentPage = 1;
        _hasReachedMax = false;
        _allServices.clear();
        emit(ServicesLoading());
      } else {
        if (_hasReachedMax) return;
        _currentPage++;
      }

      final services = await repository.getServices(
        page: _currentPage,
        limit: limit,
      );

      if (services.data == null || services.data!.isEmpty) {
        if (loadMore) {
          _hasReachedMax = true;
        } else {
          emit(ServicesLoaded(
            services: ServicesModel(
           
              data: [],
            ),
            hasReachedMax: true,
          ));
        }
        return;
      }

      if (!loadMore) {
        _allServices.clear();
      }
      _allServices.addAll(services.data!);

      

      emit(ServicesLoaded(
        services: ServicesModel(
        
          data: List<Data>.from(_allServices),
        ),
        hasReachedMax: _hasReachedMax,
      ));
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  Future<void> getFeaturedServices() async {
    try {
      emit(ServicesLoading());
      
      final services = await repository.getFeaturedServices();
      
      emit(ServicesLoaded(
        services: services,
        hasReachedMax: true,
      ));
    } catch (e) {
      emit(ServicesError(e.toString()));
    }
  }

  Future<void> refreshServices() async {
    await getServices(loadMore: false);
  }

  void filterServicesByQuery(String query) {
    final currentState = state;
    if (currentState is ServicesLoaded) {
      if (query.isEmpty) {
        // Return to original list
        emit(ServicesLoaded(
          services: ServicesModel(
        
            data: List<Data>.from(_allServices),
          ),
          hasReachedMax: currentState.hasReachedMax,
        ));
      } else {
        final filteredServices = _allServices.where((service) {
          final name = service.name?.toLowerCase() ?? '';
          final nameAr = service.nameAr?.toLowerCase() ?? '';
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || nameAr.contains(searchQuery);
        }).toList();

        emit(ServicesLoaded(
          services: ServicesModel(
           
            data: filteredServices,
          ),
          hasReachedMax: true,
        ));
      }
    }
  }

  // Getter for current services list
  List<Data> get currentServices => List<Data>.from(_allServices);
}