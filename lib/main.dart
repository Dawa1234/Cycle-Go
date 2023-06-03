import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/ui/light_theme.data.dart';
import 'package:cyclego/routes/routes_generate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.light,
      darkTheme: DarkTheme.themeData(context),
      theme: LightTheme.themeData(context),
      onGenerateRoute: GeneratedRoute.onGenerateRoute,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data:
              data.copyWith(textScaleFactor: data.textScaleFactor.clamp(1, 1)),
          child: child!,
        );
      },
    );
  }
}
