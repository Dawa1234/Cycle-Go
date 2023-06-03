import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  Color? color;
  Color? backgroundColor;
  double strokeWidth = 0;
  LoadingBar({
    Key? key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class PageLoading {
  static Future showProgress(BuildContext ctx, [String? message]) async {
    return showDialog(
        // barrierDismissible: false,
        context: ctx,
        builder: (BuildContext context) {
          return const Center(
            child: CupertinoActivityIndicator(color: Colors.white),
          );
        });
  }
}
