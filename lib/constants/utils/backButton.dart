import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Function()? onTap;
  const AppBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 0, 4),
      child: Container(
        padding: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
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
            onPressed: onTap ?? () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            )),
      ),
    );
  }
}
