import 'package:almonafs_flutter/features/upcomming_Tour/data/model/city_tour.dart';
import 'package:flutter/material.dart';
import 'package:almonafs_flutter/core/network/api_helper.dart';
import 'package:almonafs_flutter/core/network/api_response.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../home/presentation/views/widget/utils/get_image.dart';
import 'upcoming_tour_card.dart';

class UpcomingToursScreen extends StatefulWidget {
  const UpcomingToursScreen({super.key});

  @override
  State<UpcomingToursScreen> createState() => _UpcomingToursScreenState();
}

class _UpcomingToursScreenState extends State<UpcomingToursScreen> {
  final _api = APIHelper();
  late Future<ApiResponse> _futureTours;

  @override
  void initState() {
    super.initState();
    _futureTours = _api.getRequest(endPoint: "city-tours");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ApiResponse>(
        future: _futureTours,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child:SizedBox(
    height: 220,
    child: ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 3, // number of shimmer cards
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return  Shimmer(
          color: Colors.grey.shade400,
          colorOpacity: 0.3,
          enabled: true,
          child: Container(
            width: 370,
            height: 87,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    ),
  ));
          }

          if (snapshot.hasError) {
            return Center(child: Text("❌ Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("⚠️ No data available"));
          }

          final response = snapshot.data!;
          if (!response.status) {
            return Center(child: Text("❌ ${response.message}"));
          }
          List<Data> tours = [];
          try {
            if (response.data is List) {
              final List<dynamic> toursData = response.data as List;
              tours = toursData
                  .map((item) => Data.fromJson(item as Map<String, dynamic>))
                  .toList();
            } else if (response.data is Map<String, dynamic>) {
              final allCityTour = AllCityTour.fromJson(response.data);
              tours = allCityTour.data ?? [];
            } else {
              return Center(
                child: Text("❌ Unexpected data type: ${response.data.runtimeType}")
              );
            }
          } catch (e) {
            return Center(child: Text("❌ Parse error: $e"));
          }

          if (tours.isEmpty) {
            return const Center(child: Text("⚠️ No tours found"));
          }

          return SizedBox(
            height: 600,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tours.length,
              itemBuilder: (context, index) {
                final tour = tours[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: UpcomingTourCard(
                    title: tour.title ?? "No title",
                    subtitle: tour.descriptionFlutter ?? "No description",
                    imageUrl: getTourImageUrl(tour),
                    tag: tour.tags?.join(", ") ?? "N/A",
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}