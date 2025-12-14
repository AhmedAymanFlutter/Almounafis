import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/features/flightScreen/data/model/AirLine_data.dart';

class AirlineRepository {
  final APIHelper _apiHelper = APIHelper();

  // ✅ Get airlines from API and Parse them
  Future<ApiResponse> getAllAirlines() async {
    try {
      // Make sure 'airlines' is defined in your EndPoints class
      // e.g., static const String airlines = '/airlines';
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllAirLines,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          try {
            // ✅ Parse JSON into AirLineModel
            final airlineModel = AirLineModel.fromJson(apiResponse.data);

            if (airlineModel.data != null && airlineModel.data!.isNotEmpty) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: airlineModel, // Return the parsed model
                message: 'Airlines fetched successfully',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'No airlines available',
              );
            }
          } catch (e) {
            print('❌ Parsing Error: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'Data parsing error: $e',
            );
          }
        } else {
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'Invalid data structure',
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
        message: 'Repository error: $e',
      );
    }
  }

  // --- Helper Methods for UI Filters ---

  List<String> getPassengerOptions(bool isArabic) {
    return isArabic
        ? ['أي', 'راكب واحد', 'راكبان', '3 ركاب', '4+ ركاب']
        : [
            'Any',
            '1 Passenger',
            '2 Passengers',
            '3 Passengers',
            '4+ Passengers',
          ];
  }

  List<String> getClassOptions(bool isArabic) {
    return isArabic
        ? ['أي', 'اقتصادي', 'رجال أعمال', 'الدرجة الأولى']
        : ['Any', 'Economy', 'Business', 'First Class'];
  }

  List<String> getDepartureTimeOptions(bool isArabic) {
    return isArabic
        ? [
            'أي وقت',
            'الصباح (00:00-12:00)',
            'الظهيرة (12:00-18:00)',
            'المساء (18:00-24:00)',
          ]
        : [
            'Any Time',
            'Morning (00:00-12:00)',
            'Afternoon (12:00-18:00)',
            'Evening (18:00-24:00)',
          ];
  }

  List<String> getArrivalTimeOptions(bool isArabic) {
    return isArabic
        ? [
            'أي وقت',
            'الصباح (00:00-12:00)',
            'الظهيرة (12:00-18:00)',
            'المساء (18:00-24:00)',
          ]
        : [
            'Any Time',
            'Morning (00:00-12:00)',
            'Afternoon (12:00-18:00)',
            'Evening (18:00-24:00)',
          ];
  }
}
