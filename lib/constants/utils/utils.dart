import 'package:flutter/material.dart';
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

double phoneWeight(context) {
  return MediaQuery.of(context).size.width;
}

class AppTheme {
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
      {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
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
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/cycle.png"))),
              width: double.infinity,
              height: 80,
            ),
            Text(
              'CYCLE NAME',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 7,
                ),
                Text(
                  "Type: ",
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  "Cycle Type",
                  style: TextStyle(fontSize: 11),
                ),
              ],
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
          return Container(
              height: 220,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Theme',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Divider(),
                  ListTile(
                    title: const Text(
                      "System",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                    leading: SvgPicture.asset(
                      "assets/icons/system.svg",
                      height: 20,
                      width: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    trailing: const Icon(Icons.check),
                    // trailing: toggleState.modeValue == "System"
                    //     ? Icon(
                    //         Icons.check,
                    //         color: Theme.of(context).primaryColor,
                    //       )
                    //     : const Icon(Icons.check, color: Colors.transparent),
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
                    onTap: () {},
                    trailing: const Icon(Icons.check),
                    // trailing: toggleState.modeValue == "Dark"
                    //     ? Icon(
                    //         Icons.check,
                    //         color: Theme.of(context).primaryColor,
                    //       )
                    //     : const Icon(Icons.check, color: Colors.transparent),
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
                      onTap: () {},
                      trailing: const Icon(
                        Icons.check,
                      )

                      // trailing: toggleState.modeValue == "Light"
                      //     ? Icon(
                      //         Icons.check,
                      //         color: Theme.of(context).primaryColor,
                      //       )
                      //     : const Icon(Icons.check, color: Colors.transparent),
                      ),
                ],
              ));
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

  static Widget socialMediaIcons(String imagePath, BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).highlightColor,
                  blurRadius: 2,
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(7),
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
      width: phoneWeight(context),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 3),
                color: Theme.of(context).highlightColor,
                blurRadius: 10,
                spreadRadius: 2)
          ],
          color: const Color.fromARGB(255, 39, 139, 233),
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
