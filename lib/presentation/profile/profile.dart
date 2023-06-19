import 'dart:developer';
import 'dart:io';

import 'package:cyclego/constants/ui/dark_theme_data.dart';
import 'package:cyclego/constants/utils/authentication_popUp.dart';
import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'profile_sections.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            if (state is ProfileUpdating) {
              PageLoading.showProgress(context);
            }
            if (state is ProfileFecthed) {
              SnackBarMessage.successMessage(context, message: state.message);
              Navigator.popUntil(context, ModalRoute.withName('/profile'));
            }
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
            "${state.user.firstName!} ${state.user.lastName!}",
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

  Future profileImageConfrimation(BuildContext ctx, [String? message]) async {
    return showDialog(
        barrierDismissible: true,
        context: ctx,
        builder: (BuildContext context) {
          return Material(
            color: const Color.fromARGB(89, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(imageFile!),
                    radius: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                imageFile = null;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black54,
                                ),
                              ),
                            )),
                        InkWell(
                            onTap: () {
                              BlocProvider.of<ProfileBloc>(context).add(
                                  ProfileUpdateEvent(
                                      user:
                                          BlocProvider.of<ProfileBloc>(context)
                                              .state
                                              .userData!,
                                      imageFile: imageFile,
                                      removePic: false));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.black54,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _getImage(BuildContext context, {required ImageSource source}) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        SnackBarMessage.errorMessage(context, message: "No Image Selected.");
        return;
      }
      imageFile = File(image.path);
      profileImageConfrimation(context);
    } catch (e) {
      log(e.toString());
    }
  }

  Widget _profileImage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileUpdating) {
          return Container(
            height: 150,
            width: 150,
            decoration: imageFile != null
                ? BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(imageFile!)),
                    color: Colors.white,
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
                        color: Colors.white,
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
                                    onPressed: () {},
                                    icon: const Icon(Icons.camera),
                                    label: const Text("Camera")),
                                ElevatedButton.icon(
                                    onPressed: () {},
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
            decoration: imageFile != null
                ? BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(imageFile!)),
                    color: Colors.white,
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
                        color: Colors.white,
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
                                    onPressed: () async => _getImage(context,
                                        source: ImageSource.camera),
                                    icon: const Icon(Icons.camera),
                                    label: const Text("Camera")),
                                ElevatedButton.icon(
                                    onPressed: () async => _getImage(context,
                                        source: ImageSource.gallery),
                                    icon: const Icon(
                                        Icons.photo_size_select_actual_sharp),
                                    label: const Text("Gallery")),
                                ElevatedButton.icon(
                                    onPressed: imageFile == null &&
                                            state.user.profileImage == ""
                                        ? null
                                        : () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return _removePhotoDialog(
                                                    context: context,
                                                    message: "Remove Photo?");
                                              },
                                            );
                                          },
                                    icon: const Icon(Icons.remove_circle_sharp),
                                    label: const Text("Remove")),
                              ],
                            ),
                          );
                        },
                      );
                    },
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

  Widget _removePhotoDialog(
      {required BuildContext context, required String message}) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      insetPadding:
          EdgeInsets.symmetric(horizontal: (phoneWidth(context) - 30) / 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                "assets/images/icon.jpg",
                filterQuality: FilterQuality.high,
                height: 55,
                width: 85,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: imageFile != null
                      ? () {
                          if (imageFile != null) {
                            setState(() => imageFile = null);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            SnackBarMessage.successMessage(context,
                                message: "Photo Removed.");
                          } else {
                            SnackBarMessage.successMessage(context,
                                message: "Photo Removed.");
                            Navigator.pop(context);
                          }
                        }
                      : () {
                          BlocProvider.of<ProfileBloc>(context).add(
                              ProfileUpdateEvent(
                                  user: BlocProvider.of<ProfileBloc>(context)
                                      .state
                                      .userData!,
                                  removePic: true));
                        },
                  child: Text(
                    imageFile != null
                        ? "Remove Selected Photo"
                        : "Remove Existing Photo",
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
