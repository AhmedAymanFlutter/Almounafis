import 'package:almonafs_flutter/core/network/api_endpoiont.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';

class FlightFilterRepository {
  final APIHelper _apiHelper = APIHelper();

  // Get airlines from API
  Future<ApiResponse> getAirlines() async {
    try {
      print('🌐 API Call: /airlines');
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllAirLines,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: apiResponse.data,
            message: 'تم تحميل شركات الطيران بنجاح',
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
      print('❌ Repository Error: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }
  List<String> getPassengerOptions(bool isArabic) {
    return isArabic
        ? ['أي', 'راكب واحد', 'راكبان', '3 ركاب', '4+ ركاب']
        : ['Any', '1 Passenger', '2 Passengers', '3 Passengers', '4+ Passengers'];
  }

  List<String> getClassOptions(bool isArabic) {
    return isArabic
        ? ['أي', 'اقتصادي', 'رجال أعمال', 'الدرجة الأولى']
        : ['Any', 'Economy', 'Business', 'First Class'];
  }

  List<String> getDepartureTimeOptions(bool isArabic) {
    return isArabic
        ? ['أي وقت', 'الصباح (00:00-12:00)', 'الظهيرة (12:00-18:00)', 'المساء (18:00-24:00)']
        : ['Any Time', 'Morning (00:00-12:00)', 'Afternoon (12:00-18:00)', 'Evening (18:00-24:00)'];
  }

  List<String> getArrivalTimeOptions(bool isArabic) {
    return isArabic
        ? ['أي وقت', 'الصباح (00:00-12:00)', 'الظهيرة (12:00-18:00)', 'المساء (18:00-24:00)']
        : ['Any Time', 'Morning (00:00-12:00)', 'Afternoon (12:00-18:00)', 'Evening (18:00-24:00)'];
  }

  List<String> getFilterOptions(String filterType, bool isArabic) {
    switch (filterType) {
      case 'Passengers':
        return getPassengerOptions(isArabic);
      case 'Class':
        return getClassOptions(isArabic);
      case 'DepartureTime':
        return getDepartureTimeOptions(isArabic);
      case 'ArrivalTime':
        return getArrivalTimeOptions(isArabic);
      default:
        return [];
    }
  }
}
