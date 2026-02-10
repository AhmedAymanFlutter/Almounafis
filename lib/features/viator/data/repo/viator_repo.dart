import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/features/viator/data/model/viator_tour_model.dart';

class ViatorRepository {
  final APIHelper _apiHelper = APIHelper();

  Future<ApiResponse> getTours({
    String? search,
    String? city,
    double? minRating,
    String? cancellationType,
    String? sort,
    int page = 1,
    int limit = 10,
    String lang = 'en',
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        'page': page.toString(),
        'limit': limit.toString(),
        'lang': lang,
      };

      if (search != null && search.isNotEmpty)
        queryParameters['search'] = search;
      if (city != null && city.isNotEmpty) queryParameters['city'] = city;
      if (minRating != null)
        queryParameters['minRating'] = minRating.toString();
      if (cancellationType != null && cancellationType.isNotEmpty) {
        queryParameters['cancellationType'] = cancellationType;
      }
      if (sort != null && sort.isNotEmpty) queryParameters['sort'] = sort;

      print('🌐 API Call: ${EndPoints.viatorTours}');
      print('📝 Params: $queryParameters');

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.viatorTours,
        queryParameters: queryParameters,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          try {
            final viatorResponse = ViatorTourResponse.fromJson(
              apiResponse.data,
            );
            return ApiResponse(
              status: true,
              statusCode: apiResponse.statusCode,
              data: viatorResponse,
              message: 'Successfully fetched tours',
            );
          } catch (e) {
            print('❌ Parsing Error (Viator Tours): $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'Error parsing tour data: $e',
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
      print('❌ Repository Error (Viator Tours): $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'Repository error: $e',
      );
    }
  }

  Future<ApiResponse> getTourDetails(
    String productCodeOrSlug, {
    String lang = 'en',
  }) async {
    try {
      final queryParameters = {'lang': lang};
      final String endPoint = '${EndPoints.viatorTours}/$productCodeOrSlug';
      print('🌐 API Call: $endPoint');
      print('📝 Params: $queryParameters');

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: endPoint,
        queryParameters: queryParameters,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          try {
            // The response structure for details might have "data" field directly containing the tour
            // checking the recursive structure.
            final data = apiResponse.data['data'];
            if (data != null) {
              final tour = ViatorTour.fromJson(data);
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: tour,
                message: 'Successfully fetched tour details',
              );
            } else {
              // Fallback if structure is different or flat
              final tour = ViatorTour.fromJson(apiResponse.data);
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: tour,
                message: 'Successfully fetched tour details',
              );
            }
          } catch (e) {
            print('❌ Parsing Error (Viator Tour Details): $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'Error parsing tour details: $e',
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
      print('❌ Repository Error (Viator Tour Details): $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'Repository error: $e',
      );
    }
  }
}
