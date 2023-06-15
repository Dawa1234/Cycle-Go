part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileFetching extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileFecthed extends ProfileState {
  UserModel user;
  String message;
  ProfileFecthed({
    required this.user,
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [user, message];
}

class PorfileLoggingOut extends ProfileState {
  PorfileLoggingOut();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PorfileLoggedOut extends ProfileState {
  PorfileLoggedOut();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PorfileLogOutError extends ProfileState {
  String error;
  PorfileLogOutError({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class ProfileFecthFailed extends ProfileState {
  String error;
  ProfileFecthFailed({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
