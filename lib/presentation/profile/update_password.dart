import 'dart:developer';

import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool _showCurrentPass = true;
  bool _showNewPass = true;
  bool _showRepeatPass = true;
  final _formKey = GlobalKey<FormState>();
  final _showCurrentPassController = TextEditingController();
  final _showNewPassController = TextEditingController();
  final _showRepeatPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text("Change Password"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).highlightColor,
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _showCurrentPassController,
                style: const TextStyle(color: Colors.black),
                obscureText: _showCurrentPass,
                validator: validatePassword,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () =>
                        setState(() => _showCurrentPass = !_showCurrentPass),
                    child: Icon(_showCurrentPass
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  hintText: "Current Password",
                  enabledBorder: outLineBorder,
                  focusedBorder: outLineBorder,
                  disabledBorder: outLineBorder,
                  errorBorder: outLineBorder,
                  focusedErrorBorder: outLineBorder,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).highlightColor,
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _showNewPassController,
                style: const TextStyle(color: Colors.black),
                obscureText: _showNewPass,
                validator: validatePassword,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () => setState(() => _showNewPass = !_showNewPass),
                    child: Icon(
                        _showNewPass ? Icons.visibility_off : Icons.visibility),
                  ),
                  hintText: "New Password",
                  enabledBorder: outLineBorder,
                  focusedBorder: outLineBorder,
                  disabledBorder: outLineBorder,
                  errorBorder: outLineBorder,
                  focusedErrorBorder: outLineBorder,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).highlightColor,
                        blurRadius: 3,
                        spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _showRepeatPassController,
                style: const TextStyle(color: Colors.black),
                obscureText: _showRepeatPass,
                validator: validatePassword,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () =>
                        setState(() => _showRepeatPass = !_showRepeatPass),
                    child: Icon(_showRepeatPass
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  hintText: "Repeat Password",
                  enabledBorder: outLineBorder,
                  focusedBorder: outLineBorder,
                  disabledBorder: outLineBorder,
                  errorBorder: outLineBorder,
                  focusedErrorBorder: outLineBorder,
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
            ),
            verticalGap30,
            FullButton(
                buttonHeight: 50,
                fontSize: 15,
                onTap: _handleChangePassword,
                text: "Change Passowrd",
                letterSpacing: .8,
                padding: const EdgeInsets.symmetric(horizontal: 30)),
            const Expanded(child: SizedBox()),
            AppUtils.bottomInformation(),
            verticalGap10,
            verticalGap5,
          ],
        ),
      ),
    );
  }

  _handleChangePassword() {
    if (_formKey.currentState!.validate()) {
      log("Change Password");
    }
  }

  get outLineBorder => const OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent));
  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "*Password must have at least 8 characters*";
    }
    return null;
  }
}
