import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/package_model.dart';
import '../data/model/package_details_model.dart';
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

  Future<void> getCountriesForPackageType(String slug) async {
    emit(CountriesLoading());
    final response = await packageRepo.getCountriesForPackageType(slug);
    if (isClosed) return;

    if (response.status) {
      emit(CountriesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }

  Future<void> getPackagesForCountry(
    String countrySlug,
    String packageTypeSlug,
  ) async {
    emit(PackagesLoading());
    final response = await packageRepo.getPackagesForCountry(
      countrySlug,
      packageTypeSlug,
    );
    if (isClosed) return;

    if (response.status) {
      emit(PackagesLoaded(response.data as Map<String, dynamic>));
    } else {
      emit(PackageError(response.message));
    }
  }

  Future<void> getPackageDetails(String slug) async {
    emit(PackageDetailsLoading());
    final response = await packageRepo.getPackageDetails(slug);
    if (isClosed) return;

    if (response.status) {
      emit(PackageDetailsLoaded(response.data as PackageDetailsData));
    } else {
      emit(PackageError(response.message));
    }
  }
}
