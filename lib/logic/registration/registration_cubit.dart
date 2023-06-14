import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cyclego/data/repository/userRepo.dart';
import 'package:equatable/equatable.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final UserRepository _userRepository = UserRepository();
  RegistrationCubit() : super(RegistrationInitail());

  registerUser(String username, String password) async {
    emit(RegistrationLoading());
    try {
      Map<String, dynamic> userData =
          await _userRepository.registerUser(username, password);
      if (userData['success']) {
        emit(RegistrationComplete());
        log('Registration Success');
      } else {
        emit(RegistrationError(errorMessage: userData['error']));
      }
    } catch (e) {
      emit(RegistrationError(errorMessage: e.toString()));
    }
  }
}
