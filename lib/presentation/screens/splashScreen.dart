import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ProfileBloc _profileBloc;
  _navigateTo({required bool loggedIn}) async {
    if (!_checkFirstTimeInstallation()) {
      if (loggedIn) {
        Navigator.pushReplacementNamed(context, Routes.homeScreen,
            arguments: {'animation': 'fade'});
        return;
      }
      await Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
          Navigator.pushReplacementNamed(context, Routes.homeScreen,
              arguments: {'animation': 'fade'}));
      return;
    }
    final prefs = getIt.get<SharedPreferences>();
    await prefs.setBool('isFirstInstallation', false);
    await Future.delayed(const Duration(seconds: 1)).whenComplete(() =>
        Navigator.pushReplacementNamed(context, Routes.startUpScreen,
            arguments: {'animation': 'fade'}));
  }

  bool _checkFirstTimeInstallation() {
    final prefs = getIt.get<SharedPreferences>();
    final isFirstInstallation = prefs.getBool('isFirstInstallation') ?? true;
    return isFirstInstallation;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = ProfileBloc()..add(ProfileInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: _profileBloc,
      listener: (context, state) {
        if (state is ProfileFecthed) {
          _navigateTo(loggedIn: true);
        }
        if (state is ProfileFecthFailed) {
          _navigateTo(loggedIn: false);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: AppTheme.appIcon(120),
                  ),
                  verticalGap30,
                  LoadingBar(),
                  verticalGap20,
                  const Text(
                    "Loading data...",
                  ),
                ],
              ),
            ),
            Text(
              "2022-2023",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap10,
          ],
        ),
      ),
    );
  }
}
