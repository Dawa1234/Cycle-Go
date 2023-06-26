import 'package:cyclego/constants/utils/backButton.dart';
import 'package:cyclego/constants/utils/loading.dart';
import 'package:cyclego/constants/utils/pop_up.dart';
import 'package:cyclego/constants/utils/utils.dart';
import 'package:cyclego/logic/profile/profile_bloc.dart';
import 'package:cyclego/presentation/screens/start_up_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late ProfileBloc _profileBloc;
  bool _showCurrentPass = true;
  bool _showNewPass = true;
  bool _showRepeatPass = true;
  final _formKey = GlobalKey<FormState>();
  final _showCurrentPassController = TextEditingController();
  final _showNewPassController = TextEditingController();
  final _showRepeatPassController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = ProfileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text("Change Password".tr()),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: BlocListener<ProfileBloc, ProfileState>(
                bloc: _profileBloc,
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is ProfileUpdating) {
                    PageLoading.showProgress(context);
                  }
                  if (state is ProfileFecthed) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    SnackBarMessage.successMessage(context,
                        message: state.message);
                  }
                  if (state is ProfileFecthFailed) {
                    Navigator.pop(context);
                    SnackBarMessage.errorMessage(context, message: state.error);
                  }
                },
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                      height: 85,
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).highlightColor,
                                      blurRadius: 3,
                                      spreadRadius: 1)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          TextFormField(
                            controller: _showCurrentPassController,
                            style: TextStyle(color: Colors.grey.shade500),
                            obscureText: _showCurrentPass,
                            validator: validatePassword,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                    () => _showCurrentPass = !_showCurrentPass),
                                child: Icon(_showCurrentPass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: "Current Password".tr(),
                              enabledBorder: outLineBorder,
                              focusedBorder: outLineBorder,
                              disabledBorder: outLineBorder,
                              errorBorder: outLineBorder,
                              focusedErrorBorder: outLineBorder,
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                      height: 85,
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).highlightColor,
                                      blurRadius: 3,
                                      spreadRadius: 1)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          TextFormField(
                            controller: _showNewPassController,
                            style: TextStyle(color: Colors.grey.shade500),
                            obscureText: _showNewPass,
                            validator: validateNewPassword,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                    () => _showNewPass = !_showNewPass),
                                child: Icon(_showNewPass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: "New Password".tr(),
                              enabledBorder: outLineBorder,
                              focusedBorder: outLineBorder,
                              disabledBorder: outLineBorder,
                              errorBorder: outLineBorder,
                              focusedErrorBorder: outLineBorder,
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                      height: 85,
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).highlightColor,
                                      blurRadius: 3,
                                      spreadRadius: 1)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          TextFormField(
                            controller: _showRepeatPassController,
                            style: TextStyle(color: Colors.grey.shade500),
                            obscureText: _showRepeatPass,
                            validator: validateNewPassword,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                    () => _showRepeatPass = !_showRepeatPass),
                                child: Icon(_showRepeatPass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: "Repeat Password".tr(),
                              enabledBorder: outLineBorder,
                              focusedBorder: outLineBorder,
                              disabledBorder: outLineBorder,
                              errorBorder: outLineBorder,
                              focusedErrorBorder: outLineBorder,
                              contentPadding: const EdgeInsets.all(20),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalGap30,
                    FullButton(
                        buttonHeight: 50,
                        fontSize: 15,
                        onTap: _handleChangePassword,
                        text: "Change Password".tr(),
                        letterSpacing: .8,
                        padding: const EdgeInsets.symmetric(horizontal: 30)),
                    verticalGap10,
                    verticalGap5,
                    AppUtils.bottomInformation(),
                    verticalGap10,
                    verticalGap5,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleChangePassword() {
    if (_formKey.currentState!.validate()) {
      _profileBloc.add(ProfileUpdateEvent(
          user: BlocProvider.of<ProfileBloc>(context).state.userData!,
          currentPassword: _showCurrentPassController.text,
          newPassword: _showNewPassController.text,
          removePic: false));
    }
  }

  get outLineBorder => const OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent));
  String? validatePassword(String? value) {
    if (value!.length < 8) {
      return "*Password must have atleast 8 character*".tr();
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value!.length < 8) {
      return "*Password must have atleast 8 character*".tr();
    }
    if (_showNewPassController.text != _showRepeatPassController.text) {
      return "*Password did not match*".tr();
    }
    return null;
  }
}
