import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_response.dart'; // عدّل المسار لو مختلف
import '../data/model/package_model.dart';
import '../data/repo/package_repo.dart';
import 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageTypeRepo packageRepo;

  PackageCubit(this.packageRepo) : super(PackageInitial());
// get all packages
  Future<void> getAllPackages() async {
    emit(PackageLoading());

    final ApiResponse response = await packageRepo.getAllpackage();

    if (response.status) {
      emit(PackageLoaded(response.data as PackageModel));
    } else {
      emit(PackageError(response.message));
    }
  }
 // get countries for package type
  Future<void> getCountriesForPackageType(String packageTypeId) async {
    emit(CountriesLoading());

    final ApiResponse response =
        await packageRepo.getCountriesForPackageType(packageTypeId);

    if (response.status) {
      emit(CountriesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }
  // get packages for country
  Future<void> getPackagesForCountry(String countryId) async {
    emit(PackagesLoading());

    final ApiResponse response = await packageRepo.getPackagesForCountry(countryId);

    if (response.status) {
      emit(PackagesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }

  // get package details
   Future<void> getPackageDetails(String packageId) async {
    emit(PackageDetailsLoading());

    final ApiResponse response = await packageRepo.getPackageDetails(packageId);

    if (response.status) {
      emit(PackageDetailsLoaded(response.data as PackageModel));
    } else {
      emit(PackageError(response.message));
    }
  }
}

