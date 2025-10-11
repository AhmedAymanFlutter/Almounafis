import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import '../model/city_tour.dart';

class HotelRepository {
  final APIHelper _apiHelper = APIHelper();

  // Get all hotels
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
          print('📊 Full Response: $responseData');

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
                message: 'تم تحميل الفنادق بنجاح',
              );
            } else {
              print('❌ No hotels available after parsing');
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد فنادق متاحة بعد التحليل',
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

  // Get single hotel details by ID
  Future<ApiResponse> getHotelDetails(String hotelId) async {
    try {
      print('🔍 Fetching hotel details for ID: $hotelId');
      
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllHotels,
        resourcePath: hotelId,
      );

      print('📦 Hotel Details Response Status: ${apiResponse.status}');
      print('📦 Hotel Details Response Code: ${apiResponse.statusCode}');
      
      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          try {
            // Check if response has 'data' field with single hotel object
            if (responseData.containsKey('data') && responseData['data'] != null) {
              final hotelData = Data.fromJson(responseData['data']);
              
              print('✅ Successfully loaded hotel: ${hotelData.name}');
              
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: hotelData,
                message: 'تم تحميل تفاصيل الفندق بنجاح',
              );
            } else {
              // If the response is directly the hotel object
              final hotelData = Data.fromJson(responseData);
              
              print('✅ Successfully loaded hotel: ${hotelData.name}');
              
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: hotelData,
                message: 'تم تحميل تفاصيل الفندق بنجاح',
              );
            }
          } catch (e) {
            print('❌ Error parsing hotel details: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل تفاصيل الفندق: $e',
            );
          }
        } else {
          print('❌ Invalid data structure for hotel details');
          return ApiResponse(
            status: false,
            statusCode: apiResponse.statusCode,
            message: 'هيكل بيانات غير صالح لتفاصيل الفندق',
          );
        }
      } else {
        print('❌ API returned error for hotel details: ${apiResponse.message}');
        return ApiResponse(
          status: false,
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
      }
    } catch (e) {
      print('❌ Repository error getting hotel details: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في الحصول على تفاصيل الفندق: $e',
      );
    }
  }

  // Get featured hotels
  Future<ApiResponse> getFeaturedHotels({int limit = 6}) async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: '${EndPoints.getAllHotels}/featured',
        queryParameters: {'limit': limit},
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          try {
            final allHotelData = GitHotelModel.fromJson(responseData);
            
            if (allHotelData.data?.isNotEmpty == true) {
              print('✅ Successfully loaded ${allHotelData.data!.length} featured hotels');
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allHotelData,
                message: 'تم تحميل الفنادق المميزة بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد فنادق مميزة متاحة',
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

  // Get hotels by city
  Future<ApiResponse> getHotelsByCity(String cityId) async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: '${EndPoints.getAllHotels}/city/$cityId',
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          try {
            final allHotelData = GitHotelModel.fromJson(responseData);
            
            if (allHotelData.data?.isNotEmpty == true) {
              print('✅ Successfully loaded ${allHotelData.data!.length} hotels for city');
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allHotelData,
                message: 'تم تحميل فنادق المدينة بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد فنادق في هذه المدينة',
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

  // Search hotels with filters
  Future<ApiResponse> searchHotels({
    String? cityId,
    double? minPrice,
    double? maxPrice,
    int? rating,
    String? amenities,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (cityId != null) queryParams['city'] = cityId;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
      if (rating != null) queryParams['rating'] = rating;
      if (amenities != null) queryParams['amenities'] = amenities;
      if (sort != null) queryParams['sort'] = sort;

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getAllHotels,
        queryParameters: queryParams,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;
          
          try {
            final allHotelData = GitHotelModel.fromJson(responseData);
            
            return ApiResponse(
              status: true,
              statusCode: apiResponse.statusCode,
              data: allHotelData,
              message: 'تم البحث بنجاح',
            );
          } catch (e) {
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل نتائج البحث: $e',
            );
          }
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
        message: 'خطأ في البحث: $e',
      );
    }
  }
}