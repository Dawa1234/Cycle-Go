import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          backgroundColor: appBarColor,
          title: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "PROFILE",
              style:
                  TextStyle(fontFamily: "", color: Colors.white, fontSize: 35),
            ),
          ),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdating) {}
            if (state is ProfileFecthed) {}
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                alignment: Alignment.bottomCenter,
                height: 210,
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
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [_profileImage(context), _fullName(context)],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                height: 65,
                width: phoneWidth(context),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    const Expanded(child: Text("User")),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.edit_square,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Theme.of(context).highlightColor)
                    ]),
              )
            ],
          ),
        ));
  }

  Widget _fullName(context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileUpdating) {
          return Text(
            state.user.firstName!,
            style: const TextStyle(
                letterSpacing: .5,
                fontFamily: "",
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
        }
        if (state is ProfileFecthed) {
          return Text(
            "${state.user.firstName!} ${state.user.lastName!}",
            style: const TextStyle(
                letterSpacing: .5,
                fontFamily: "",
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
        }
        return const Text(
          "Anonymous",
          style: TextStyle(
              letterSpacing: .5,
              fontFamily: "",
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        );
      },
    );
  }

  Widget _profileImage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileUpdating) {
          return Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/map.jpg")),
                color: Colors.red,
                shape: BoxShape.circle),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  right: -10,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_square,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        if (state is ProfileFecthed) {
          return Container(
            height: 150,
            width: 150,
            decoration: state.user.profileImage! == ""
                ? const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/map.jpg")),
                    color: Colors.red,
                    shape: BoxShape.circle)
                : BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(state.user.profileImage!)),
                    color: Colors.red,
                    shape: BoxShape.circle),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  right: -10,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_square,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/map.jpg")),
              color: Colors.red,
              shape: BoxShape.circle),
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                right: -10,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_square,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
