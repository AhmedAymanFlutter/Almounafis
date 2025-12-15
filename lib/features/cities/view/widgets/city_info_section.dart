import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';

class CityInfoSection extends StatelessWidget {
  final CityDetails city;

  const CityInfoSection({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description Section
        Text(
          "About ${city.name}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          city.descriptionFlutter ??
              city.description?.replaceAll(RegExp(r'<[^>]*>'), '') ??
              "Discover the beauty of ${city.name}.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.6,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
