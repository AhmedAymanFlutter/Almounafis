import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/repo/city_repo_tour.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_state.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_cubit.dart';
import 'upcoming_tour_card.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingTourList extends StatelessWidget {
  final bool provideCubit;

  const UpcomingTourList({super.key, this.provideCubit = true});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    if (!provideCubit) {
      return _buildList(context, isArabic);
    }

    return BlocProvider(
      create: (_) =>
          CityTourCubit(repository: CityTourRepository())..getAllCities(),
      child: _buildList(context, isArabic),
    );
  }

  Widget _buildList(BuildContext context, bool isArabic) {
    return BlocBuilder<CityTourCubit, CityTourState>(
      builder: (context, state) {
        if (state is CityTourLoading) {
          return Skeletonizer(
            enabled: true,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 110.w,
                      height: 130.h,
                      margin: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              width: 150.w,
                              height: 16.h,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: 100.w,
                              height: 12.h,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is CityTourError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isArabic
                      ? 'حدث خطأ: ${state.message}'
                      : 'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CityTourCubit>().getAllCities();
                  },
                  label: Text(
                    isArabic ? 'إعادة المحاولة' : 'Retry',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is CityTourEmpty) {
          return Center(
            child: Text(isArabic ? state.message : "No tours available"),
          );
        }

        final tours = state is CityTourFiltered
            ? state.filteredTours
            : (state is CityTourLoaded ? state.allCityTour.data ?? [] : []);

        if (tours.isEmpty) {
          return Center(
            child: Text(
              isArabic ? "لم يتم العثور على جولات" : "No tours found",
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: tours.length,
          itemBuilder: (context, index) {
            final tour = tours[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
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
        );
      },
    );
  }
}
