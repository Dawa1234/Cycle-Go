import 'dart:developer';

import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final List<String> routes = [
    'Theme',
    'HelpAndSupport',
    'AboutUs',
    'Settings',
    'cycles',
    'Fav',
    'LogOut',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: Theme.of(context).scaffoldBackgroundColor,
      // color: Colors.grey.shade900,
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: [
          userProfile(context),
          const Divider(),
          // options
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    if (routes[index] == "Fav" || routes[index] == "LogOut") {
                      if (state is ProfileFecthed) {
                        return customerDrawerOptions(routes[index], context);
                      } else {
                        return const SizedBox();
                      }
                    } else {
                      return customerDrawerOptions(routes[index], context);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget userProfile(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFecthed) {
          return SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 2,
                              color: Colors.black12)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Icon(
                      Icons.person,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                verticalGap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hello, '),
                    Text(
                      state.user.firstName!,
                      style: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return Center(
            child: AppTheme.appIcon(80),
          );
        }
      },
    );
  }

  Widget customerDrawerOptions(String option, BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: InkWell(
                onTap: () {
                  if (option == "Settings" || option == "cycles") {
                    if (state is ProfileFecthed) {
                      _navigateTo(option, context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AuthenticationDialog(
                            message: "Please login to access this feature.",
                          );
                        },
                      );
                    }
                  } else {
                    _navigateTo(option, context);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: _getOptionsIcon(option, context),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getOptionTitle(option),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _getOptionSubTitle(option).isEmpty
                              ? const SizedBox()
                              : Text(_getOptionSubTitle(option),
                                  style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider()
          ],
        );
      },
    );
  }

  Widget _getOptionsIcon(String option, BuildContext context) {
    switch (option) {
      case 'Theme':
        return SvgPicture.asset(
          "assets/icons/dark_light.svg",
          width: 22,
          color: Theme.of(context).primaryColor,
        );
      case 'HelpAndSupport':
        return const Icon(Icons.support_agent);
      case 'AboutUs':
        return const Icon(Icons.help);
      case 'Settings':
        return const Icon(
          Icons.settings,
        );
      case 'cycles':
        return const Icon(Icons.bike_scooter);
      case 'Fav':
        return SvgPicture.asset(
          "assets/icons/heart.svg",
          width: 22,
          color: Theme.of(context).primaryColor,
        );
      case 'LogOut':
        return const Icon(Icons.logout);
      default:
        return const Icon(Icons.thermostat);
    }
  }

  String _getOptionTitle(String option) {
    switch (option) {
      case 'Theme':
        return "Toggle Theme";
      case 'HelpAndSupport':
        return "Help And Support";
      case 'AboutUs':
        return "About Us";
      case 'Settings':
        return "Settings";
      case 'cycles':
        return "Explore Cycles";
      case 'Fav':
        return "Favorite";
      case 'LogOut':
        return "Log Out";
      default:
        return "";
    }
  }

  String _getOptionSubTitle(String option) {
    switch (option) {
      case 'Theme':
        return "Dark/Light Theme";
      case 'HelpAndSupport':
        return "Contacts and related information";
      case 'AboutUs':
        return "Version number / Release notes";
      case 'Settings':
        return "Edit Profile / Related Data";
      case 'cycles':
        return "See available cycles";
      case 'Fav':
        return "Your Favourites";
      default:
        return "";
    }
  }

  _navigateTo(String option, BuildContext ctx) {
    switch (option) {
      case 'Theme':
        ShowBottomModalSheet.showDarkModeToggleSnackBar(context: ctx);
        break;
      case 'HelpAndSupport':
        Navigator.pushNamed(ctx, Routes.helpAndSupport);
        break;
      case 'AboutUs':
        Navigator.pushNamed(ctx, Routes.aboutUs);
        break;
      case 'Settings':
        Navigator.pushNamed(ctx, Routes.settings);
        break;
      case 'cycles':
        Navigator.pushNamed(ctx, Routes.more_cycles);
        break;
      case 'Fav':
        log("Favorite");
        break;
      case 'LogOut':
        showDialog(
          context: ctx,
          builder: (context) =>
              const LogOutDialog(message: "Are you sure? You want to log out?"),
        );
        break;
      default:
        break;
    }
  }
}
