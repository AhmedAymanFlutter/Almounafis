import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class UpcomingTourCard extends StatelessWidget {
  final String title, subtitle, imageUrl, tag;
  final double rating;

  const UpcomingTourCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tag,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[300],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 90,
                  height: 90,
                  color: Colors.grey[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 20),
                        SizedBox(height: 4),
                        Text(
                          'Failed',
                          style: TextStyle(fontSize: 8, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    label: Text(tag),
                    backgroundColor: Colors.blue.shade50,
                    labelStyle: const TextStyle(fontSize: 12),
                    padding: EdgeInsets.zero,
                    color: WidgetStateProperty.all(AppColor.primaryWhite),
                  ),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Text(subtitle,
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Text(rating.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
