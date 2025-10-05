import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart' show GetAllCountry;
import '../../../singel_country/data/model/get_Singel_city.dart';

class CountryRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getAllCountries() async {
    try {
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllCountries,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;

          try {
        
            final allCountryData = GetAllCountry.fromJson(responseData);
            
            if (allCountryData.data?.isNotEmpty == true) {
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
    print('🌐 API Call: ${EndPoints.getAllCountries}/$countryId');
    
    final ApiResponse apiResponse = await _apiHelper.getRequest(
      endPoint: EndPoints.getAllCountries,
      resourcePath: countryId, // ✅ استخدم resourcePath بدلاً من concatenation
    );

    print('📥 Response Status: ${apiResponse.statusCode}');
    print('📥 Response Data: ${apiResponse.data}');

    if (apiResponse.status) {
      if (apiResponse.data is Map<String, dynamic>) {
        final responseData = apiResponse.data as Map<String, dynamic>;

        try {
          final countryData = GetSingleCountry.fromJson(responseData);
          
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: countryData,
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
}}