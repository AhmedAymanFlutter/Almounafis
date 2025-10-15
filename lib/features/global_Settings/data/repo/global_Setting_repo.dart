import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/features/global_Settings/data/model/global_Setting_model.dart';

class GlobalSettingsRepository {
  final APIHelper _apiHelper = APIHelper();

  // Get global settings from API
  Future<ApiResponse> getGlobalSettings() async {
    try {
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getGlobalSettings,
      );
      
      if (apiResponse.status) {
        // The API returns a Map with 'success' and 'data' fields
        if (apiResponse.data is Map<String, dynamic>) {
          final globalSettings = GlobalSettingModel.fromJson(apiResponse.data);
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: globalSettings,
            message: 'تم تحميل الإعدادات العامة بنجاح',
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