import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cyclego/constants/enums/enum.dart';
import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/ui/light_theme.data.dart';
import 'package:cyclego/constants/utils/no_glow_scroll.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/booked_cycle/booked_cycle_cubit.dart';
import 'package:cyclego/logic/connection/connection_cubit.dart';
import 'package:cyclego/logic/cycle/cycle_bloc.dart';
import 'package:cyclego/logic/favorites/favorites_cubit.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/logic/registration/registration_cubit.dart';
import 'package:cyclego/logic/theme_mode/theme_mode_cubit.dart';
import 'package:cyclego/logic/toggle/toggle_theme_cubit.dart';
import 'package:cyclego/logic/transaction/transaction_bloc.dart';
import 'package:cyclego/routes/routes_generate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [];
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(EasyLocalization(
        saveLocale: true,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NE'),
        ],
        fallbackLocale: const Locale('en', 'US'),
        path: 'assets/language',
        child: ScrollConfiguration(
            behavior: NoGlowScrollBehavior(), child: const MyApp()),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
        ),
        BlocProvider(
          create: (context) => CycleBloc(),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(),
        ),
        BlocProvider(
          create: (context) => BookedCycleCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(),
        ),
        BlocProvider(
          create: (context) => ToggleThemeCubit(sharedPreferences: getIt())
            ..getSavedToggleOption(),
        ),
        BlocProvider(
          create: (context) =>
              ThemeModeCubit(sharedPreferences: getIt())..init(),
        ),
        BlocProvider(
          create: (context) =>
              ConnectionCubit(connectivity: Connectivity())..init(),
        ),
      ],
      child: KhaltiScope(
        publicKey: "test_public_key_20435233a21a47c6ab85b4fb6baf1121",
        builder: (context, navigatorKey) {
          return BlocListener<ToggleThemeCubit, ToggleThemeState>(
            listener: (context, state) {
              if (state.currentToggle == CurrentToggle.system) {
                BlocProvider.of<ThemeModeCubit>(context)
                    .changeThemeMode(ThemeMode.system);
              }
              if (state.currentToggle == CurrentToggle.dark) {
                BlocProvider.of<ThemeModeCubit>(context)
                    .changeThemeMode(ThemeMode.dark);
              }
              if (state.currentToggle == CurrentToggle.light) {
                BlocProvider.of<ThemeModeCubit>(context)
                    .changeThemeMode(ThemeMode.light);
              }
            },
            child: BlocBuilder<ThemeModeCubit, ThemeMode>(
              builder: (context, state) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  localizationsDelegates: [
                    KhaltiLocalizations.delegate,
                    ...context.localizationDelegates
                  ],
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  themeMode: state,
                  darkTheme: DarkTheme.themeData(context),
                  theme: LightTheme.themeData(context),
                  onGenerateRoute: GeneratedRoute.onGenerateRoute,
                  builder: (BuildContext context, Widget? child) {
                    final MediaQueryData data = MediaQuery.of(context);
                    return BlocListener<ConnectionCubit, CheckConnectionState>(
                        listener: (context, state) {
                          if (state is ConnectionEstablishedOnWifi) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Connection Established on Wifi.",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }
                          if (state is ConnectionEstablishedOnMobileData) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    duration: Duration(seconds: 5),
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Connection Established on Mobile Data.",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }
                          if (state is ConnectionLost) {
                            log("no connection");
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    duration: Duration(days: 1),
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "No internet connection.",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }
                        },
                        child: MediaQuery(
                          data: data.copyWith(
                              textScaleFactor:
                                  data.textScaleFactor.clamp(1, 1)),
                          child: child!,
                        ));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
// 