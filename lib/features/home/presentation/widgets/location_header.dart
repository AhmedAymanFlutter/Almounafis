import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Your Location", style: TextStyle(color: Colors.grey)),
            Text("Mansoura, Egypt",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: const [
            Icon(Icons.notifications_none, size: 28),
            SizedBox(width: 12),
            Icon(Icons.settings, size: 28),
          ],
        )
      ],
    );
  }
}
