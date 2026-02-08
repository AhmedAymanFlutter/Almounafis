import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import '../model/package_model.dart';
import '../model/package_details_model.dart';

class PackageTypeRepo {
  final APIHelper _apiHelper = APIHelper();

  // Step 1: Get all package types
  Future<ApiResponse> getAllpackage() async {
    try {
      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: EndPoints.getPackageType,
      );

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          final responseData = apiResponse.data as Map<String, dynamic>;

          try {
            final allPackageData = PackageModel.fromJson(responseData);

            if (allPackageData.data?.isNotEmpty == true) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: allPackageData,
                message: 'تم تحميل الباقات بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message: 'لا توجد باقات متاحة بعد التحليل',
              );
            }
          } catch (e) {
            print('❌ Parsing Error Step 1: $e');
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
      print('❌ Repository Error Step 1: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  // Step 2: Get countries for a specific package type
  Future<ApiResponse> getCountriesForPackageType(String slug) async {
    try {
      print('🌐 Step 2 - API Call: /package-types/$slug/countries');

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: '/countries?hasPackages=true&packageType=$slug',
        isProtected: true,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: apiResponse.data,
            message: 'تم تحميل الدول بنجاح',
          );
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
      print('❌ Repository Error Step 2: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  // Step 3: Get packages for a specific country
  Future<ApiResponse> getPackagesForCountry(
    String countrySlug,
    String packageTypeSlug,
  ) async {
    try {
      print(
        '🌐 Step 3 - API Call: /countries/$countrySlug/packages?packageType=$packageTypeSlug',
      );

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint:
            '/countries/$countrySlug/packages?packageType=$packageTypeSlug',
        isProtected: true,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          return ApiResponse(
            status: true,
            statusCode: apiResponse.statusCode,
            data: apiResponse.data,
            message: 'تم تحميل الباقات بنجاح',
          );
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
      print('❌ Repository Error Step 3: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }

  // Step 4: Get package details by Slug
  Future<ApiResponse> getPackageDetails(String slug) async {
    try {
      print('🔍 Step 4 - API Call: /packages/$slug');

      final ApiResponse apiResponse = await _apiHelper.getRequest(
        endPoint: '/packages/$slug',
        isProtected: true,
      );

      print('📥 Response Status: ${apiResponse.statusCode}');

      if (apiResponse.status) {
        if (apiResponse.data is Map<String, dynamic>) {
          try {
            final packageDetailsResponse = PackageDetailsResponse.fromJson(
              apiResponse.data,
            );

            if (packageDetailsResponse.success == true &&
                packageDetailsResponse.data != null) {
              return ApiResponse(
                status: true,
                statusCode: apiResponse.statusCode,
                data: packageDetailsResponse.data, // Return PackageDetailsData
                message:
                    packageDetailsResponse.message ??
                    'تم تحميل تفاصيل الباقة بنجاح',
              );
            } else {
              return ApiResponse(
                status: false,
                statusCode: apiResponse.statusCode,
                message:
                    packageDetailsResponse.message ??
                    'فشل في تحميل تفاصيل الباقة',
              );
            }
          } catch (e) {
            print('❌ Parsing Error Step 4: $e');
            return ApiResponse(
              status: false,
              statusCode: apiResponse.statusCode,
              message: 'خطأ في تحليل تفاصيل الباقة: $e',
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
      print('❌ Repository Error Step 4: $e');
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'خطأ في المستودع: $e',
      );
    }
  }
}
