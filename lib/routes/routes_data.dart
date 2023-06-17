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
  static const String cycleDescription = "/cycleDescription";
  static const String cycleBookingScreen = "/cycleBookingScreen";
  static const String profile = "/profile";
  static const String fav = "/fav";
  static const String more_cycles = "/more_cycles";
}

Map<String, Function> getRoutes = {
  Routes.splashScreen: (arugments) => const SplashScreen(),
  Routes.startUpScreen: (arugments) => const StartUpScreen(),
  Routes.loginScreen: (arugments) => const LoginScreen(),
  Routes.registerScreen: (arugments) => const RegisterScreen(),
  Routes.homeScreen: (arugments) => const HomeScreen(),
  Routes.helpAndSupport: (arugments) => const HelpAndSupportScreen(),
  Routes.aboutUs: (arugments) => const AboutUsScreen(),
  Routes.settings: (arugments) => const SettingsScreen(),
  Routes.more_cycles: (arugments) => const MoreCycleScreen(),
  Routes.cycleDescription: (arugments) => const CycleDescriptionScreen(),
  Routes.cycleBookingScreen: (arugments) => const CycleBookingScreen(),
  Routes.profile: (arugments) => const ProfileScreen(),
  Routes.fav: (arugments) => const FavoritesScreen(),
};
