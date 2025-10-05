import 'package:almonafs_flutter/features/servicepackadge/data/model/getAllcountry.dart' show ServicesModel;
import 'package:dio/dio.dart';

class ServicesRepository {
  final Dio dio;

  ServicesRepository({required this.dio});

  Future<ServicesModel> getServices({
    int page = 1,
    int limit = 10,
    bool? isFeatured,
    bool? isActive,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };

      if (isFeatured != null) {
        queryParams['isFeatured'] = isFeatured;
      }

      if (isActive != null) {
        queryParams['isActive'] = isActive;
      }

      final response = await dio.get(
        '/services',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ServicesModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Server error: ${e.response!.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to load services: $e');
    }
  }

  Future<ServicesModel> getFeaturedServices() async {
    return getServices(isFeatured: true, isActive: true);
  }

  Future<ServicesModel> getActiveServices() async {
    return getServices(isActive: true);
  }
}