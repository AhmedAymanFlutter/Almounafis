import 'package:almonafs_flutter/features/cities/data/model/city_details_model.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:almonafs_flutter/core/utils/constants.dart'; // Commented out until verified

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
    // We assume CityCubit is provided by the router or parent
    // However, if we need to load data specific to this page, we might trigger it here or in route
    // But since we are reusing the same Cubit (or a new instance), let's ensure we load data.
    // If provided in route with ..getCityDetails(id), we just listen.

    return Scaffold(
      appBar: AppBar(title: Text(cityName)),
      body: BlocBuilder<CityCubit, CityState>(
        builder: (context, state) {
          if (state is CityDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CityDetailsError) {
            return Center(child: Text(state.message));
          } else if (state is CityDetailsLoaded) {
            final city = state.cityDetailsResponse.data;
            if (city == null) return const Center(child: Text("No Data"));

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero / Image Slider could go here. For now simpler version.
                  if (city.images?.isNotEmpty == true)
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.network(
                        city.images!.first.url ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city.name ?? "",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        // Weather
                        if (city.weather != null)
                          Row(
                            children: [
                              Icon(Icons.wb_sunny, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text(
                                "${city.weather?.currentTemp ?? '?'}°C - ${city.weather?.condition ?? ''}",
                              ),
                            ],
                          ),

                        const SizedBox(height: 16),
                        // Description
                        Text(
                          city.descriptionFlutter ??
                              city.description?.replaceAll(
                                RegExp(r'<[^>]*>'),
                                '',
                              ) ??
                              "",
                        ),

                        // Packages
                        if (city.packages?.isNotEmpty == true) ...[
                          const SizedBox(height: 24),
                          Text(
                            "Packages",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 200, // Adjust height
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: city.packages!.length,
                              itemBuilder: (context, index) {
                                final pkg = city.packages![index];
                                return Card(
                                  child: Container(
                                    width: 160,
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            pkg.imageCover ?? "",
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const Icon(Icons.image),
                                          ),
                                        ),
                                        Text(
                                          pkg.name ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\$${pkg.price?.toString() ?? 'N/A'}",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],

                        // Tours
                        if (city.cityTours?.isNotEmpty == true) ...[
                          const SizedBox(height: 24),
                          Text(
                            "City Tours",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: city.cityTours!.length,
                            itemBuilder: (context, index) {
                              final tour = city.cityTours![index];
                              return ListTile(
                                leading: Image.network(
                                  tour.coverImage ?? "",
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      Icon(Icons.image),
                                ),
                                title: Text(tour.title ?? ""),
                                subtitle: Text(
                                  "\$${tour.price?.toString() ?? 'N/A'}",
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
