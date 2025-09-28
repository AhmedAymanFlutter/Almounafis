import 'package:almonafs_flutter/config/router/router_transation.dart';
import 'package:almonafs_flutter/config/router/routes.dart';
import 'package:almonafs_flutter/features/auth/presentation/views/sign_up_view.dart';
import 'package:almonafs_flutter/features/home/presentation/views/home_view.dart';
import 'package:almonafs_flutter/features/onboarding/presentation/views/on_boarding_view.dart';
import 'package:almonafs_flutter/features/splash/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.splash:
        return RouterTransitions.build(SplashScreen());
      case Routes.onBoarding:
        return RouterTransitions.build(OnBoardingView());
      case Routes.signUp:
         return RouterTransitions.build(SignUpView());
      case Routes.home:
      return RouterTransitions.buildHorizontal(HomeView());  
      default: return RouterTransitions.build(Scaffold(
        body:Center(
          child: Text("No Route"),
        ),
      ));
    }
  }
}