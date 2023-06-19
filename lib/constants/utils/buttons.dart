import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileButton extends StatelessWidget {
  final Function()? onTap;
  const ProfileButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state is ProfileFecthed
            ? Padding(
                // padding: const EdgeInsets.all(0),
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                      image: state.userData!.profileImage!.isNotEmpty
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(state.userData!.profileImage!))
                          : null,
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Theme.of(context).highlightColor)
                      ]),
                  child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      iconSize: 20,
                      onPressed: onTap ??
                          () => Navigator.pushNamed(context, Routes.profile),
                      icon: state.userData!.profileImage!.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: Colors.green,
                            )
                          : const SizedBox()),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class SearchButton extends StatelessWidget {
  final Function()? onTap;
  const SearchButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Theme.of(context).highlightColor)
            ]),
        child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            iconSize: 20,
            onPressed:
                onTap ?? () => Navigator.pushNamed(context, Routes.profile),
            icon: const Icon(
              Icons.search,
              color: Colors.green,
            )),
      ),
    );
  }
}

class FavButton extends StatelessWidget {
  final Function()? onTap;
  const FavButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(0),
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Theme.of(context).highlightColor)
            ]),
        child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            iconSize: 20,
            onPressed: onTap ?? () {},
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            )),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Function()? onTap;
  const LanguageButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Theme.of(context).highlightColor)
              ]),
          child: const Text(
            "EN",
            style: TextStyle(letterSpacing: 1, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
