import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/country_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepository repository;
  List<CountryData> allCountries = [];

  CountryCubit(this.repository) : super(CountryInitial());

  Future<void> fetchAllCountries() async {
    if (isClosed) return;
    emit(CountryLoading());

    try {
      final response = await repository.getAllCountries();
      if (isClosed) return;

      if (response.status) {
        final GetAllCountriesModel? model = response.data;
        if (model != null && model.countries?.isNotEmpty == true) {
          allCountries = model.countries!; // ✅ نحفظ الدول كلها
          emit(CountryLoaded(allCountries));
        } else {
          print("${response.message}");
          emit(CountryError(response.message));
        }
      } else {
        print("${response.message}");
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
        final countryData = response.data; // Already CountryDetailsData
        if (countryData != null) {
          emit(SingleCountryLoaded(countryData));
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

  /// دالة البحث المحلي
  void searchCountries(String query, bool isArabic) {
    print("🔍 Filtering countries by '$query'");
    print("📦 allCountries length = ${allCountries.length}");
    if (query.isEmpty) {
      emit(CountryLoaded(allCountries)); // رجّع كل الدول لو البحث فاضي
      return;
    }

    final filtered = allCountries.where((country) {
      final name = isArabic ? (country.nameAr ?? '') : (country.name ?? '');
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(CountryFiltered(filtered)); // emit حالة جديدة فيها النتائج
  }
}
