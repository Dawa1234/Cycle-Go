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
  static const String updatePassword = "/updatePassword";
  static const String fav = "/fav";
  static const String moreCycles = "/more_cycles";
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
  Routes.moreCycles: (arugments) => MoreCycleScreen(
        currentBtmNavIndex: arugments?['currentIndex'] ?? 0,
      ),
  Routes.cycleDescription: (arugments) => CycleDescriptionScreen(
        cycleId: arugments?['cycleId'] ?? "",
      ),
  Routes.cycleBookingScreen: (arugments) => CycleBookingScreen(
        cycleDetail: arugments?['cycleDetail'] ?? CycleDetail(),
      ),
  Routes.profile: (arugments) => const ProfileScreen(),
  Routes.updatePassword: (arugments) => const UpdatePasswordScreen(),
  Routes.fav: (arugments) => const FavoritesScreen(),
};
