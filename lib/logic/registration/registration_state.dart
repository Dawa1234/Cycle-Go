part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {}

class RegistrationInitail extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationComplete extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationError extends RegistrationState {
  String errorMessage;
  RegistrationError({required this.errorMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
