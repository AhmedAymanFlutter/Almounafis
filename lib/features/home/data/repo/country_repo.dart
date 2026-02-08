import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart'
    show GetAllCountriesModel;
import '../../../singel_country/data/model/country_details_model.dart';
import '../../../singel_country/data/model/tour_guide_model.dart';

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

  Future<ApiResponse> getTourGuides(String countrySlug) async {
    try {
      print('🌐 API Call: ${EndPoints.tourGuides}/$countrySlug');
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.tourGuides,
        resourcePath: countrySlug,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          try {
            final tourGuideResponse = TourGuideResponse.fromJson(
              apiResponse.data,
            );
            return ApiResponse(
              status: true,
              statusCode: apiResponse.statusCode,
              data: tourGuideResponse.data,
              message: 'Successfully fetched tour guide data',
            );
          } catch (e) {
            print('❌ Parsing Error (Tour Guides): $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'Error parsing tour guide data: $e',
            );
          }
        } else {
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'Invalid data structure received',
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
      print('❌ Repository Error (Tour Guides): $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'Repository error: $e',
      );
    }
  }
}
