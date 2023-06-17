import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/logic/registration/registration_cubit.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: "123");
  final _lastNameController = TextEditingController(text: "123");
  final _emailController = TextEditingController(text: "abc@gmail.com");
  final _passwrodController = TextEditingController(text: "123123123");
  final _confirmPasswrodController = TextEditingController(text: "123123123");
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
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            // behavior: MyBehavior(),
            child: MultiBlocListener(
                listeners: [
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileFecthed) {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                        Navigator.pushNamed(context, Routes.cycleDescription);
                        SnackBarMessage.successMessage(context,
                            message: state.message);
                      }
                    },
                  ),
                  BlocListener<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is RegistrationLoading) {
                        PageLoading.showProgress(context);
                      }
                      if (state is RegistrationComplete) {
                        BlocProvider.of<ProfileBloc>(context).add(
                            ProfileFetchEvent(
                                email: _emailController.text,
                                password: _passwrodController.text));
                        Navigator.pop(context);
                      }
                      if (state is RegistrationError) {
                        Navigator.pop(context);
                        SnackBarMessage.errorMessage(context,
                            message: state.errorMessage.split(']')[1]);
                      }
                    },
                  )
                ],
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      AppBarContainer(
                        topText: Text(
                          "REGISTER NEW",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 45),
                        ),
                        bottomText: Text(
                          "ACCOUNT",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 45),
                        ),
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
                                  errorStyle: const TextStyle(fontSize: 11),
                                  enabledBorder: outlineInputBorder,
                                  disabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputFocusedBorder,
                                  focusedErrorBorder: outlineErrorBorder,
                                  errorBorder: outlineErrorBorder,
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: "First Name",
                                  labelStyle:
                                      const TextStyle(fontFamily: 'Tondo'),
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
                                  errorStyle: const TextStyle(fontSize: 11),
                                  enabledBorder: outlineInputBorder,
                                  disabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputFocusedBorder,
                                  focusedErrorBorder: outlineErrorBorder,
                                  errorBorder: outlineErrorBorder,
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: "Last Name",
                                  labelStyle:
                                      const TextStyle(fontFamily: 'Tondo'),
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
                              controller: _emailController,
                              style: TextStyle(
                                  fontFamily: 'Tondo',
                                  color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  errorStyle: const TextStyle(fontSize: 11),
                                  enabledBorder: outlineInputBorder,
                                  disabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputFocusedBorder,
                                  focusedErrorBorder: outlineErrorBorder,
                                  errorBorder: outlineErrorBorder,
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: "Username",
                                  labelStyle:
                                      const TextStyle(fontFamily: 'Tondo'),
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
                                  errorStyle: const TextStyle(fontSize: 11),
                                  errorBorder: outlineErrorBorder,
                                  enabledBorder: outlineInputBorder,
                                  disabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputFocusedBorder,
                                  focusedErrorBorder: outlineErrorBorder,
                                  contentPadding: const EdgeInsets.all(18),
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: "Password",
                                  labelStyle:
                                      const TextStyle(fontFamily: 'Tondo'),
                                  suffixIcon: IconButton(
                                      onPressed: () => setState(
                                          () => _showPass = !_showPass),
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
                                  errorStyle: const TextStyle(fontSize: 11),
                                  errorBorder: outlineErrorBorder,
                                  enabledBorder: outlineInputBorder,
                                  disabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputFocusedBorder,
                                  focusedErrorBorder: outlineErrorBorder,
                                  contentPadding: const EdgeInsets.all(18),
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: "Confirm Password",
                                  labelStyle:
                                      const TextStyle(fontFamily: 'Tondo'),
                                  suffixIcon: IconButton(
                                      onPressed: () => setState(
                                          () => _showPass1 = !_showPass1),
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Text(
                                      "Sign In.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Colors.green.shade500,
                                          color: Colors.transparent,
                                          shadows: [
                                            Shadow(
                                                color: Colors.green.shade500,
                                                offset: const Offset(0, -2))
                                          ]),
                                    ),
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
                )),
          ),
        ));
  }

  _handleLogin() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RegistrationCubit>(context).registerUser(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwrodController.text.trim().toLowerCase(),
          userModel: UserModel(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwrodController.text,
            profileImage: "",
          ));
    }
  }

  get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10));
  get outlineErrorBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10));
  get outlineInputFocusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 39, 139, 233)),
      borderRadius: BorderRadius.circular(10));
}
