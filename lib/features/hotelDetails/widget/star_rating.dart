import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber[700],
            size: 16,
          );
        }),
        const SizedBox(width: 4),
        Text(
          '$rating.0',
          style: TextStyle(
            color: Colors.amber[700],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
