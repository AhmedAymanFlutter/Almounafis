import 'package:almonafs_flutter/config/router/router_transation.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/features/auth/presentation/views/sign_up_view.dart';
import 'package:almonafs_flutter/features/cities/view/city_view.dart';
import 'package:almonafs_flutter/features/cities/view/city_details_view.dart';

import 'package:almonafs_flutter/features/flightScreen/view/UpcomingTripsPage.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:almonafs_flutter/features/onboarding/presentation/views/on_boarding_view.dart';
import 'package:almonafs_flutter/features/setting/widget/About_us.dart';
import 'package:almonafs_flutter/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/global_Settings/view/global_Setting_view.dart';
import '../../features/home/data/repo/country_repo.dart';
import '../../features/home/manager/country_cubit.dart';
import '../../features/seeAllPage/view/All_commingTour.dart';
import '../../features/seeAllPage/view/see_AllCountry_page.dart';
import '../../features/hotelDetails/view/HotelDetailsScreen.dart';
import '../../features/packadge/view/package_List/package_List_view.dart';
import '../../features/packadge/view/countryView/package_country_details.dart';
import '../../features/packadge/view/package_view.dart';
import '../../features/packadge/view/packege_details/package_List_detail.dart';
import '../../features/servicepackadge/view/Service_view.dart';
import '../../features/setting/widget/languang.dart';
import '../../features/singel_country/view/CountryDetailsPage.dart';
import '../../features/upcomming_Tour/view/widget/CityTour_Details.dart';

import '../../features/cities/data/repo/citeies_repo.dart';
import '../../features/cities/manger/city_cubit.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return RouterTransitions.build(SplashScreen());
      case Routes.onBoarding:
        return RouterTransitions.build(OnBoardingView());
      case Routes.signUp:
        return RouterTransitions.buildHorizontal(SignUpView());
      case Routes.home:
        return RouterTransitions.buildHorizontal(HomeView());
      case Routes.packageView:
        return RouterTransitions.buildHorizontal(PackageView());
      case Routes.countriesView:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          CountriesView(
            packageTypeName: args['packageTypeName'] ?? '',
            packageTypeSlug: args['packageTypeSlug'] ?? '',
          ),
        );
      case Routes.countryDetails:
        final args = settings.arguments as Map<String, dynamic>;

        return RouterTransitions.buildHorizontal(
          BlocProvider(
            create: (context) =>
                CountryCubit(context.read<CountryRepository>()),
            child: CountryDetailsPage(
              countryIdOrSlug: args['countryIdOrSlug'] ?? '',
              countryName: args['countryName'] ?? '',
            ),
          ),
        );
      case Routes.cityPage:
        return RouterTransitions.buildHorizontal(CityPage());
      case Routes.cityDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          BlocProvider(
            // We create a new Cubit for details to avoid state conflict with list
            create: (context) =>
                CityCubit(CityRepository())..getCityDetails(args['idOrSlug']),
            child: CityDetailsView(
              idOrSlug: args['idOrSlug'],
              cityName: args['cityName'],
            ),
          ),
        );
      case Routes.cityTourDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          CityTourDetailsPage(
            tourIdOrSlug: args['tourIdOrSlug'] ?? '',
            tourTitle: args['tourTitle'] ?? '',
          ),
        );
      case Routes.hotelDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          HotelDetailsScreen(hotelId: args['hotelId'] ?? ''),
        );
      case Routes.packagesListView:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          PackagesListView(
            countrySlug: args['countrySlug'],
            packageTypeSlug: args['packageTypeSlug'],
            countryName: args['countryName'],
          ),
        );
      case Routes.packageDetailsView:
        final args = settings.arguments as Map<String, dynamic>;
        return RouterTransitions.buildHorizontal(
          PackageDetailsView(
            slug: args['slug'] ?? '',
            packageTitle: args['packageTitle'] ?? '',
          ),
        );
      case Routes.languageScreen:
        return RouterTransitions.buildHorizontal(LanguageScreen());
      case Routes.servicesView:
        return RouterTransitions.buildHorizontal(const ServicesView());
      case Routes.aboutUsScreen:
        return RouterTransitions.buildHorizontal(AboutUsScreen());
      case Routes.allCountriesPage:
        return RouterTransitions.buildHorizontal(AllCountriesPage());
      case Routes.allToursPage:
        return RouterTransitions.buildHorizontal(AllToursPage());
      case Routes.globalSettingsView:
        return RouterTransitions.buildHorizontal(GlobalSettingsView());
      case Routes.flightBookingScreen:
        return RouterTransitions.buildHorizontal(FlightBookingScreen());
      default:
        return RouterTransitions.build(
          Scaffold(body: Center(child: Text("No Route"))),
        );
    }
  }
}
