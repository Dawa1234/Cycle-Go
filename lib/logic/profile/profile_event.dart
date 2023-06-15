part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileInitialEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileFetchEvent extends ProfileEvent {
  String email;
  String password;
  ProfileFetchEvent({
    required this.email,
    required this.password,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class PorfileLogOutEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProfileUpdateEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
