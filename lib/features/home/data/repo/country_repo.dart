import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import '../model/getAllcountry.dart' show GetAllcountry;

class CountryRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getAllCountries() async {
    try {
      print('🌐 جاري إجراء استدعاء API لنقطة النهاية countries...');
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllCountries,
        isAuthorized: false, // Countries endpoint might not require authentication
      );

      print('🔍 تحليل استجابة API النهائية:');
      print('- الحالة: ${apiResponse.status}');
      print('- رمز الحالة: ${apiResponse.statusCode}');
      print('- الرسالة: ${apiResponse.message}');
      print('- نوع البيانات: ${apiResponse.data?.runtimeType}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          print('🔍 Processing API response data...');
          print('Response data keys: ${responseData.keys}');
          
          // تصحيح البيانات قبل التحويل
          try {
            // Now responseData should contain the full API response structure
            // {success, message, data: {countries, total, filters, pagination}, seoPage}
            final allCountryData = GetAllcountry.fromJson(responseData);
            
            print('🏁 بيانات الدول بعد fromJson:');
            print('- allCountryData: $allCountryData');
            print('- allCountryData.success: ${allCountryData.success}');
            print('- allCountryData.message: ${allCountryData.message}');
            print('- allCountryData.data: ${allCountryData.data}');
            print('- allCountryData.data?.countries: ${allCountryData.data?.countries}');
            print('- طول allCountryData.data?.countries: ${allCountryData.data?.countries?.length}');
            
            if (allCountryData.data?.countries?.isNotEmpty == true) {
              print('✅ Countries loaded successfully: ${allCountryData.data!.countries!.length} countries');
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allCountryData,
                message: 'تم تحميل الدول بنجاح',
              );
            } else {
              print('❌ No countries found after parsing');
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد دول متاحة بعد التحليل',
              );
            }
          } catch (e) {
            print('💥 استثناء في fromJson: $e');
            print('💥 تتبع الاستثناء: ${e.toString()}');
            print('💥 Stack trace: ${StackTrace.current}');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل البيانات: $e',
            );
          }
        } else {
          print('❌ Response data is not a Map: ${apiResponse.data.runtimeType}');
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح تم استلامه',
          );
        }
      } else {
        print('❌ API response status is false: ${apiResponse.message}');
        return ApiResponse(
          status: false,
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
      }
    } catch (e) {
      print('💥 استثناء في المستودع: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }
}