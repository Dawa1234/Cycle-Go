import 'package:cyclego/constants/enums/enum.dart';
import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/data/models/cycle.dart';
import 'package:cyclego/logic/toggle/toggle_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

const SizedBox horizontalGap5 = SizedBox(
  width: 10,
);
const SizedBox horizontalGap10 = SizedBox(
  width: 10,
);
const SizedBox horizontalGap20 = SizedBox(
  width: 20,
);
const SizedBox horizontalGap30 = SizedBox(
  width: 30,
);
const SizedBox horizontalGap50 = SizedBox(
  width: 50,
);

const SizedBox verticalGap10 = SizedBox(
  height: 10,
);
const SizedBox verticalGap5 = SizedBox(
  height: 10,
);
const SizedBox verticalGap20 = SizedBox(
  height: 20,
);
const SizedBox verticalGap30 = SizedBox(
  height: 30,
);
const SizedBox verticalGap50 = SizedBox(
  height: 50,
);

double phoneHeight(context) {
  return MediaQuery.of(context).size.height;
}

double phoneWidth(context) {
  return MediaQuery.of(context).size.width;
}

class AppTheme {
  static Text customUnderlineText({
    required String text,
    required double offSetHeight,
  }) {
    return Text(
      "Rs. $text/hr",
      style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: Colors.black,
          color: Colors.transparent,
          shadows: [Shadow(offset: Offset(0, offSetHeight))]),
    );
  }

  static SizedBox appIcon(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: const Border.fromBorderSide(
              BorderSide(width: 1, color: Colors.white)),
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: const Color.fromARGB(255, 35, 53, 71),
          ),
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon.jpg"),
          ),
        ),
      ),
    );
  }

  static Widget cycleContainer(BuildContext context,
      {required Function() onTap, required CycleModel cycle}) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 140,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  color: Theme.of(context).highlightColor)
            ]),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.st,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 5, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: customUnderlineText(
                    text: cycle.price ?? "100", offSetHeight: -2),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
              decoration: BoxDecoration(
                  image: cycle.image != null
                      ? DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(cycle.image![0]))
                      : const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/cycle.png"))),
              width: double.infinity,
              height: 80,
            ),
            Text(
              cycle.name ?? 'CYCLE NAME',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                  color: Colors.transparent,
                  shadows: [
                    Shadow(
                        color: Theme.of(context).primaryColor,
                        offset: const Offset(0, -6))
                  ]),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      const Text(
                        "Type: ",
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        cycle.type ?? "Cycle Type",
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  cycle.bookedStatus == null
                      ? const SizedBox()
                      : cycle.bookedStatus!
                          ? const Text(
                              "Booked",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          : const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowBottomModalSheet {
  static void showDarkModeToggleSnackBar(
      {required BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocBuilder<ToggleThemeCubit, ToggleThemeState>(
            builder: (context, toggleState) {
              return Container(
                  height: 220,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Theme',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ListTile(
                        title: const Text(
                          "System",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                        leading: SvgPicture.asset(
                          "assets/icons/system.svg",
                          height: 20,
                          width: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () => BlocProvider.of<ToggleThemeCubit>(context)
                            .systemMode(),
                        trailing:
                            toggleState.currentToggle == CurrentToggle.system
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Icon(Icons.check,
                                    color: Colors.transparent),
                      ),
                      ListTile(
                        title: const Text("Dark",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300)),
                        leading: SvgPicture.asset(
                          "assets/icons/moon.svg",
                          height: 17,
                          width: 17,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () => BlocProvider.of<ToggleThemeCubit>(context)
                            .darkMode(),
                        trailing:
                            toggleState.currentToggle == CurrentToggle.dark
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Icon(Icons.check,
                                    color: Colors.transparent),
                      ),
                      ListTile(
                        title: const Text("Light",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300)),
                        leading: SvgPicture.asset(
                          "assets/icons/sun.svg",
                          height: 20,
                          width: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () => BlocProvider.of<ToggleThemeCubit>(context)
                            .lightMode(),
                        trailing:
                            toggleState.currentToggle == CurrentToggle.light
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : const Icon(Icons.check,
                                    color: Colors.transparent),
                      ),
                    ],
                  ));
            },
          );
        });
  }
}

class AppUtils {
  static Widget bottomInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Wrap(
        children: const [
          Text(
              "For any queries regarding application. Please contact customer care with reference number"),
          Text(
            "+977-1-4000110",
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  static Widget socialMediaIcons(String imagePath, BuildContext context,
      {double? size}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: size ?? 40,
        height: size ?? 40,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).highlightColor,
                  blurRadius: 2,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(image: AssetImage(imagePath))),
      ),
    );
  }
}

class AppBarContainer extends StatelessWidget {
  final double height;
  final Widget topText;
  final Text bottomText;
  const AppBarContainer({
    Key? key,
    required this.height,
    required this.topText,
    required this.bottomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      alignment: Alignment.bottomCenter,
      height: height,
      width: phoneWidth(context),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: Theme.of(context).highlightColor,
                blurRadius: 10,
                spreadRadius: 2)
          ],
          color: appBarColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [topText, bottomText],
      ),
    );
  }
}
