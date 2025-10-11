import 'package:equatable/equatable.dart';

import '../data/model/package_model.dart';

abstract class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object?> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final PackageModel packageModel;

  const PackageLoaded(this.packageModel);

  @override
  List<Object?> get props => [packageModel];
}

class CountriesLoading extends PackageState {}

class CountriesLoaded extends PackageState {
  final Map<String, dynamic> countriesData;

  const CountriesLoaded(this.countriesData);

  @override
  List<Object?> get props => [countriesData];
}

class PackagesLoading extends PackageState {}

class PackagesLoaded extends PackageState {
  final Map<String, dynamic> packagesData;

  const PackagesLoaded(this.packagesData);

  @override
  List<Object?> get props => [packagesData];
}

class PackageDetailsLoading extends PackageState {}

class PackageDetailsLoaded extends PackageState {
  final PackageModel packageDetails;

  const PackageDetailsLoaded(this.packageDetails);

  @override
  List<Object?> get props => [packageDetails];
}

class PackageError extends PackageState {
  final String message;

  const PackageError(this.message);

  @override
  List<Object?> get props => [message];
}