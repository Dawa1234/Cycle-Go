import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/no_glow_scroll.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:cyclego/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "abc@gmail.com");
  final _passwrodController = TextEditingController(text: "1231231231");
  bool _showPass = true;

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
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ProfileFetching) {
            PageLoading.showProgress(context);
          }
          if (state is ProfileFecthed) {
            Navigator.pop(context);
            Navigator.pop(context);
            SnackBarMessage.successMessage(context, message: state.message);
          }
          if (state is ProfileFecthFailed) {
            Navigator.pop(context);
            SnackBarMessage.errorMessage(context, message: state.error);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: ListView(
                children: [
                  AppBarContainer(
                    topText: Text(
                      "SIGN INTO".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 45),
                    ),
                    bottomText: Text(
                      "YOUR ACCOUNT".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 45),
                    ),
                    height: 135,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        verticalGap50,
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                              fontFamily: 'Tondo',
                              color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                              errorMaxLines: null,
                              enabledBorder: outlineInputBorder,
                              disabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputFocusedBorder,
                              focusedErrorBorder: outlineInputFocusedBorder,
                              errorBorder: outlineInputBorder,
                              prefixIcon: const Icon(Icons.person),
                              labelText: "Email".tr(),
                              labelStyle: const TextStyle(
                                fontFamily: 'Tondo',
                              ),
                              contentPadding: const EdgeInsets.all(18)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*This field is required*".tr();
                            }
                            return null;
                          },
                        ),
                        verticalGap30,
                        TextFormField(
                          controller: _passwrodController,
                          style: TextStyle(
                              fontFamily: 'Tondo',
                              color: Theme.of(context).primaryColor),
                          obscureText: _showPass,
                          decoration: InputDecoration(
                              errorMaxLines: null,
                              errorBorder: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              disabledBorder: outlineInputBorder,
                              focusedBorder: outlineInputFocusedBorder,
                              focusedErrorBorder: outlineInputFocusedBorder,
                              contentPadding: const EdgeInsets.all(18),
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Password".tr(),
                              labelStyle: const TextStyle(
                                fontFamily: 'Tondo',
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () =>
                                      setState(() => _showPass = !_showPass),
                                  icon: Icon(_showPass
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "*This field is required*".tr();
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).primaryColor,
                                  color: Colors.transparent,
                                  shadows: [
                                    Shadow(
                                        color: Theme.of(context).primaryColor,
                                        offset: const Offset(0, -2))
                                  ]),
                            ),
                          ),
                        ),
                        verticalGap20,
                        FullButton(
                            onTap: () => _handleLogin(googleLogin: false),
                            text: "LOGIN".tr(),
                            padding: const EdgeInsets.all(0)),
                        Column(
                          children: [
                            verticalGap20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Divider(
                                      color: Theme.of(context).primaryColor),
                                ),
                                horizontalGap10,
                                const Text("Other Options").tr(),
                                horizontalGap10,
                                Expanded(
                                  child: Divider(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            verticalGap20,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 55,
                                  width: phoneWidth(context),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                          color: Colors.blue.shade700)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MaterialButton(
                                      splashColor: Colors.transparent,
                                      onPressed:
                                          _handleLogin(googleLogin: true),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Image.asset(
                                                "assets/images/google.png"),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: Text(
                                                  "Login with Goggle".tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: 17,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                verticalGap50,
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text("Don't have an account?".tr()),
                                    InkWell(
                                      onTap: () => Navigator.pushNamed(
                                          context, Routes.registerScreen),
                                      child: Text(
                                        "Create Account.".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
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
                                  ],
                                ),
                                verticalGap10
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleLogin({required bool googleLogin}) {
    if (googleLogin) {
      BlocProvider.of<ProfileBloc>(context).add(
          ProfileFetchEvent(email: "", password: "", googleLogin: googleLogin));
      return;
    }
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ProfileBloc>(context).add(ProfileFetchEvent(
          email: _emailController.text,
          password: _passwrodController.text,
          googleLogin: googleLogin));
    }
  }

  get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10));
  get outlineInputFocusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 39, 139, 233)),
      borderRadius: BorderRadius.circular(10));
}
