import 'dart:developer';
import 'dart:io';

import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  File? imageFile;
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
              for (int i = 0; i < 5; i++) ...{
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileUpdating) {
                      return ProfileSectionContainer(
                        i: i,
                        user: state.user,
                      );
                    }
                    if (state is ProfileFecthed) {
                      return ProfileSectionContainer(
                        i: i,
                        user: state.user,
                      );
                    }
                    return ProfileSectionContainer(
                      i: i,
                      user: UserModel(),
                    );
                  },
                )
              }
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
            decoration: imageFile != null
                ? BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(imageFile!)),
                    color: Colors.red,
                    shape: BoxShape.circle)
                : state.user.profileImage! == ""
                    ? const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/images/default_user.jpg")),
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
                  bottom: -12,
                  right: -12,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        var image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        if (image == null) {
                                          SnackBarMessage.errorMessage(context,
                                              message: "No Image Selected.");
                                          return;
                                        }
                                        imageFile = File(image.path);
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text("Camera")),
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        var image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (image == null) {
                                          SnackBarMessage.errorMessage(context,
                                              message: "No Image Selected.");
                                          return;
                                        }
                                        imageFile = File(image.path);
                                      } catch (e) {
                                        log(e.toString());
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.photo_size_select_actual_sharp),
                                    label: const Text("Gallery")),
                                ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove_circle_sharp),
                                    label: const Text("Remove")),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit_square,
                      color: Colors.green.shade300,
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

class ProfileSectionContainer extends StatelessWidget {
  const ProfileSectionContainer({
    Key? key,
    required this.i,
    required this.user,
  }) : super(key: key);

  final int i;
  final UserModel user;

  String _obscureText(String text) {
    String obscuredText = "";
    for (int i = 0; i < text.length; i++) {
      obscuredText = obscuredText + "*";
    }
    return obscuredText;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: i == 4
          ? () => showDialog(
                context: context,
                builder: (context) => const LogOutDialog(
                    message: "Are you sure? You want to log out?"),
              )
          : null,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        height: 65,
        width: phoneWidth(context),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(
                i == 2
                    ? Icons.lock
                    : i == 3
                        ? Icons.support_agent
                        : i == 4
                            ? Icons.logout
                            : Icons.person,
                size: 30,
              ),
            ),
            Expanded(
              child: Text(
                i == 0
                    ? user.firstName ?? "none"
                    : i == 1
                        ? user.email ?? "none"
                        : i == 2
                            ? _obscureText(user.password ?? "none")
                            : i == 3
                                ? "Support"
                                : "Log out",
              ),
            ),
            i == 1 || i == 4
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: i == 0
                          ? () => log("Edit username")
                          : i == 2
                              ? () => log("Edit password")
                              : i == 3
                                  ? () => log("Support")
                                  : null,
                      child: Icon(
                        i == 3 ? Icons.arrow_forward_ios : Icons.edit_square,
                      ),
                    ),
                  )
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
      ),
    );
  }
}
