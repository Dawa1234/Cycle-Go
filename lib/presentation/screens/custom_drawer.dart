import 'package:cyclego/constants/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  List<String> routes = [
    'Theme',
    'HelpAndSupport',
    'AboutUs',
    'Settings',
    'Fav',
    'LogOut',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: [
          userProfile(),
          const Divider(
            thickness: 1,
          ),
          // options
          ListView.separated(
            shrinkWrap: true,
            itemCount: routes.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              return customerDrawerOptions(routes[index]);
            },
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget userProfile() {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(blurRadius: 1, spreadRadius: 2, color: Colors.black12)
              ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                'Anonymous',
                style: TextStyle(
                    color: Colors.green.shade600, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget customerDrawerOptions(String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _getOptionsIcon(option),
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
    );
  }

  Widget _getOptionsIcon(String option) {
    // 'HelpAndSupport',
    // 'AboutUs',
    // 'Settings',
    // 'Fav',
    // 'LogOut',
    switch (option) {
      case 'Theme':
        return const Icon(Icons.thermostat);
      case 'HelpAndSupport':
        return const Icon(Icons.support_agent);
      case 'AboutUs':
        return const Icon(Icons.help);
      case 'Settings':
        return const Icon(Icons.settings);
      case 'Fav':
        return const Icon(Icons.heart_broken_rounded);
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
      case 'Fav':
        return "Your Favourites";
      default:
        return "";
    }
  }
}