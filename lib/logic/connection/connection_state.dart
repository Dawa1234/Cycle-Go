part of 'connection_cubit.dart';

@immutable
abstract class CheckConnectionState extends Equatable {}

class ConnectionEstablishedOnWifi extends CheckConnectionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectionEstablishedOnMobileData extends CheckConnectionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectionEstablished extends CheckConnectionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectionLost extends CheckConnectionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
