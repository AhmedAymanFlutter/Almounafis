import 'package:almonafs_flutter/config/router/app_router.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/core/network/api_endpoiont.dart';
import 'package:almonafs_flutter/features/upcomming_Tour/data/repo/city_repo_tour.dart' show CityTourRepository;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/home/data/repo/country_repo.dart';
import 'features/home/manager/country_cubit.dart';
import 'features/upcomming_Tour/manager/tour_cubit.dart';
import 'features/servicepackadge/data/repo/Service_repo.dart';
import 'features/servicepackadge/manager/country_cubit.dart';

class AlmonafsApp extends StatelessWidget {
  const AlmonafsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CountryCubit(CountryRepository())..fetchAllCountries(),
  ),   
  BlocProvider(
    create: (context) => CityTourCubit(
      repository: CityTourRepository(),
    ),
  ),
  BlocProvider(
    create: (context) => ServicesCubit(
      repository: ServicesRepository(dio: Dio(BaseOptions(baseUrl: EndPoints.baseUrl))),
    ),
  ),

        ],
        child: MaterialApp(
          onGenerateRoute: AppRouter().onGenerateRoute,
          initialRoute: Routes.splash,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
