import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/ui/light_theme.data.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/logic/registration/registration_cubit.dart';
import 'package:cyclego/routes/routes_generate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.dark,
        // themeMode: ThemeMode.light,
        darkTheme: DarkTheme.themeData(context),
        theme: LightTheme.themeData(context),
        onGenerateRoute: GeneratedRoute.onGenerateRoute,
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
                textScaleFactor: data.textScaleFactor.clamp(1, 1)),
            child: child!,
          );
        },
      ),
    );
  }
}
// 