import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyDataMessage {
  static Widget emptyDataMessage({double? height, required String message}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            "assets/icons/empty_data.svg",
            color: Colors.grey,
            height: height ?? 175,
          ),
        ),
        Text(
          message.tr(),
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
