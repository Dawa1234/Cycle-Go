import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  final List<String> images = const [
    "assets/images/facebook.jpg",
    "assets/images/insta.jpg",
    "assets/images/twitter.jpg",
  ];
  final List<String> extraImage = const [
    "assets/images/whatsapp.png",
    "assets/images/viber.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(
          "About CycleGo".tr(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          verticalGap30,
          Center(child: AppTheme.appIcon(100)),
          Text(
            "Follow Us On".tr(),
            style: const TextStyle(fontSize: 20),
          ),
          verticalGap30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images
                .map((imagePath) =>
                    AppUtils.socialMediaIcons(imagePath, context))
                .toList(),
          ),
          verticalGap30,
          _informationContainer(context,
              icon: const Icon(Icons.phone),
              information: "+977-1-4114400".tr(),
              showExtraIcon: false),
          verticalGap20,
          _informationContainer(context,
              icon: const Icon(Icons.phone_android_outlined),
              information: "+977 9800000000".tr(),
              showExtraIcon: true),
          verticalGap20,
          _informationContainer(context,
              icon: const Icon(Icons.email_outlined),
              information: "sherpad3@uni.coventry.ac.uk",
              showExtraIcon: false),
          const Expanded(child: SizedBox()),
          AppUtils.bottomInformation(),
          verticalGap10,
          verticalGap5,
        ],
      ),
    );
  }

  Widget _informationContainer(BuildContext context,
      {required String information,
      required Icon icon,
      required bool showExtraIcon}) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).highlightColor,
              blurRadius: 7,
              spreadRadius: 4)
        ],
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: icon,
          ),
          horizontalGap10,
          Expanded(
              child: Text(
            information,
            style: const TextStyle(fontSize: 15),
          )),
          if (showExtraIcon) ...{
            ...extraImage.map((image) => _extraIcon(image)).toList(),
          },
          horizontalGap5,
        ],
      ),
    );
  }

  Widget _extraIcon(String image) {
    return SizedBox(
      width: image == "assets/images/whatsapp.png" ? 27 : 40,
      child: Image.asset(image),
    );
  }
}
