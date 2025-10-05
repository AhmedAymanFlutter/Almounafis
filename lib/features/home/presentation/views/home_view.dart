// home_view.dart
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart' show Shimmer;
import '../../../auth/presentation/views/sign_up_view.dart';
import '../../../upcomming_Tour/view/tour_view.dart';
import '../../manager/country_cubit.dart';
import '../../manager/country_state.dart';
import '../widgets/guided_tour_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_title.dart';
import 'widget/cusstom_drawer_widget.dart';
import 'widget/utils/get_image.dart';
import '../../../hotels/view/HotelsPage.dart';
import '../../../flightScreen/view/UpcomingTripsPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onNavigationItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        child: _selectedIndex == 0 
          ? _buildHomeContent()
          : _buildOtherPages(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.mainBlack,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColor.mainWhite,
        unselectedItemColor: AppColor.mainBlack,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg", ),
            label: "Home",
            activeIcon: SvgPicture.asset("assets/icons/home_filled.svg", color: AppColor.mainWhite,),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/bag.svg", color: AppColor.mainWhite),
            label: "Upcoming Trips",
            activeIcon: SvgPicture.asset("assets/icons/bag_filled.svg", color: AppColor.mainWhite),
          ),
          BottomNavigationBarItem(
           activeIcon: SvgPicture.asset("assets/icons/hotel_filled.svg", color: AppColor.mainWhite),
            icon: SvgPicture.asset("assets/icons/sleep.svg", color: AppColor.mainWhite),
            label: "Hotels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: AppColor.mainWhite),
            label: "profile",
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CountryCubit>().fetchAllCountries();
        context.read<CityTourCubit>().getAllCities();

        await Future.delayed(const Duration(milliseconds: 500));
      },
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const CustomSearchBar(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SectionTitle(title: "Our Countries"),
          ),
          const SizedBox(height: 12),
          BlocConsumer<CountryCubit, CountryState>(
            listener: (context, state) {
              if (state is CountryError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {            
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
              } else if (state is CountryLoaded) {
                if (state.countries.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.countries.length,
                          itemBuilder: (context, index) {
                            final country = state.countries[index];                           
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == state.countries.length - 1 ? 0 : 12.0,
                              ),
                              child: GuidedTourCard(
                                title: country.descriptionFlutter ?? "No Name",
                                imageUrl: getCountryImageUrl(country),
                                tag: country.currency ?? "Currency",
                                location: country.name ?? "Location",
                                countryId: country.slug ?? country.sId ?? "",
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.warning, color: Colors.orange, size: 50),
                        Text("No countries available"),
                      ],
                    ),
                  );
                }
              } else if (state is CountryError) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 50),
                      Text("Error: ${state.message}"),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CountryCubit>().fetchAllCountries();
                        },
                        child: Text("Try Again"),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      Text("Press refresh to load countries"),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CountryCubit>().fetchAllCountries();
                        },
                        child: Text("Load Countries"),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SectionTitle(title: "Upcoming Tours"),
          ),
          const SizedBox(height: 12),
          Column(
            children: const [
             SizedBox(
              height: 300,
              child: UpcomingToursScreen()),
            ],
          )
        ],
      ),
      ),
    );
  }

  Widget _buildOtherPages() {
    switch (_selectedIndex) {
      case 1:
        return FlightBookingScreen();
      case 2:
        return HotelsPage();
      case 3:
        return SignUpView();
      default:
        return Center(child: Text("Page not found"));
    }
  }
}