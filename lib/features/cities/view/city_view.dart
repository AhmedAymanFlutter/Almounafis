import 'package:almonafs_flutter/features/cities/data/model/cities_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Keep your existing imports
import 'package:almonafs_flutter/core/helper/Fun_helper.dart'; // Assuming WhatsAppService is here
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/core/theme/app_text_style.dart';
import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/cities/manger/city_state.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_stete.dart';
import '../../../../config/router/routes.dart';
import '../../localization/manager/localization_cubit.dart'; // Add this import

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, languageState) {
        final isArabic = languageState == AppLanguage.arabic;
        return BlocProvider(
          create: (context) => CityCubit(CityRepository())..getCities(),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              leading: const SizedBox(),
              title: Text(
                isArabic ? "وجهات المنافس" : "Almounafies Destinations",
              ),
              centerTitle: true,
            ),
            body: const CityView(),
          ),
        );
      },
    );
  }
}

class CityView extends StatelessWidget {
  const CityView({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Check Directionality to determine if it is Arabic
    final isArabic = Directionality.of(context) == TextDirection.rtl;

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
                // ✅ Pass context and isArabic to the helper method
                child: _buildHeroSection(
                  context,
                  state.cityResponse.seoPage?.hero,
                  isArabic,
                ),
              ),

              // 2. Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    // Handle Arabic/English title if available in your model
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

  // ✅ Added Context and isArabic parameters
  Widget _buildHeroSection(
    BuildContext context,
    HeroSection? hero,
    bool isArabic,
  ) {
    if (hero == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: AppColor.secondaryblue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hero.heroTitle ?? "",
            style: AppTextStyle.setPoppinsWhite(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hero.heroDescription ?? "",
            style: AppTextStyle.setPoppinsWhite(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final globalSettingsState = context
                  .read<GlobalSettingsCubit>()
                  .state;

              if (globalSettingsState is GlobalSettingsLoaded) {
                // ✅ Now we have valid context, isArabic, and settings
                WhatsAppService.launchWhatsApp(
                  context,
                  isArabic: isArabic,
                  settings: globalSettingsState.globalSettings,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isArabic
                          ? "جاري تحميل الإعدادات..."
                          : "Loading settings...",
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.mainWhite,
              foregroundColor: AppColor.secondaryblue,
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
    // ✅ Check Directionality to determine if it is Arabic
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    // ✅ Safely resolve the image URL
    String? imageUrl;
    if (city.imagesObject?.coverImage?.url != null) {
      imageUrl = city.imagesObject!.coverImage!.url;
    } else if (city.imagesObject?.gallery != null &&
        city.imagesObject!.gallery!.isNotEmpty) {
      imageUrl = city.imagesObject!.gallery![0].url;
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.cityDetailsPage,
          arguments: {'idOrSlug': city.id ?? city.name, 'cityName': city.name},
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
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[200], // Placeholder color
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
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
                      Expanded(
                        child: Text(
                          isArabic
                              ? (city.nameAr ?? city.name ?? "مدينة غير معروفة")
                              : (city.name ?? "Unknown City"),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // ... (rest of the card content)
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
                    isArabic
                        ? (city.descriptionFlutter ??
                              city.description ??
                              "") // Fallback if no Ar specific field
                        : (city.descriptionFlutter ?? city.description ?? ""),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  // ✅ Wrap with spacing to prevent overflow
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      if (city.bestTimeToVisit?.months?.isNotEmpty == true)
                        _buildChip(
                          Icons.calendar_today,
                          isArabic
                              ? "أفضل وقت: ${city.bestTimeToVisit!.months!.take(2).join(', ')}"
                              : "Best: ${city.bestTimeToVisit!.months!.take(2).join(', ')}",
                        ),
                      if (city.weather?.windSpeed != null)
                        _buildChip(
                          Icons.air,
                          "${city.weather!.windSpeed} km/h",
                        ),
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
      materialTapTargetSize:
          MaterialTapTargetSize.shrinkWrap, // Reduces vertical spacing
    );
  }
}
