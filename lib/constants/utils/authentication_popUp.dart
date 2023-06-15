import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationDialog extends StatelessWidget {
  final String message;
  const AuthenticationDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      insetPadding:
          EdgeInsets.symmetric(horizontal: (phoneWeight(context) - 100) / 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Login Required",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                  //minWidth: 80,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, Routes.loginScreen);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.0,
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

class LogOutDialog extends StatelessWidget {
  final String message;
  const LogOutDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is PorfileLoggingOut) {
          PageLoading.showProgress(context);
        }
        if (state is PorfileLoggingOut) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is PorfileLogOutError) {
          SnackBarMessage.errorMessage(context, message: state.error);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        insetPadding:
            EdgeInsets.symmetric(horizontal: (phoneWeight(context) - 100) / 5),
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
                    onPressed: () {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(PorfileLogOutEvent());
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
