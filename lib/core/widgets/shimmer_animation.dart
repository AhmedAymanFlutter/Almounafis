import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerAnimation extends StatefulWidget {
  const ShimmerAnimation({super.key});

  @override
  State<ShimmerAnimation> createState() => _ShimmerAnimationState();
}

class _ShimmerAnimationState extends State<ShimmerAnimation> {
  bool _isLoading = true;
  List<String> tours = [];

  @override
  void initState() {
    super.initState();

    // Fake API call
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        tours = List.generate(5, (index) => "Tour $index");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guided Tours")),
      body: _isLoading
          ? ListView.builder(
              itemCount: 5, // number of shimmer items
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    interval: const Duration(seconds: 1),
                    color: Colors.grey.shade400,
                    colorOpacity: 0.3,
                    enabled: true,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: tours.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.tour),
                  title: Text(tours[index]),
                );
              },
            ),
    );
  }
}
