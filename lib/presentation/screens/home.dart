import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/screens/custom_drawer.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState>? scaffoldKey;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_scaffoldKey');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaffoldKey = _scaffoldKey;
  }

  void openDrawer() {
    scaffoldKey?.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Container(
            height: phoneHeight(context),
            width: phoneWeight(context),
            color: Colors.white,
            // color: primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Row(
              children: [
                InkWell(
                  onTap: openDrawer,
                  child: Container(
                    height: 40,
                    width: 45,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 2,
                              spreadRadius: 1)
                        ]),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 180,
                        height: 40,
                        child: const Text(
                          "Our Location",
                          style: TextStyle(
                              fontFamily: 'Tondo',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 42, 42, 42)),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(0, 2),
                                  blurRadius: 3,
                                  spreadRadius: 1)
                            ]),
                      ),
                      const SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(bottom: 0, child: BottomInfo()),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

class BottomInfo extends StatelessWidget {
  const BottomInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      width: phoneWeight(context),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, -2))
      ]
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(30), topRight: Radius.circular(30))
          ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Bicycle',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey.shade800,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                            color: Colors.grey.shade800,
                            offset: const Offset(0, -6))
                      ]),
                ),
                InkWell(
                  onTap: () {},
                  child: Wrap(
                    children: [
                      Text(
                        'More',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.green,
                            color: Colors.transparent,
                            shadows: [
                              const Shadow(
                                  color: Colors.green, offset: Offset(0, -6))
                            ]),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) {
                return cycleContainer(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget cycleContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
              color: Colors.black26,
            )
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
                decorationColor: Colors.grey.shade800,
                color: Colors.transparent,
                shadows: [
                  Shadow(
                      color: Colors.grey.shade800, offset: const Offset(0, -6))
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
    );
  }
}
