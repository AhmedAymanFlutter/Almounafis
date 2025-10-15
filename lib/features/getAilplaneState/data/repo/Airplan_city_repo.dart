import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';

import '../../../../core/network/api_endpoiont.dart';

class AirplaneCitsRepository {
  final APIHelper _apiHelper = APIHelper();

  // Get airplane cities from API
  Future<ApiResponse> getAirplaneCities() async {
    try {
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAirplaneCitys,
      );
      if (apiResponse.status) {
        if (apiResponse.data is List) {
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: apiResponse.data,
            message: 'تم تحميل مدن الطيران بنجاح',
          );
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
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }
}