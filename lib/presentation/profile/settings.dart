import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
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
                _settingTitle(
                    icon: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 2, color: Colors.black)),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.more_horiz),
                    ),
                    title: "More"),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                _navigateTo(
                    onTap: () {
                      ShowBottomModalSheet.showDarkModeToggleBottomSheet(
                          context: context);
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
