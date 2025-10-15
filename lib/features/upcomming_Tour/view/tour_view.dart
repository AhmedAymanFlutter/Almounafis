import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/repo/city_repo_tour.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_state.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_cubit.dart';
import 'upcoming_tour_card.dart';

class UpcomingTourList extends StatelessWidget {
  final bool provideCubit; // 👈 نتحكم هل نوفر cubit داخليًا ولا لأ

  const UpcomingTourList({super.key, this.provideCubit = true});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    // 👇 لو الصفحة الأب موفرة cubit جاهز، استخدمه
    if (!provideCubit) {
      return _buildList(context, isArabic);
    }

    // 👇 غير كده، نوفر cubit جديد داخليًا (زي في الصفحة الرئيسية)
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
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) => Shimmer(
              color: Colors.grey.shade400,
              colorOpacity: 0.3,
              enabled: true,
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 87,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        }

        if (state is CityTourError) {
          return Center(
            child: Text(isArabic
                ? 'خطأ: ${state.message}'
                : "Error: ${state.message}"),
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
            child: Text(isArabic
                ? "لم يتم العثور على جولات"
                : "No tours found"),
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
