import 'package:almonafs_flutter/config/router/router_transation.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/features/auth/presentation/views/sign_up_view.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:almonafs_flutter/features/onboarding/presentation/views/on_boarding_view.dart';
import 'package:almonafs_flutter/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/home/data/repo/country_repo.dart';
import '../../features/home/manager/country_cubit.dart';
import '../../features/hotelDetails/view/HotelDetailsScreen.dart';
import '../../features/packadge/view/package_List/package_List_view.dart';
import '../../features/packadge/view/countryView/package_country_details.dart';
import '../../features/packadge/view/package_view.dart';
import '../../features/packadge/view/packege_details/package_List_detail.dart';
import '../../features/servicepackadge/view/Service_view.dart';
import '../../features/setting/widget/About_us.dart';
import '../../features/setting/widget/languang.dart';
import '../../features/singel_country/view/CountryDetailsPage.dart';
import '../../features/upcomming_Tour/view/widget/CityTour_Details.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings){
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
            packageTypeId: args['packageTypeId'] ?? '',
            packageTypeName: args['packageTypeName'] ?? '',
          ),
        );
        case Routes.countryDetails:
        final args = settings.arguments as Map<String, dynamic>;

        return RouterTransitions.buildHorizontal(
          BlocProvider(
            create: (context) => CountryCubit(
              context.read<CountryRepository>(),
            ),
            child: CountryDetailsPage(
              countryIdOrSlug: args['countryIdOrSlug'] ?? '',
              countryName: args['countryName'] ?? '',
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
    HotelDetailsScreen(
      hotelId: args['hotelId'] ?? '',
    ),
  );
  case Routes.packagesListView:
  final args = settings.arguments as Map<String, dynamic>;
  return RouterTransitions.buildHorizontal(
    PackagesListView(
      countryId: args['countryId'],
      countryName: args['countryName'],
    ),
  );
    case Routes.packageDetailsView:
  final args = settings.arguments as Map<String, dynamic>;
  return RouterTransitions.buildHorizontal(
    PackageDetailsView(
      packageId: args['packageId'],
      packageTitle: args['packageTitle'],
    ),
  );
    case Routes.languageScreen:
    return RouterTransitions.buildHorizontal(LanguageScreen());
    case Routes.servicesView:
  return RouterTransitions.buildHorizontal(const ServicesView());
case Routes.aboutUsScreen:
  return RouterTransitions.buildHorizontal(const AboutUsScreen());

      default: return RouterTransitions.build(Scaffold(
        body:Center(
          child: Text("No Route"),
        ),
      ));
    }
  }
}