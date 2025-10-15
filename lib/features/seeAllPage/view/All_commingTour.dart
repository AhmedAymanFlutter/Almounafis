import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/home/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../upcomming_Tour/manager/tour_cubit.dart';
import '../../upcomming_Tour/manager/tour_state.dart';
import '../../upcomming_Tour/data/repo/city_repo_tour.dart';
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
        appBar: AppBar(title: const Text("All Upcoming Tours")),
        body: BlocBuilder<CityTourCubit, CityTourState>(
          builder: (context, state) {
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
                  child: _buildList(state, isArabic),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(CityTourState state, bool isArabic) {
    if (state is CityTourLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CityTourError) {
      return Center(child: Text(isArabic ? 'حدث خطأ' : 'Error loading tours'));
    }

    if (state is CityTourEmpty) {
      return Center(
          child: Text(isArabic ? state.message : "No tours available"));
    }

    if (state is CityTourLoaded) {
      final tours = state.allCityTour.data ?? [];
      return _buildToursList(tours, isArabic);
    }

    if (state is CityTourFiltered) {
      final filtered = state.filteredTours;
      return _buildToursList(filtered, isArabic);
    }

    return const SizedBox.shrink();
  }

  Widget _buildToursList(List<dynamic> tours, bool isArabic) {
    if (tours.isEmpty) {
      return Center(
        child: Text(isArabic ? "لا توجد جولات مطابقة" : "No matching tours"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: tours.length,
      itemBuilder: (context, index) {
        final tour = tours[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UpcomingTourCard(
            tour: tour,
            title:
                isArabic ? tour.titleAr ?? '' : tour.title ?? '',
            subtitle: isArabic
                ? tour.descriptionArFlutter ?? ''
                : tour.descriptionFlutter ?? '',
            imageUrl: tour.coverImage ?? '',
            tag: tour.tags?.join(", ") ?? '',
          ),
        );
      },
    );
  }
}
