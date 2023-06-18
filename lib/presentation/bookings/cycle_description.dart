import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/buttons.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CycleDescriptionScreen extends StatefulWidget {
  const CycleDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<CycleDescriptionScreen> createState() => _CycleDescriptionScreenState();
}

class _CycleDescriptionScreenState extends State<CycleDescriptionScreen> {
  int _current = 0;
  final List<String> _images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _images.addAll([
      "assets/images/cycle.png",
      "assets/images/cycle-icon.png",
      "assets/images/cycle-icon.png",
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          actions: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileFecthed) {
                  return const FavButton();
                }
                return const SizedBox();
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              height: phoneHeight(context) * .45,
              width: phoneWidth(context),
              decoration: _boxDecoration(context),
              child: Column(
                children: [
                  Expanded(
                    child: CarouselSlider(
                        items: _images
                            .map(
                              (image) => Container(
                                margin: const EdgeInsets.all(10),
                                width: phoneWidth(context),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(image))),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          aspectRatio: 11 / 9,
                          onPageChanged: (index, reason) {
                            setState(() => _current = index);
                          },
                        )),
                  ),
                  SizedBox(
                    height: 25,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Container(
                                width: 5.0,
                                height: 5.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == _current
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color
                                          ?.withOpacity(.2),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: SizedBox(
              // color: Colors.grey.shade600,
              width: phoneWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CYCLE NAME',
                      style: TextStyle(
                          wordSpacing: 2,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.green),
                    ),
                    verticalGap5,
                    const Divider(
                      thickness: 1,
                    ),
                    verticalGap5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "Primary Color",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Green"),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "75 km/h",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Speed"),
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          children: const [
                            Text(
                              "4.8",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Rating"),
                          ],
                        ),
                        horizontalGap5
                      ],
                    ),
                    verticalGap5,
                    const Divider(
                      thickness: 1,
                    ),
                    verticalGap5,
                    const Text(
                        "This section is for the description of the cycle shown in the above image."),
                    const Expanded(child: SizedBox()),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return FullButton(
                          onTap: () => state is ProfileFecthed
                              ? Navigator.pushNamed(
                                  context, Routes.cycleBookingScreen)
                              : showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const AuthenticationDialog(
                                    message:
                                        "Please login to access this feature.",
                                  ),
                                ),
                          padding: const EdgeInsets.all(10),
                          text: "SET TIME",
                        );
                      },
                    )
                  ],
                ),
              ),
            )),
          ],
        ));
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              offset: const Offset(0, 6),
              color: Theme.of(context).highlightColor)
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ));
  }
}
