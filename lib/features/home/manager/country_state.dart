import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';
import 'package:almonafs_flutter/features/singel_country/data/model/country_details_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';
import 'package:equatable/equatable.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryData> countries;
  const CountryLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}

class CountryError extends CountryState {
  final String message;
  const CountryError(this.message);

  @override
  List<Object> get props => [message];
}

// ✅ Add this new state
class SingleCountryLoading extends CountryState {}

class SingleCountryLoaded extends CountryState {
  final CountryDetailsData country;
  final CityGuideResponse? guideResponse;
  final List<dynamic>? packages;

  const SingleCountryLoaded(this.country, {this.guideResponse, this.packages});

  @override
  List<Object?> get props => [country, guideResponse, packages];
}

class SingleCountryError extends CountryState {
  final String message;
  const SingleCountryError(this.message);

  @override
  List<Object> get props => [message];
}

class CountryFiltered extends CountryState {
  final List<CountryData> filteredCountries;
  const CountryFiltered(this.filteredCountries);

  @override
  List<Object> get props => [filteredCountries];
}
