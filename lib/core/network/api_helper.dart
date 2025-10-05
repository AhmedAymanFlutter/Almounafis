import 'package:almonafs_flutter/core/network/local_data.dart' show LocalData;
import 'package:dio/dio.dart';

import 'api_endpoiont.dart';
import 'api_response.dart';

class APIHelper {
  // singleton
  static final APIHelper _apiHelper = APIHelper._internal();

  factory APIHelper() {
    return _apiHelper;
  }

  APIHelper._internal();

  // declaring dio
  Dio dio = Dio(BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: Duration(seconds: 20),
      sendTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20)));

  // GET request مبسط
 Future<ApiResponse> getRequest({
  required String endPoint,
  String? resourcePath,
  Map<String, dynamic>? data,
  Map<String, dynamic>? queryParameters,
  bool isFormData = true,
  bool isProtected = false,
  bool sendRefreshToken = false,
}) async {
  try {
    final String finalEndpoint = resourcePath != null && resourcePath.isNotEmpty
        ? '$endPoint/$resourcePath'
        : endPoint;

    print('🌐 Full URL: ${dio.options.baseUrl}$finalEndpoint');

    final response = await dio.get(
      finalEndpoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {},
        validateStatus: (status) {
          // ✅ قبول جميع الحالات لنتمكن من معالجتها
          return status != null && status < 600;
        },
      ),
    );

    return ApiResponse.fromResponse(response);
  } catch (e) {
    print('❌ API Error: $e');
    return ApiResponse.fromError(e);
  }
}

  // PUT request
  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(headers: {
          if (isAuthorized) "Authorization": "Bearer ${LocalData.accessToken}"
        }),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  // DELETE request
  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: Options(headers: {
          if (isAuthorized) "Authorization": "Bearer ${LocalData.accessToken}"
        }),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}