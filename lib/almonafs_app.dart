import 'package:almonafs_flutter/config/router/app_router.dart' show AppRouter;
import 'package:almonafs_flutter/features/cities/data/repo/citeies_repo.dart';
import 'package:almonafs_flutter/features/cities/manger/city_cubit.dart';
import 'package:almonafs_flutter/features/getAilplaneState/data/repo/Airplan_city_repo.dart';
import 'package:almonafs_flutter/features/global_Settings/data/repo/global_Setting_repo.dart';
import 'package:almonafs_flutter/features/global_Settings/manager/global_cubit.dart';
import 'package:almonafs_flutter/features/hotels/data/repo/Hotel_repo_tour.dart';
import 'package:almonafs_flutter/features/hotels/manager/hotel_cubit.dart';
import 'package:almonafs_flutter/features/localization/manager/localization_cubit.dart';
import 'package:almonafs_flutter/features/servicepackadge/data/repo/Service_repo.dart';
import 'package:almonafs_flutter/features/servicepackadge/manager/country_cubit.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/manager/tour_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/router/routes.dart';
import 'core/network/api_endpoiont.dart';
import 'features/flightScreen/data/repo/AirLine_repo.dart';
import 'features/flightScreen/manager/AirLine_cubit.dart';
import 'features/getAilplaneState/manager/Airplane_citys_cubit.dart';
import 'features/home/data/repo/country_repo.dart';
import 'features/home/manager/country_cubit.dart';
import 'features/upcomming_Tour/data/repo/city_repo_tour.dart';

class AlmonafsApp extends StatelessWidget {
  const AlmonafsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => CountryRepository()),
          RepositoryProvider(create: (_) => CityRepository()),
          RepositoryProvider(create: (_) => CityTourRepository()),
          RepositoryProvider(
            create: (_) => ServicesRepository(
              dio: Dio(BaseOptions(baseUrl: EndPoints.baseUrl)),
            ),
          ),
          RepositoryProvider(create: (_) => HotelRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  CountryCubit(context.read<CountryRepository>())
                    ..fetchAllCountries(),
            ),
            BlocProvider(
              create: (context) =>
                  CityTourCubit(repository: context.read<CityTourRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  ServicesCubit(repository: context.read<ServicesRepository>()),
            ),
            BlocProvider(
              create: (context) => HotelCubit(context.read<HotelRepository>()),
            ),
            BlocProvider(
              create: (_) => LanguageCubit(), // ✅ Cubit اللغة
            ),
            BlocProvider(
              create: (context) => AirlineCubit(AirlineRepository()),
            ),
            BlocProvider(
              create: (_) =>
                  AirPlaneCitysCubit(AirplaneCitsRepository())
                    ..getAirPlaneCitys(),
            ),
            BlocProvider(
              create: (_) =>
                  GlobalSettingsCubit(repository: GlobalSettingsRepository())
                    ..getGlobalSettings(),
            ),
            BlocProvider(
              create: (context) => CityCubit(context.read<CityRepository>()),
            ),
          ],
          child: BlocBuilder<LanguageCubit, AppLanguage>(
            builder: (context, langState) {
              bool isArabic = langState == AppLanguage.arabic;

              return MaterialApp(
                onGenerateRoute: AppRouter().onGenerateRoute,
                initialRoute: Routes.splash,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: isArabic ? 'Cairo' : 'Poppins',
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                  ),
                ),
                builder: (context, child) {
                  return Directionality(
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: child!,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
