import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/country_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepository repository;

  CountryCubit(this.repository) : super(CountryInitial());

  Future<void> fetchAllCountries() async {
    if (isClosed) return; // ✅ prevent emits on closed cubit
    emit(CountryLoading());

    try {
      final response = await repository.getAllCountries();
      if (isClosed) return; // ✅ check again after await

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
    } catch (e) {
      if (!isClosed) emit(CountryError("حدث خطأ أثناء تحميل الدول: $e"));
    }
  }

  Future<void> fetchCountryDetails(String countryIdOrSlug) async {
    if (isClosed) return;
    emit(SingleCountryLoading());

    try {
      final response = await repository.getCountry(countryIdOrSlug);
      if (isClosed) return;

      if (response.status) {
        final countryData = response.data;
        if (countryData != null && countryData.data != null) {
          emit(SingleCountryLoaded(countryData.data!));
        } else {
          emit(const SingleCountryError("لم يتم العثور على بيانات الدولة."));
        }
      } else {
        emit(SingleCountryError(response.message));
      }
    } catch (e) {
      if (!isClosed) emit(SingleCountryError("حدث خطأ أثناء تحميل الدولة: $e"));
    }
  }
}
