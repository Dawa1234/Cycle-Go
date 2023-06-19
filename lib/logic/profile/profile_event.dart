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
  UserModel user;
  File? imageFile;
  bool removePic;
  String? firstName;
  String? lastName;
  ProfileUpdateEvent(
      {required this.user,
      this.imageFile,
      this.firstName,
      this.lastName,
      required this.removePic});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
