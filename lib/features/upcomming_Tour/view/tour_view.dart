import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/repo/city_repo_tour.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_state.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_cubit.dart';
import 'upcoming_tour_card.dart';

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
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(16),
                height: 87,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  title: Container(
                    width: 100,
                    height: 12,
                    color: Colors.grey.shade300,
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.only(top: 8),
                    width: 150,
                    height: 10,
                    color: Colors.grey.shade300,
                  ),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            : (state is CityTourLoaded
                ? state.allCityTour.data ?? []
                : []);

        if (tours.isEmpty) {
          return Center(
            child: Text(
                isArabic ? "لم يتم العثور على جولات" : "No tours found"),
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
                tag: tour.tags?.join(", ") ??
                    (isArabic ? "غير متوفر" : "N/A"),
              ),
            );
          },
        );
      },
    );
  }
}
