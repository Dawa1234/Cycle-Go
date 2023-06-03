import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _initalData() async {
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() =>
        Navigator.pushReplacementNamed(context, Routes.loginScreen,
            arguments: {'animation': 'fade'}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
