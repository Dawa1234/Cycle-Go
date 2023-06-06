part of 'routes.dart';

class Routes {
  static const String splashScreen = "/";
  static const String startUpScreen = "/startUp";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String homeScreen = "/register";
}

Map<String, Function> getRoutes = {
  Routes.splashScreen: (arugments) => const SplashScreen(),
  Routes.startUpScreen: (arugments) => const StartUpScreen(),
  Routes.loginScreen: (arugments) => const LoginScreen(),
  Routes.homeScreen: (arugments) => const HomeScreen()
};
