import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/router/routes.dart';

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityCubit(CityRepository())..getCities(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: const Text("Almounafies Destinations")),
        body: const CityView(),
      ),
    );
  }
}

class CityView extends StatelessWidget {
  const CityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityCubit, CityState>(
      builder: (context, state) {
        if (state is CityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CityError) {
          return Center(child: Text(state.message));
        } else if (state is CityLoaded) {
          return CustomScrollView(
            slivers: [
              // 1. SEO Hero Section
              SliverToBoxAdapter(
                child: _buildHeroSection(state.cityResponse.seoPage?.hero),
              ),

              // 2. Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.cityResponse.seoPage?.header?.headerTitle ?? "Cities",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 3. Cities List
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final city = state.cityResponse.data!.cities![index];
                  return CityCard(city: city);
                }, childCount: state.cityResponse.data?.cities?.length ?? 0),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildHeroSection(HeroSection? hero) {
    if (hero == null) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hero.heroTitle ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hero.heroDescription ?? "",
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
            child: Text(hero.heroButtonText ?? "Explore"),
          ),
        ],
      ),
    );
  }
}

class CityCard extends StatelessWidget {
  final City city;
  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine image URL safely
    String? imageUrl =
        city.imagesObject?.coverImage?.url ??
        (city.imagesObject?.gallery?.isNotEmpty == true
            ? city.imagesObject!.gallery![0].url
            : null);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.cityDetailsPage,
          arguments: {
            'idOrSlug': city.id ?? city.name, // Use ID or Name as slug
            'cityName': city.name,
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            if (imageUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        city.name ?? "Unknown City",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (city.weather?.currentTemp != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                size: 16,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${city.weather!.currentTemp!.toStringAsFixed(0)}°C",
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city.country?.name ?? "",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    city.descriptionFlutter ?? city.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildChip(
                        Icons.calendar_today,
                        "Best: ${city.bestTimeToVisit?.months?.take(2).join(', ')}...",
                      ),
                      _buildChip(Icons.air, "${city.weather?.windSpeed} km/h"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.blueGrey),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: Colors.blueGrey[50],
      padding: EdgeInsets.zero,
    );
  }
}
