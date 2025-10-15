import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';

import '../model/Flight_Booking_Request.dart';

abstract class FlightBookingRepository {
  Future<ApiResponse> submitBooking(FlightBookingRequest request); // ✅ Change parameter type
}

class FlightBookingRepositoryImpl implements FlightBookingRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<ApiResponse> submitBooking(FlightBookingRequest request) async {
    try {
      print('🛰 Sending booking request to: ${EndPoints.bookFlight}');
      
      // ✅ Use the request's toJson() directly
      final requestData = request.toJson();
      print('📦 Request data: $requestData');

      final ApiResponse apiResponse = await _apiHelper.postRequest(
        endPoint: EndPoints.bookFlight,
        data: requestData, // This now has the correct structure
        isAuthorized: true,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');
      print('📥 Response Data: ${apiResponse.data}');

      return _handleApiResponse(apiResponse);
    } catch (e) {
      print('❌ Repository Error: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  ApiResponse _handleApiResponse(ApiResponse apiResponse) {
    if (apiResponse.status) {
      // Handle success - you might want to create a response model
      return ApiResponse(
        status: true,
        statusCode: apiResponse.statusCode,
        data: apiResponse.data, // Or parse into a response model
        message: apiResponse.message,
      );
    } else {
      return ApiResponse(
        status: false,
        statusCode: apiResponse.statusCode,
        message: apiResponse.message,
      );
    }
  }
}