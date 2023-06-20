part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  UserModel? userData;
  ProfileState({this.userData});
  @override
  // TODO: implement props
  List<Object?> get props => [userData];
}

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

class ProfileUpdating extends ProfileState {
  UserModel user;
  ProfileUpdating({required this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class ProfileFecthed extends ProfileState {
  UserModel user;
  String message;
  ProfileFecthed({
    required this.user,
    required this.message,
  }) : super(userData: user);
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
  ProfileFecthFailed({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
