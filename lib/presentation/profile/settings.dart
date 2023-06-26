import 'dart:ui';

import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/theme_mode/theme_mode_cubit.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> images = const [
    "assets/images/facebook.jpg",
    "assets/images/insta.jpg",
    "assets/images/twitter.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalGap20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Settings".tr(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: '', fontSize: 40),
            ),
          ),
          verticalGap30,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              children: [
                _settingTitle(
                    icon: const Icon(
                      Icons.person_2_outlined,
                      size: 30,
                    ),
                    title: "Account"),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                _navigateTo(
                    onTap: () => Navigator.pushNamed(context, Routes.profile),
                    title: "Edit Profile"),
                _navigateTo(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.updatePassword),
                    title: "Change Password"),
                _navigateTo(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.updatePassword),
                    title: "Delete Account"),
                verticalGap30,
                BlocBuilder<ThemeModeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return _settingTitle(
                        icon: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border.fromBorderSide(BorderSide(
                                  width: 2,
                                  color: themeMode == ThemeMode.dark
                                      ? Colors.white
                                      : themeMode == ThemeMode.system
                                          ? window.platformBrightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black
                                          : Colors.black)),
                              shape: BoxShape.circle),
                          child: const Icon(Icons.more_horiz),
                        ),
                        title: "More");
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                _navigateTo(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              height: 170,
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text('Select Language',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  const Divider(),
                                  ListTile(
                                    title: const Text(
                                      "English",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    leading: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                          "assets/images/english.png"),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        context.setLocale(
                                            const Locale('en', 'US'));
                                      });
                                      Navigator.pop(context);
                                    },
                                    trailing: context.locale ==
                                            const Locale('en', 'US')
                                        ? Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : const Icon(Icons.check,
                                            color: Colors.transparent),
                                  ),
                                  ListTile(
                                    title: const Text("Nepali",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300)),
                                    leading: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                          "assets/images/flagNP.png"),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        context.setLocale(
                                            const Locale('ne', 'NE'));
                                      });
                                      Navigator.pop(context);
                                    },
                                    trailing: context.locale ==
                                            const Locale('ne', 'NE')
                                        ? Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : const Icon(Icons.check,
                                            color: Colors.transparent),
                                  ),
                                ],
                              ));
                        },
                      );
                    },
                    title: "Language"),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: images
                  .map((imagePath) =>
                      AppUtils.socialMediaIcons(imagePath, context, size: 35))
                  .toList(),
            ),
          ),
          verticalGap5,
          AppUtils.bottomInformation(),
          verticalGap5
        ],
      ),
    );
  }

  Widget _settingTitle({required Widget icon, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        horizontalGap20,
        Text(
          title.tr(),
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontFamily: '', fontSize: 25),
        ),
      ],
    );
  }

  Widget _navigateTo({
    required void Function() onTap,
    required String title,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0),
        child: Row(
          children: [
            Text(
              title.tr(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
