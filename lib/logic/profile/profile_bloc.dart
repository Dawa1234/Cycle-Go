import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/data/repository/userRepo.dart';
import 'package:cyclego/get_it/get_it.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(_init);
    on<ProfileFetchEvent>(_fetchProfile);
    on<PorfileLogOutEvent>(_logOutProfile);
    on<ProfileUpdateEvent>(_updatedProfile);
  }
  _init(ProfileInitialEvent event, emit) async {
    String error = "";
    try {
      final pref = getIt.get<SharedPreferences>();
      final email = pref.getString('email') ?? "";
      final password = pref.getString('password') ?? "";
      final userData = await userRepository.loginUser(email, password);
      error = userData['error'] ?? "";
      if (userData['success']) {
        emit(ProfileFecthed(user: userData['data'], message: 'Login Success'));
      } else {
        emit(ProfileFecthFailed(error: error));
      }
    } catch (e) {
      String error = e.toString().split("]")[1];
      emit(ProfileFecthFailed(error: error));
    }
  }

  _fetchProfile(ProfileFetchEvent event, emit) async {
    String error = "";
    emit(ProfileFetching());
    try {
      final userData =
          await userRepository.loginUser(event.email, event.password);
      error = userData['error'] ?? "";
      if (userData['success']) {
        await saveLoginData(event.email, event.password).whenComplete(() =>
            emit(ProfileFecthed(
                user: userData['data'], message: 'Login Success')));
      } else {
        emit(ProfileFecthFailed(error: error));
      }
    } catch (e) {
      emit(ProfileFecthFailed(error: error));
    }
  }

  _updatedProfile(ProfileUpdateEvent event, emit) async {
    Map<String, dynamic> response = {};
    String successMessage = "";
    emit(ProfileUpdating(user: event.user));
    try {
      if (event.firstName != null || event.lastName != null) {
        response = await userRepository.updateProfileInfo(
          firstName: event.firstName!,
          lastName: event.lastName!,
        );
        successMessage = "Profile Updated.";
      } else if (event.currentPassword != null && event.newPassword != null) {
        response = await userRepository.updatePassword(
            currentPassword: event.currentPassword!,
            newPassword: event.newPassword!);
        successMessage = "Password Updated.";
      } else {
        response = await userRepository.profilePicUpdate(
            toRemove: event.removePic, imageFile: event.imageFile ?? File(""));
        successMessage = "Profile Picture Updated.";
      }

      if (response['success']) {
        emit(ProfileFecthed(user: response['data'], message: successMessage));
      } else {
        emit(ProfileFecthFailed(error: response['error']));
      }
    } catch (e) {
      emit(ProfileFecthFailed(error: e.toString()));
    }
  }

  _logOutProfile(event, emit) async {
    emit(PorfileLoggingOut());
    final pref = getIt.get<SharedPreferences>();
    bool dataRemoved = false;
    try {
      await pref.remove('email').whenComplete(() => dataRemoved = true);
      dataRemoved = false;
      await pref.remove('password').whenComplete(() => dataRemoved = true);
      if (dataRemoved) {
        emit(PorfileLoggedOut());
      } else {
        emit(PorfileLogOutError(error: "Please restart application."));
      }
    } catch (e) {
      emit(PorfileLogOutError(error: e.toString()));
    }
  }

  Future<bool> saveLoginData(String email, String password) async {
    bool dataSaved = false;
    try {
      final sharedPref = getIt.get<SharedPreferences>();
      await sharedPref
          .setString('email', email)
          .whenComplete(() => dataSaved = true);
      dataSaved = false;
      await sharedPref
          .setString('password', password)
          .whenComplete(() => dataSaved = true);
      final savedEmail = sharedPref.getString('email');
      final savedPass = sharedPref.getString('password');
      log(savedEmail.toString());
      log(savedPass.toString());
      return dataSaved;
    } catch (e) {
      log(e.toString());
      return Future.value(false);
    }
  }
}
