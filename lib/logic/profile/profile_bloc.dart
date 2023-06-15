import 'package:bloc/bloc.dart';
import 'package:cyclego/data/models/user.dart';
import 'package:cyclego/data/repository/userRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  _init(ProfileInitialEvent event, emit) {
    try {} catch (e) {
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
        emit(ProfileFecthed(user: userData['user'], message: 'Login Success'));
      } else {
        emit(ProfileFecthFailed(error: error));
      }
    } catch (e) {
      emit(ProfileFecthFailed(error: error));
    }
  }

  _updatedProfile(event, emit) {}

  _logOutProfile(event, emit) {
    emit(PorfileLoggingOut());
    try {
      emit(PorfileLoggedOut());
    } catch (e) {
      emit(PorfileLogOutError(error: e.toString()));
    }
  }
}
