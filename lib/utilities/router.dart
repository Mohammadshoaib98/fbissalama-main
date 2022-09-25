
import 'package:fbissalama/Screens/SplashScreen/splashscreen.dart';
import 'package:fbissalama/utilities/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splashScreenPage:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}