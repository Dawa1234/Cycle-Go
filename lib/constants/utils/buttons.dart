import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final Function()? onTap;
  const ProfileButton({
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
                onTap ?? () => Navigator.pushNamed(context, Routes.aboutUs),
            icon: const Icon(
              Icons.person,
              color: Colors.green,
            )),
      ),
    );
  }
}
