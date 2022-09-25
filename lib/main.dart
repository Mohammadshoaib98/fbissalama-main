import 'package:fbissalama/Screens/LoginScreen/LoginScreen.dart';
import 'package:fbissalama/Screens/MainHomeScreen/MainHomeScreen.dart';
import 'package:fbissalama/Screens/SplashScreen/splashscreen.dart';
import 'package:fbissalama/utilities/router.dart';
import 'package:fbissalama/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bissalama",
      onGenerateRoute: onGenerate,
      initialRoute: AppRoutes.splashScreenPage,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        AppRoutes.loginPage: (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        AppRoutes.splashScreenPage: (context) => const SplashScreen(),
        AppRoutes.MainHomePage: (context) => const MainHome()
      },
    ),
  );
}
