import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/registration/registration_cubit.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwrodController = TextEditingController();
  final _confirmPasswrodController = TextEditingController();
  bool _showPass = true;
  bool _showPass1 = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: const Color.fromARGB(255, 39, 139, 233),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            // behavior: MyBehavior(),
            child: ListView(
              children: [
                const AppBarContainer(
                  topText: "REGISTER",
                  bottomText: "NEW ACCOUNT",
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      verticalGap30,
                      verticalGap10,
                      TextFormField(
                        controller: _firstNameController,
                        style: TextStyle(
                            fontFamily: 'Tondo',
                            color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            enabledBorder: outlineInputBorder,
                            disabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputFocusedBorder,
                            focusedErrorBorder: outlineInputFocusedBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: const Icon(Icons.person),
                            labelText: "First Name",
                            labelStyle: const TextStyle(fontFamily: 'Tondo'),
                            contentPadding: const EdgeInsets.all(18)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*This field is required*";
                          }
                          if (value.length < 3) {
                            return "*At least 3 charater is required*";
                          }
                          return null;
                        },
                      ),
                      verticalGap20,
                      TextFormField(
                        controller: _lastNameController,
                        style: TextStyle(
                            fontFamily: 'Tondo',
                            color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            enabledBorder: outlineInputBorder,
                            disabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputFocusedBorder,
                            focusedErrorBorder: outlineInputFocusedBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Last Name",
                            labelStyle: const TextStyle(fontFamily: 'Tondo'),
                            contentPadding: const EdgeInsets.all(18)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*This field is required*";
                          }
                          if (value.length < 3) {
                            return "*At least 3 charater is required*";
                          }
                          return null;
                        },
                      ),
                      verticalGap20,
                      TextFormField(
                        controller: _usernameController,
                        style: TextStyle(
                            fontFamily: 'Tondo',
                            color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                            enabledBorder: outlineInputBorder,
                            disabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputFocusedBorder,
                            focusedErrorBorder: outlineInputFocusedBorder,
                            errorBorder: outlineInputBorder,
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Username",
                            labelStyle: const TextStyle(fontFamily: 'Tondo'),
                            contentPadding: const EdgeInsets.all(18)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*This field is required*";
                          }
                          if (value.length < 5) {
                            return "*At least 5 charater is required*";
                          }
                          return null;
                        },
                      ),
                      verticalGap20,
                      TextFormField(
                        controller: _passwrodController,
                        style: TextStyle(
                            fontFamily: 'Tondo',
                            color: Theme.of(context).primaryColor),
                        obscureText: _showPass,
                        decoration: InputDecoration(
                            errorBorder: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            disabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputFocusedBorder,
                            focusedErrorBorder: outlineInputFocusedBorder,
                            contentPadding: const EdgeInsets.all(18),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: "Password",
                            labelStyle: const TextStyle(fontFamily: 'Tondo'),
                            suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _showPass = !_showPass),
                                icon: Icon(_showPass
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*This field is required*";
                          }
                          if (value.length < 8) {
                            return "*Password must have atleast 8 character*";
                          }
                          if (_passwrodController.text !=
                              _confirmPasswrodController.text) {
                            return "*Password did not match*";
                          }
                          return null;
                        },
                      ),
                      verticalGap20,
                      TextFormField(
                        controller: _confirmPasswrodController,
                        style: TextStyle(
                            fontFamily: 'Tondo',
                            color: Theme.of(context).primaryColor),
                        obscureText: _showPass1,
                        decoration: InputDecoration(
                            errorBorder: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            disabledBorder: outlineInputBorder,
                            focusedBorder: outlineInputFocusedBorder,
                            focusedErrorBorder: outlineInputFocusedBorder,
                            contentPadding: const EdgeInsets.all(18),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(fontFamily: 'Tondo'),
                            suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _showPass1 = !_showPass1),
                                icon: Icon(_showPass1
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*This field is required*";
                          }
                          if (value.length < 8) {
                            return "*Password must have atleast 8 character*";
                          }
                          if (_passwrodController.text !=
                              _confirmPasswrodController.text) {
                            return "*Password did not match*";
                          }
                          return null;
                        },
                      ),
                      verticalGap10,
                      verticalGap20,
                      FullButton(
                          onTap: _handleLogin,
                          text: "REGISTER",
                          padding: const EdgeInsets.all(0)),
                      verticalGap30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Sign In.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.green.shade500,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                        color: Colors.green.shade500,
                                        offset: const Offset(0, -2))
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      verticalGap10
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleLogin() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegistrationCubit>(context)
          .registerUser(_usernameController.text, _passwrodController.text);
    }
  }

  get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10));
  get outlineInputFocusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 39, 139, 233)),
      borderRadius: BorderRadius.circular(10));
}
