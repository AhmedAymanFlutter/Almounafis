import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../upcomming_Tour/manager/tour_cubit.dart';
import '../../upcomming_Tour/manager/tour_state.dart';
import '../../upcomming_Tour/data/repo/city_repo_tour.dart';
import '../../upcomming_Tour/data/model/city_tour.dart'; // ✅ الموديل الصحيح
import '../../upcomming_Tour/view/upcoming_tour_card.dart';
import '../../localization/manager/localization_cubit.dart';

class AllToursPage extends StatelessWidget {
  AllToursPage({super.key});
  final TextEditingController searchAllToursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().isArabic;

    return BlocProvider(
      create: (_) =>
          CityTourCubit(repository: CityTourRepository())..getAllCities(),
      child: Scaffold(
        backgroundColor: AppColor.mainWhite,
        appBar: AppBar(
          title: Text(isArabic ? "كل الجولات القادمة" : "All Upcoming Tours"),
          backgroundColor: AppColor.mainWhite,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocBuilder<CityTourCubit, CityTourState>(
          builder: (context, state) {
            final isLoading = state is CityTourLoading;
            List<Data> tours = [];

            if (state is CityTourLoaded) {
              tours = state.allCityTour.data ?? [];
            } else if (state is CityTourFiltered) {
              tours = state.filteredTours;
            }

            // ✅ نستخدم كائنات Data فاضية بدلاً من Map
            if (isLoading) {
              tours = List.generate(5, (index) => Data());
            }

            return Column(
              children: [
                CustomSearchBar(
                  controller: searchAllToursController,
                  onChanged: (q) {
                    context.read<CityTourCubit>().searchTours(q, isArabic);
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: _buildToursList(tours, isArabic, isLoading),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildToursList(List<Data> tours, bool isArabic, bool isLoading) {
    if (!isLoading && tours.isEmpty) {
      return Center(
        child: Text(isArabic ? "لا توجد جولات مطابقة" : "No matching tours"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        final tour = tours[index];

        final title = isLoading
            ? (isArabic ? "جار التحميل..." : "Loading...")
            : (isArabic ? tour.titleAr ?? '' : tour.title ?? '');

        final subtitle = isLoading
            ? (isArabic ? "..." : "...")
            : (isArabic
                ? tour.descriptionArFlutter ?? ''
                : tour.descriptionFlutter ?? '');

        final imageUrl = isLoading ? "" : (tour.coverImage ?? '');
        final tag = isLoading ? "" : (tour.tags?.join(", ") ?? '');

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UpcomingTourCard(
            tour: tour,
            title: title,
            subtitle: subtitle,
            imageUrl: imageUrl,
            tag: tag,
          ),
        );
      },
    );
  }
}
