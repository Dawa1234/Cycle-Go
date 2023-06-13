import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: const Color.fromARGB(255, 39, 139, 233),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const AppBarContainer(
              topText: "SIGN IN TO",
              bottomText: "YOUR ACCOUNT",
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  verticalGap50,
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        enabledBorder: outlineInputBorder,
                        disabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        prefixIcon: const Icon(Icons.person),
                        labelText: "Username",
                        contentPadding: const EdgeInsets.all(18)),
                  ),
                  verticalGap30,
                  TextFormField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: outlineInputBorder,
                        disabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        contentPadding: const EdgeInsets.all(18),
                        prefixIcon: const Icon(Icons.lock),
                        labelText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility_off))),
                  ),
                  TextButton(
                    child: const Text("Forgot Password?"),
                    onPressed: () {},
                  ),
                  verticalGap20,
                  FullButton(
                      onTap: () {},
                      text: "LOGIN",
                      padding: const EdgeInsets.all(0)),
                  Column(
                    children: [
                      verticalGap20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          horizontalGap10,
                          Text("Other Options"),
                          horizontalGap10,
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      verticalGap20,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 55,
                            width: phoneWeight(context),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                    BorderSide(color: Colors.blue.shade700)),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                                splashColor: Colors.transparent,
                                textColor: Colors.white,
                                onPressed: () {},
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
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            "Login with Goggle",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          verticalGap50,
                          verticalGap50,
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  "Create Account.",
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
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10));
}
