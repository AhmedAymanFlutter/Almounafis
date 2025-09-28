
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

  // get request

  Future<ApiResponse> getRequest(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      bool isAuthorized = false}) async {
    try {
      print('🌐 Making GET request to: ${dio.options.baseUrl}$endPoint');
      print('🔑 Authorization required: $isAuthorized');
      print('🔑 Access token: ${LocalData.accessToken}');
      
      var response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (isAuthorized && LocalData.accessToken != null) 
              "Authorization": "Bearer ${LocalData.accessToken}"
          }
        )
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      print('❌ GET request error: $e');
      return ApiResponse.fromError(e);
    }
  }

  // post

  Future<ApiResponse> postRequest(
      {required String endPoint,
        Map<String, dynamic>? data,
        bool isFormData = true,
        bool isAuthorized = true}) async {
    try {
      var response = await dio.post(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          options: Options(headers: {
            if (isAuthorized) "Authorization": "Bearer ${LocalData.accessToken}"
          }));
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
  Future<ApiResponse> putRequest(
      {required String endPoint,
        Map<String, dynamic>? data,
        bool isFormData = true,
        bool isAuthorized = true}) async {
    try {
      var response = await dio.put(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          options: Options(headers: {
            if (isAuthorized) "Authorization": "Bearer ${LocalData.accessToken}"
          }));
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest(
      {required String endPoint,
        Map<String, dynamic>? data,
        bool isFormData = true,
        bool isAuthorized = true}) async {
    try {
      var response = await dio.delete(endPoint,
          data: isFormData ? FormData.fromMap(data ?? {}) : data,
          options: Options(headers: {
            if (isAuthorized) "Authorization": "Bearer ${LocalData.accessToken}"
          }));
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}

