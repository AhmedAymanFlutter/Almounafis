// home_view.dart
import 'package:almonafs_flutter/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../manager/country_cubit.dart';
import '../../manager/country_state.dart';
import '../widgets/guided_tour_card.dart';
import '../widgets/location_header.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_title.dart';
import '../widgets/upcoming_tour_card.dart';
import 'widget/get_image.dart';

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
      body: SafeArea(
        child: _selectedIndex == 0 
          ? _buildHomeContent() // محتوى الـ Home
          : _buildOtherPages(), // الصفحات الأخرى
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
            icon: SvgPicture.asset("assets/icons/home.svg", color: AppColor.mainWhite),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/bag.svg", color: AppColor.mainWhite),
            label: "Upcoming Trips",
          ),
          BottomNavigationBarItem(
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

  // ⭐ محتوى صفحة الـ Home
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LocationHeader(),
          const SizedBox(height: 8),
          const CustomSearchBar(),
          const SizedBox(height: 24),
          const SectionTitle(title: "Our Guided Tours"),
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
                return Column(                
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
                          itemCount: state.countries.length,
                          itemBuilder: (context, index) {
                            final country = state.countries[index];
                            
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == state.countries.length - 1 ? 0 : 12.0,
                              ),
                              child: GuidedTourCard(
                                title: country.name ?? "No Name",
                                imageUrl: getCountryImageUrl(country),
                                tag: country.currency ?? "Currency",
                                location: country.name ?? "Location",
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
                // CountryInitial state
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
                      ElevatedButton(
                        onPressed: () async {
                        },
                        child: Text("Test API Connection"),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 24),
          const SectionTitle(title: "Upcoming Tours"),
          const SizedBox(height: 12),
          Column(
            children: const [
              UpcomingTourCard(
                title: "Kerinci Mountain",
                subtitle: "Solok, Jambi",
                tag: "Hiking",
                imageUrl: "assets/images/download.png",
                rating: 4.3,
              ),
              SizedBox(height: 12),
            ],
          )
        ],
      ),
    );
  }

  // ⭐ محتوى الصفحات الأخرى
  Widget _buildOtherPages() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 50, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            _selectedIndex == 1 ? "Upcoming Trips Page" :
            _selectedIndex == 2 ? "Hotels Page" : "Profile Page",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Under Development", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

}