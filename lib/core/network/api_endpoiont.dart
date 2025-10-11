abstract class EndPoints {
  static const String baseUrl =
      'http://192.168.1.4:6000/api/v1/';
  static const String getAllCountries = 'countries';
  static const String countries = 'countries';
  static const String getPopularTours = 'tours/popular';
  static const String refreshToken = 'refresh_token';
  static const String getAllHotels = 'hotels';
  static const String getAllcityTours = '${EndPoints.baseUrl}city-tours';
  
  static const String getPackageType =  'package-types';
  static const String getAllAirLines = 'airlines';
}

