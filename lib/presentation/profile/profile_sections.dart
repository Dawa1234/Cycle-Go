part of 'profile.dart';

class ProfileSectionContainer extends StatefulWidget {
  const ProfileSectionContainer({
    Key? key,
    required this.i,
    required this.user,
  }) : super(key: key);

  final int i;
  final UserModel user;

  @override
  State<ProfileSectionContainer> createState() =>
      _ProfileSectionContainerState();
}

class _ProfileSectionContainerState extends State<ProfileSectionContainer> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _currentFirstName = "";
  String _currentLastName = "";
  final _formKey = GlobalKey<FormState>();
  String _obscureText(String text) {
    String obscuredText = "";
    for (int i = 0; i < text.length; i++) {
      obscuredText = obscuredText + "*";
    }
    return obscuredText;
  }

  String? _getfullName({String? firstName, String? lastName}) {
    if (firstName != null && lastName != null) {
      return "$firstName $lastName";
    }
    return null;
  }

  get outlineInputBorder => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10));

  get outlineInputFocusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 39, 139, 233)),
      borderRadius: BorderRadius.circular(10));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController.text =
        BlocProvider.of<ProfileBloc>(context).state.userData!.firstName!;
    _lastNameController.text =
        BlocProvider.of<ProfileBloc>(context).state.userData!.lastName!;
    _currentFirstName = _firstNameController.text;
    _currentLastName = _lastNameController.text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.i == 4
          ? () => showDialog(
                context: context,
                builder: (context) => const LogOutDialog(
                    message: "Are you sure? You want to log out?"),
              )
          : widget.i == 3
              ? () => Navigator.pushNamed(context, Routes.helpAndSupport)
              : null,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        height: 65,
        width: phoneWidth(context),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(
                widget.i == 1
                    ? Icons.email
                    : widget.i == 2
                        ? Icons.lock
                        : widget.i == 3
                            ? Icons.support_agent
                            : widget.i == 4
                                ? Icons.logout
                                : Icons.person,
                size: 30,
              ),
            ),
            Expanded(
              child: Text(
                widget.i == 0
                    ? _getfullName(
                          firstName: widget.user.firstName,
                          lastName: widget.user.lastName,
                        ) ??
                        "none"
                    : widget.i == 1
                        ? widget.user.email ?? "none"
                        : widget.i == 2
                            ? _obscureText(widget.user.password ?? "none")
                            : widget.i == 3
                                ? "Support".tr()
                                : "Log Out".tr(),
              ),
            ),
            widget.i == 1 || widget.i == 4
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: widget.i == 0
                          ? () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                      right: 20,
                                      top: 20,
                                      left: 20,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _firstNameController,
                                                  autofocus: true,
                                                  style: TextStyle(
                                                      fontFamily: 'Tondo',
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  decoration: InputDecoration(
                                                      errorMaxLines: null,
                                                      enabledBorder:
                                                          outlineInputBorder,
                                                      disabledBorder:
                                                          outlineInputBorder,
                                                      focusedBorder:
                                                          outlineInputFocusedBorder,
                                                      focusedErrorBorder:
                                                          outlineInputFocusedBorder,
                                                      errorBorder:
                                                          outlineInputBorder,
                                                      prefixIcon: const Icon(
                                                          Icons.person),
                                                      labelText: "First Name",
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontFamily: 'Tondo',
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10)),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "*This field is required*";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              horizontalGap5,
                                              Expanded(
                                                child: TextFormField(
                                                  controller:
                                                      _lastNameController,
                                                  style: TextStyle(
                                                      fontFamily: 'Tondo',
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  decoration: InputDecoration(
                                                      errorMaxLines: null,
                                                      enabledBorder:
                                                          outlineInputBorder,
                                                      disabledBorder:
                                                          outlineInputBorder,
                                                      focusedBorder:
                                                          outlineInputFocusedBorder,
                                                      focusedErrorBorder:
                                                          outlineInputFocusedBorder,
                                                      errorBorder:
                                                          outlineInputBorder,
                                                      prefixIcon: const Icon(
                                                          Icons.person),
                                                      labelText: "Last Name",
                                                      labelStyle:
                                                          const TextStyle(
                                                        fontFamily: 'Tondo',
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              10)),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "*This field is required*";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalGap20,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () =>
                                                    handleDataUpdate(),
                                                child: const Text("Save")),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          : widget.i == 2
                              ? () => Navigator.pushNamed(
                                  context, Routes.updatePassword)
                              : widget.i == 3
                                  ? () => Navigator.pushNamed(
                                      context, Routes.helpAndSupport)
                                  : null,
                      child: Icon(
                        widget.i == 3
                            ? Icons.arrow_forward_ios
                            : Icons.edit_square,
                      ),
                    ),
                  )
          ],
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 2,
                  color: Theme.of(context).highlightColor)
            ]),
      ),
    );
  }

  void handleDataUpdate() {
    if (_currentFirstName != _firstNameController.text ||
        _currentLastName != _lastNameController.text) {
      if (_formKey.currentState!.validate()) {
        BlocProvider.of<ProfileBloc>(context).add(ProfileUpdateEvent(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            user: BlocProvider.of<ProfileBloc>(context).state.userData!,
            removePic: false));
        _currentFirstName = _firstNameController.text;
        _currentLastName = _lastNameController.text;
      }
    } else {
      Navigator.pop(context);
      SnackBarMessage.errorMessage(context, message: "No changes.");
    }
  }
}
