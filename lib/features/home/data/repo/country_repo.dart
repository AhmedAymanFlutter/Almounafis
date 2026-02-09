import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart'
    show GetAllCountriesModel;
import '../../../singel_country/data/model/country_details_model.dart';
import '../../../cities/data/model/city_guide_model.dart';

class CountryRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getAllCountries() async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.countries,
        isFormData: false,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final countryResponse = GetAllCountriesModel.fromJson(
            apiResponse.data,
          );
          try {
            final allCountryData = countryResponse;

            if (allCountryData.countries!.isNotEmpty) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allCountryData,
                message: 'تم تحميل الدول بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد دول متاحة بعد التحليل',
              );
            }
          } catch (e) {
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل البيانات: $e',
            );
          }
        } else {
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح تم استلامه',
          );
        }
      } else {
        return ApiResponse(
          status: false,
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
      }
    } catch (e) {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  Future<ApiResponse> getCountry(String countryId) async {
    try {
      print('🌐 API Call: ${EndPoints.countries}/$countryId');
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.countries,
        resourcePath: countryId,
      );
      print('📥 Response Status: ${apiResponse.statusCode}');
      print('📥 Response Data: ${apiResponse.data}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;

          try {
            final countryResponse = CountryDetailsResponse.fromJson(
              responseData,
            );

            return ApiResponse(
              status: true,
              statusCode: apiResponse.statusCode,
              data: countryResponse.data, // Return CountryDetailsData
              message: 'تم تحميل بيانات الدولة بنجاح',
            );
          } catch (e) {
            print('❌ Parsing Error: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل بيانات الدولة: $e',
            );
          }
        } else {
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح تم استلامه',
          );
        }
      } else {
        return ApiResponse(
          status: false,
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
      }
    } catch (e) {
      print('❌ Repository Error: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  Future<CityGuideResponse> fetchCountryGuide(
    String slug, {
    String lang = 'en',
  }) async {
    try {
      print('🌐 API Call: ${EndPoints.tourGuides}/$slug?lang=$lang');
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.tourGuides}/$slug',
        queryParameters: {'lang': lang},
      );

      if (response.status && response.data is Map<String, dynamic>) {
        return CityGuideResponse.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      print('❌ Error fetching country guide: $e');
      rethrow;
    }
  }

  Future<List<dynamic>> fetchCountryPackages(String slug) async {
    try {
      print(
        '🌐 API Call: ${EndPoints.countries}/$slug/packages?packageType=international-tour-packages',
      );
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.countries}/$slug/packages',
        queryParameters: {'packageType': 'international-tour-packages'},
      );

      print('📦 Packages Response: ${response.data}');

      if (response.status) {
        if (response.data is Map<String, dynamic> &&
            response.data.containsKey('data')) {
          final data = response.data['data'];
          if (data is List) return data;
          if (data is Map && data.containsKey('packages'))
            return data['packages'] ?? [];
          return [];
        } else if (response.data is List) {
          return response.data;
        }
      }
      return [];
    } catch (e) {
      print('❌ Error fetching country packages: $e');
      return [];
    }
  }
}
