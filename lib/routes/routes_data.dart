part of 'routes.dart';

class Routes {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
}

Map<String, Function> getRoutes = {
  Routes.splashScreen: (arugments) => const SplashScreen(),
  Routes.loginScreen: (arugments) => const LoginScreen(),
  Routes.registerScreen: (arugments) => const RegisterScreen()
};
