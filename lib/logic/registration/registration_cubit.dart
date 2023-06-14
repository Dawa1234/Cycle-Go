import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/data/repository/userRepo.dart';
import 'package:equatable/equatable.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final UserRepository _userRepository = UserRepository();
  RegistrationCubit() : super(RegistrationInitail());

  registerUser(
      {required String email,
      required String password,
      required UserModel userModel}) async {
    emit(RegistrationLoading());
    try {
      Map<String, dynamic> userData =
          await _userRepository.registerUser(email, password, userModel);
      if (userData['success']) {
        emit(RegistrationComplete(message: 'Account Created.'));
      } else {
        emit(RegistrationError(errorMessage: userData['error']));
      }
    } catch (e) {
      emit(RegistrationError(errorMessage: e.toString()));
    }
  }
}
