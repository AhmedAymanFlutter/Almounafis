import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart';
import 'package:flutter/material.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../localization/manager/localization_cubit.dart';
import 'upcoming_tour_card.dart';

class UpcomingToursScreen extends StatefulWidget {
  const UpcomingToursScreen({super.key});

  @override
  State<UpcomingToursScreen> createState() => _UpcomingToursScreenState();
}

class _UpcomingToursScreenState extends State<UpcomingToursScreen> {
  final _api = APIHelper();
  late Future<ApiResponse> _futureTours;

  @override
  void initState() {
    super.initState();
    _futureTours = _api.getRequest(endPoint: "city-tours");
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.mainWhite,
      body: FutureBuilder<ApiResponse>(
        future: _futureTours,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 220.h,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer(
                        color: Colors.grey.shade400,
                        colorOpacity: 0.3,
                        enabled: true,
                        child: Container(
                          width: 300.w,
                          height: 87.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                isArabic ? 'خطأ: ${snapshot.error}' : "Error: ${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                isArabic ? 'لا توجد بيانات متاحة' : "No data available",
              ),
            );
          }

          final response = snapshot.data!;
          if (!response.status) {
            return Center(
              child: Text(
                response.message,
                textAlign: TextAlign.center,
              ),
            );
          }

          List<Data> tours = [];
          try {
            if (response.data is List) {
              final List<dynamic> toursData = response.data as List;
              tours = toursData
                  .map((item) => Data.fromJson(item as Map<String, dynamic>))
                  .toList();
            } else if (response.data is Map<String, dynamic>) {
              final allCityTour = AllCityTour.fromJson(response.data);
              tours = allCityTour.data ?? [];
            } else {
              return Center(
                child: Text(
                  isArabic 
                    ? "نوع بيانات غير متوقع: ${response.data.runtimeType}"
                    : "Unexpected data type: ${response.data.runtimeType}",
                  textAlign: TextAlign.center,
                ),
              );
            }
          } catch (e) {
            return Center(
              child: Text(
                isArabic ? "خطأ في التحليل: $e" : "Parse error: $e",
                textAlign: TextAlign.center,
              ),
            );
          }

          if (tours.isEmpty) {
            return Center(
              child: Text(
                isArabic ? "لم يتم العثور على جولات" : "No tours found",
              ),
            );
          }

          return SizedBox(
            height: 600.h,
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: tours.length,
              itemBuilder: (context, index) {
                final tour = tours[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: UpcomingTourCard(
                      tour: tour,                    
                      title: isArabic
                          ? tour.titleAr ?? "لا يوجد عنوان"
                          : tour.title ?? "No title",
                      subtitle: isArabic
                          ? tour.descriptionArFlutter ?? "لا يوجد وصف"
                          : tour.descriptionFlutter ?? "No description",
                      imageUrl: tour.coverImage.toString(),
                      tag: tour.tags?.join(", ") ?? (isArabic ? "غير متوفر" : "N/A"),
),

                );
              },
            ),
          );
        },
      ),
    );
  }
}