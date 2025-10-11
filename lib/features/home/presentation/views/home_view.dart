import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;
import '../../../localization/manager/localization_cubit.dart';
import '../../../upcomming_Tour/view/tour_view.dart';
import '../../data/repo/country_repo.dart';
import '../../manager/country_cubit.dart';
import '../../manager/country_state.dart';
import '../widgets/guided_tour_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_title.dart';
import 'widget/cusstom_drawer_widget.dart';
import 'widget/utils/build_nav_widget.dart';
import 'widget/utils/get_image.dart';
import '../../../hotels/view/HotelsPage.dart';
import '../../../flightScreen/view/UpcomingTripsPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, langState) {
        bool isArabic = langState == AppLanguage.arabic;

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: AppColor.mainWhite,
            drawer: CustomDrawer(onNavigationItemTapped: _onItemTapped),
            body: SafeArea(
              child: _selectedIndex == 1
                  ? const _HomeContent()
                  : _buildOtherPages(),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: _selectedIndex,
              backgroundColor: Colors.transparent,
              color: AppColor.mainBlack,
              buttonBackgroundColor: AppColor.mainWhite,
              animationDuration: const Duration(milliseconds: 300),
              onTap: _onItemTapped,
              items: [
                buildNavItem(
                  icon: "assets/icons/bag.svg",
                  label: isArabic ? "الرحلات" : "Trips",
                  isSelected: _selectedIndex == 0,
                ),
                buildNavItem(
                  icon: "assets/icons/home.svg",
                  label: isArabic ? "الرئيسية" : "Home",
                  isSelected: _selectedIndex == 1,
                ),
                buildNavItem(
                  icon: "assets/icons/sleep.svg",
                  label: isArabic ? "الفنادق" : "Hotels",
                  isSelected: _selectedIndex == 2,
                  
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtherPages() {
    if (_selectedIndex == 1) {
      Future.microtask(() {
        context.read<CountryCubit>().fetchAllCountries();
      });
    }

    switch (_selectedIndex) {
      case 0:
        return const FlightBookingScreen();
      case 2:
        return const HotelsPage();
      default:
        return const _HomeContent();
    }
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CountryCubit(CountryRepository())..fetchAllCountries(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => __HomeScreenContentState();
}

class __HomeScreenContentState extends State<_HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.read<LanguageCubit>().state == AppLanguage.arabic;

    return Container(
      color: AppColor.mainWhite,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: AppColor.mainBlack),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(),
            ),
            const SizedBox(height: 24),

            // 🏳️ Our Countries Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(
                title: isArabic ? "دولنا" : "Our Countries",
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<CountryCubit, CountryState>(
              builder: (context, state) {
                return buildCountriesContent(context, state, isArabic);
              },
            ),

            const SizedBox(height: 24),

            // Upcoming Tours Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SectionTitle(
                title: isArabic ? "الجولات القادمة" : "Upcoming Tours",
              ),
            ),
            const SizedBox(height: 12),
            const SizedBox(
              height: 300,
              child: UpcomingToursScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCountriesContent(
    BuildContext context, CountryState state, bool isArabic) {
  if (state is CountryLoading) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.grey.shade400,
            colorOpacity: 0.3,
            enabled: true,
            child: Container(
              width: 240,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  if (state is CountryError) {
    return Container(
      color: AppColor.mainWhite,
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error, color: Colors.red, size: 50),
            Text(
              isArabic ? "حدث خطأ في التحميل" : state.message,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<CountryCubit>().fetchAllCountries(),
              child: Text(isArabic ? "إعادة المحاولة" : "Retry"),
            ),
          ],
        ),
      ),
    );
  }

  if (state is CountryLoaded) {
    final countries = state.countries;

    if (countries.isEmpty) {
      return Container(
        color: AppColor.mainWhite,
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 50),
              Text(
                isArabic ? 'لا توجد دول متاحة' : 'No countries available',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      color: AppColor.mainWhite,
      child: SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return Padding(
              padding: EdgeInsets.only(
                right: index == countries.length - 1 ? 0 : 12.0,
              ),
              child: GuidedTourCard(
                 title: isArabic
                     ? country.descriptionArFlutter ?? "لا يوجد وصف"
                     : country.descriptionFlutter ?? "No Name",
                          imageUrl: getCountryImageUrl(country),
                         tag: country.currency ?? (isArabic ? "غير متوفر" : "Currency"),
                         location: isArabic
                        ? country.nameAr ?? "بدون اسم"
                        : country.name ?? "Location",
                    countryId: country.slug ?? country.sId ?? "",
),

            );
          },
        ),
      ),
    );
  }

  return Container(
    color: AppColor.mainWhite,
    child: const Center(child: CircularProgressIndicator()),
  );
}
