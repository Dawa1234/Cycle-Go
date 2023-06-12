part of 'routes.dart';

class Routes {
  static const String splashScreen = "/";
  static const String startUpScreen = "/startUp";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String homeScreen = "/home";
  static const String helpAndSupport = "/helpAndSupport";
  static const String aboutUs = "/aboutUs";
  static const String settings = "/settings";
}

Map<String, Function> getRoutes = {
  Routes.splashScreen: (arugments) => const SplashScreen(),
  Routes.startUpScreen: (arugments) => const StartUpScreen(),
  Routes.loginScreen: (arugments) => const LoginScreen(),
  Routes.homeScreen: (arugments) => const HomeScreen(),
  Routes.helpAndSupport: (arugments) => const HelpAndSupportScreen(),
  Routes.aboutUs: (arugments) => const AboutUsScreen(),
  Routes.settings: (arugments) => const SettingsScreen(),
};
