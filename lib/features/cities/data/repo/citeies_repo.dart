import 'package:almonafs_flutter/core/network/api_helper.dart'; // Import your helper
import 'package:almonafs_flutter/core/network/api_response.dart'; // Import your ApiResponse class
import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_guide_model.dart';
import '../../../../core/network/api_endpoiont.dart';

class CityRepository {
  // Use the API Helper Singleton
  final APIHelper _apiHelper = APIHelper();

  Future<CityResponse> fetchCities({int page = 1, int limit = 10}) async {
    try {
      final ApiResponse response = await _apiHelper.getRequest(
        endPoint: EndPoints.cities,
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.data != null) {
        // Parse the JSON into your Model
        return CityResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }

  Future<CityDetailsResponse> fetchCityDetails(String idOrSlug) async {
    try {
      final ApiResponse response = await _apiHelper.getRequest(
        endPoint: "${EndPoints.cities}/$idOrSlug",
      );

      if (response.data != null) {
        return CityDetailsResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }

  /// Fetch cities by country ID
  Future<CityResponse> fetchCitiesByCountry(String countryId) async {
    try {
      final ApiResponse response = await _apiHelper.getRequest(
        endPoint: EndPoints.cities,
        queryParameters: {'country': countryId},
      );

      if (response.data != null) {
        return CityResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }

  /// Fetch city guide details (restaurants, places to visit, etc.)
  Future<CityGuideResponse> fetchCityGuide(
    String slug, {
    String lang = 'en',
  }) async {
    try {
      final ApiResponse response = await _apiHelper.getRequest(
        endPoint: "${EndPoints.tourGuides}/$slug",
        queryParameters: {'lang': lang},
      );

      if (response.data != null) {
        return CityGuideResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception("Repository Error: $e");
    }
  }
}
