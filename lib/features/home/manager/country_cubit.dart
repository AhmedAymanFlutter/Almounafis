import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/country_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepository repository;

  CountryCubit(this.repository) : super(CountryInitial());

  Future<void> fetchAllCountries() async {
    emit(CountryLoading());        
    final response = await repository.getAllCountries();    
    
    if (response.status) {
      final allCountryData = response.data;      
      if (allCountryData != null && allCountryData.data?.isNotEmpty == true) {
        emit(CountryLoaded(allCountryData.data!));
      } else {
        emit(const CountryError("لم يتم العثور على دول في الاستجابة."));
      }
    } else {
      emit(CountryError(response.message));
    }
  }

  // ✅ Add this new method
  Future<void> fetchCountryDetails(String countryIdOrSlug) async {
    emit(SingleCountryLoading());
    
    final response = await repository.getCountry(countryIdOrSlug);
    
    if (response.status) {
      final countryData = response.data;
      if (countryData != null && countryData.data != null) {
        emit(SingleCountryLoaded(countryData.data!));
      } else {
        emit(const CountryError("لم يتم العثور على بيانات الدولة."));
      }
    } else {
      emit(CountryError(response.message));
    }
  }
}