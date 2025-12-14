import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart';

class CityTourRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getAllcityTours() async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllcityTours,
      );

      if (apiResponse.status) {
        // Handle List response (API returns array of tours directly)
        if (apiResponse.data is List) {
          final List<dynamic> toursListData = apiResponse.data as List;

          try {
            // Parse each tour from the list
            final tours = toursListData
                .map(
                  (item) => CityTourData.fromJson(item as Map<String, dynamic>),
                )
                .toList();

            // Create AllCityTour wrapper with the tours
            final allCityTour = AllCityTour();

            if (tours.isNotEmpty) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allCityTour,
                message: 'تم تحميل الجولات بنجاح',
              );
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
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل البيانات: $e',
            );
          }
        }
        // Handle Map response (API returns object with nested data)
        else if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;

          try {
            final allCityTour = AllCityTour.fromJson(responseData);

            if (allCityTour.data?.isNotEmpty == true) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allCityTour,
                message: 'تم تحميل الجولات بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد جولات متاحة',
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
            message:
                'هيكل بيانات غير صالح: نوع ${apiResponse.data.runtimeType}',
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

  Future<ApiResponse> getCityTourDetails(String tourIdOrSlug) async {
    try {
      print('🌐 Fetching city tour: $tourIdOrSlug');

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: 'city-tours',
        resourcePath: tourIdOrSlug,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');
      print('📥 Response Data Type: ${apiResponse.data.runtimeType}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;

          try {
            // التحقق من وجود data في الاستجابة
            if (responseData.containsKey('data')) {
              final tourData = CityTourData.fromJson(
                responseData['data'] as Map<String, dynamic>,
              );

              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: tourData,
                message: 'تم تحميل تفاصيل الجولة بنجاح',
              );
            } else {
              // إذا كانت البيانات مباشرة بدون data wrapper
              final tourData = CityTourData.fromJson(responseData);

              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: tourData,
                message: 'تم تحميل تفاصيل الجولة بنجاح',
              );
            }
          } catch (e) {
            print('❌ Parsing Error: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل بيانات الجولة: $e',
            );
          }
        } else {
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح',
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
}
