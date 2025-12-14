import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/package_model.dart';
import '../data/repo/package_repo.dart';
import 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageTypeRepo packageRepo;

  PackageCubit(this.packageRepo) : super(PackageInitial());

  Future<void> getAllPackages() async {
    emit(PackageLoading());
    final response = await packageRepo.getAllpackage();
    if (isClosed) return;

    if (response.status) {
      emit(PackageLoaded(response.data as PackageModel));
    } else {
      emit(PackageError(response.message));
    }
  }

  Future<void> getCountriesForPackageType(String packageTypeId) async {
    emit(CountriesLoading());
    final response = await packageRepo.getCountriesForPackageType(packageTypeId);
    if (isClosed) return;

    if (response.status) {
      emit(CountriesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }

  Future<void> getPackagesForCountry(String countryId) async {
    emit(PackagesLoading());
    final response = await packageRepo.getPackagesForCountry(countryId);
    if (isClosed) return;

    if (response.status) {
      emit(PackagesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }

  Future<void> getPackageDetails(String packageId) async {
    emit(PackageDetailsLoading());
    final response = await packageRepo.getPackageDetails(packageId);
    if (isClosed) return;

    if (response.status) {
      emit(PackageDetailsLoaded(response.data as PackageModel));
    } else {
      emit(PackageError(response.message));
    }
  }
}


