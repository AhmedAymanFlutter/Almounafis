import 'package:flutter/material.dart';
import 'package:almonafs_flutter/features/packadge/data/model/package_model.dart'
    as pkg;
import 'package:almonafs_flutter/features/cities/view/widgets/package_card_item.dart';

class CityPackagesSection extends StatelessWidget {
  final List<pkg.Data> packages;

  const CityPackagesSection({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    if (packages.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, "Exclusive Packages"),
        const SizedBox(height: 16),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: packages.length,
            clipBehavior: Clip.none, // Allow shadows to overflow
            itemBuilder: (context, index) {
              final pkg = packages[index];
              return PackageCardItem(package: pkg);
            },
          ),
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
        // Optional "See All" button
        TextButton(onPressed: () {}, child: const Text("See All")),
      ],
    );
  }
}
