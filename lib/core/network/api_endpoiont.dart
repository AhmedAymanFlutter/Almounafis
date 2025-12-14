abstract class EndPoints {
  static const String baseUrl = 'https://api.almounafies.com/api/';
  static const String countries = '/countries';
  static const String getPopularTours = 'tours/popular';
  static const String refreshToken = 'refresh_token';
  static const String getAllHotels = 'hotels';
  static const String getAllcityTours = '${EndPoints.baseUrl}city-tours';
  static const String getAirplaneCitys = 'flight-bookings/get-cities';
  static const String getPackageType = 'package-types';
  static const String getAllAirLines = 'airlines';
  static const String bookFlight = 'flight-bookings';
  static const String getGlobalSettings = 'global-settings';
}
