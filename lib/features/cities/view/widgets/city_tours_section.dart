import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart'
    as tour;
import 'package:almonafs_flutter/features/cities/view/widgets/tour_tile_item.dart';

class CityToursSection extends StatelessWidget {
  final List<tour.CityTourData> tours;

  const CityToursSection({super.key, required this.tours});

  @override
  Widget build(BuildContext context) {
    if (tours.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, "Popular Tours"),
        const SizedBox(height: 16),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tours.length,
          itemBuilder: (context, index) {
            final tour = tours[index];
            return TourTileItem(tourData: tour);
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextButton(onPressed: () {}, child: const Text("See All")),
      ],
    );
  }
}
