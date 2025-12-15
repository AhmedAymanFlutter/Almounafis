import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_details_header.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_info_section.dart';
import 'package:almonafs_flutter/features/cities/view/widgets/city_tours_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityDetailsView extends StatelessWidget {
  final String idOrSlug;
  final String cityName;

  const CityDetailsView({
    super.key,
    required this.idOrSlug,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
      body: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          if (state is CityDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CityDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          } else if (state is CityDetailsLoaded) {
            final city = state.cityDetailsResponse.data;
            if (city == null) {
              return const Center(child: Text("No Data Available"));
            }

            return CustomScrollView(
              slivers: [
                // 1. Modern Sliver App Bar with Parallax Image and Header
                CityDetailsHeader(city: city),

                // 2. Content Body
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description Section
                        CityInfoSection(city: city),

                        if (city.packages?.isNotEmpty == true)
                          const SizedBox(height: 32),

                        // Tours Section (Vertical List)
                        if (city.cityTours?.isNotEmpty == true)
                          CityToursSection(tours: city.cityTours!),

                        // Bottom Padding for scroll
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
