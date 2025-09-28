import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/country_repo.dart';
import 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  final CountryRepository repository;

  CountryCubit(this.repository) : super(CountryInitial());

  Future<void> fetchAllCountries() async {
    emit(CountryLoading());
    
    print('🟡 بدء استدعاء API...');
    
    final response = await repository.getAllCountries();

    print('🔵 اكتمال استدعاء API');
    print('حالة الاستجابة: ${response.status}');
    print('رسالة الاستجابة: ${response.message}');
    print('نوع بيانات الاستجابة: ${response.data?.runtimeType}');
    
    if (response.status) {
      final allCountryData = response.data;
      print('🟢 نجاح API');
      print('AllCountryData: $allCountryData');
      
      if (allCountryData != null) {
        print('كائن البيانات: ${allCountryData.data}');
        print('قائمة الدول: ${allCountryData.data?.countries}');
        print('طول قائمة الدول: ${allCountryData.data?.countries?.length}');
        
        if (allCountryData.data?.countries?.isNotEmpty == true) {
          print('✅ تم العثور على ${allCountryData.data!.countries!.length} دولة');
          emit(CountryLoaded(allCountryData.data!.countries!));
        } else {
          print('❌ قائمة الدول فارغة أو غير موجودة');
          emit(const CountryError("لم يتم العثور على دول في الاستجابة."));
        }
      } else {
        print('❌ بيانات الدولة كلها فارغة');
        emit(const CountryError("تم استلام بيانات فارغة من API."));
      }
    } else {
      print('🔴 فشل API: ${response.message}');
      emit(CountryError(response.message));
    }
  }
}