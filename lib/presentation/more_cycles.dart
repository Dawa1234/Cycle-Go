import 'package:cyclego/constants/enums/enum.dart';
import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/buttons.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/drawer/custom_drawer.dart';
import 'package:cyclego/presentation/extras/all_cycles.dart';
import 'package:cyclego/presentation/extras/booked_cycles.dart';
import 'package:cyclego/presentation/extras/favorites.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreCycleScreen extends StatefulWidget {
  final int? currentBtmNavIndex;
  const MoreCycleScreen({Key? key, this.currentBtmNavIndex}) : super(key: key);

  @override
  State<MoreCycleScreen> createState() => _MoreCycleScreenState();
}

class _MoreCycleScreenState extends State<MoreCycleScreen> {
  late int _currentBtmNavIndex;
  late PageController _pageController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentBtmNavIndex = widget.currentBtmNavIndex!;
    _pageController = PageController(initialPage: widget.currentBtmNavIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _getCurrentAppBar(),
      body: Column(
        children: [
          _appBarContainer(),
          Expanded(
              child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() => _currentBtmNavIndex = value);
              },
              children: const [
                AllCycleScreen(),
                FavoritesScreen(),
                BookedCycles(),
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        height: 56,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              color: Theme.of(context).highlightColor)
        ], color: Colors.red, borderRadius: BorderRadius.circular(100)),
        margin: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
        child: BottomNavigationBar(
            unselectedItemColor: Colors.grey.shade500,
            selectedItemColor: Colors.green.shade700,
            iconSize: 23,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentBtmNavIndex,
            onTap: (value) {
              if (value != 3) {
                setState(() => _currentBtmNavIndex = value);
                // _pageController.jumpToPage(_currentBtmNavIndex);
                _pageController.animateToPage(_currentBtmNavIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              } else {
                scaffoldKey.currentState!.openDrawer();
              }
            },
            items: [
              BottomNavigationBarItem(
                  label: "Home".tr(), icon: const Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Favourite".tr(), icon: const Icon(Icons.favorite)),
              BottomNavigationBarItem(
                  label: "Booked".tr(), icon: const Icon(Icons.bookmark)),
              BottomNavigationBarItem(
                  label: "Navigation".tr(), icon: const Icon(Icons.menu)),
            ]),
      ),
      drawer: const CustomDrawer(),
    );
  }

  Widget _appBarContainer() {
    switch (_currentBtmNavIndex) {
      case 0:
        return AppBarContainer(
          height: context.locale == const Locale('en', 'US') ? 90 : 150,
          topText: Row(
            children: [
              Text(
                "${"Hello".tr()}, ",
                style: const TextStyle(color: Colors.white),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileFecthed) {
                    return Text(
                      state.user.firstName!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    );
                  }
                  return const Text(
                    "Anonymous",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  );
                },
              ),
            ],
          ),
          bottomText: Text(
            "Choose Your Bike".tr(),
            style: const TextStyle(
                fontFamily: "",
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        );
      case 1:
        return const AppBarContainer(
          height: 95,
          topText: SizedBox(),
          bottomText: Text(
            "Your Favorites",
            style: TextStyle(
                fontFamily: "",
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        );
      case 2:
        return AppBarContainer(
          height: 95,
          topText: const SizedBox(),
          bottomText: Text(
            "Booked Status".tr(),
            style: const TextStyle(
                fontFamily: "",
                fontSize: 45,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  AppBar _getCurrentAppBar() {
    switch (_currentBtmNavIndex) {
      case 0:
        return AppBar(
          leading: const AppBackButton(),
          backgroundColor: appBarColor,
          actions: const [
            ProfileButton(),
          ],
        );
      case 1:
        return AppBar(
          leading: const LanguageButton(),
          backgroundColor: appBarColor,
          actions: const [
            SearchButton(
              currentScreen: CurrentScreen.fav,
            )
          ],
        );
      case 2:
        return AppBar(
          leading: const LanguageButton(),
          backgroundColor: appBarColor,
          actions: const [
            SearchButton(
              currentScreen: CurrentScreen.book,
            )
          ],
        );
      default:
        return AppBar();
    }
  }
}
