import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import '../model/city_tour.dart';

class HotelRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getAllHotels() async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllHotels,
      );

      print('📦 API Response Status: ${apiResponse.status}');
      print('📦 API Response Code: ${apiResponse.statusCode}');
      print('📦 API Response Message: ${apiResponse.message}');
      
      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          print('📊 Response Data Keys: ${responseData.keys}');
          print('📊 Full Response: $responseData'); // Be careful with large responses

          try {
            final allHotelData = GitHotelModel.fromJson(responseData);
            
            print('🏗️ Parsed Data: ${allHotelData.data}');
            print('🏛️ Hotels Count: ${allHotelData.data?.length ?? 0}');

            if (allHotelData.data?.isNotEmpty == true) {
              print('✅ Successfully loaded ${allHotelData.data!.length} hotels');
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allHotelData,
                message: 'تم تحميل الدول بنجاح',
              );
            } else {
              print('❌ No tours available after parsing');
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد دول متاحة بعد التحليل',
              );
            }
          } catch (e) {
            print('❌ Error parsing data: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل البيانات: $e',
            );
          }
        } else {
          print('❌ Invalid data structure received: ${apiResponse.data.runtimeType}');
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح تم استلامه',
          );
        }
      } else {
        print('❌ API returned error: ${apiResponse.message}');
        return ApiResponse(
          status: false,
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
      }
    } catch (e) {
      print('❌ Repository error: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }
}
  
  // Future<ApiResponse> getCountry(String countryId) async {
  //   try {
  //     final ApiResponse apiResponse = await _apiHelper.getRequest(
  //       endPoint: '${EndPoints.getAllCountries}/$countryId',
  //     );

  //     if (apiResponse.status) {
  //       if (apiResponse.data is Map<String, dynamic>) {
  //         final responseData = apiResponse.data as Map<String, dynamic>;

  //         try {
  //           final countryData = GetSingleCountry.fromJson(responseData);
            
  //           return ApiResponse(
  //             status: true,
  //             statusCode: apiResponse.statusCode,
  //             data: countryData,
  //             message: 'تم تحميل بيانات الدولة بنجاح',
  //           );
  //         } catch (e) {
  //           return ApiResponse(
  //             status: false,
  //             statusCode: apiResponse.statusCode,
  //             message: 'خطأ في تحليل بيانات الدولة: $e',
  //           );
  //         }
  //       } else {
  //         return ApiResponse(
  //           status: false,
  //           statusCode: apiResponse.statusCode,
  //           message: 'هيكل بيانات غير صالح تم استلامه',
  //         );
  //       }
  //     } else {
  //       return ApiResponse(
  //         status: false,
  //         statusCode: apiResponse.statusCode,
  //         message: apiResponse.message,
  //       );
  //     }
  //   } catch (e) {
  //     return ApiResponse(
  //       status: false,
  //       statusCode: 500,
  //       message: 'خطأ في المستودع: $e',
  //     );
  //   }
  // }
