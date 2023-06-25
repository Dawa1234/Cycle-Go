import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'connection_state.dart';

class ConnectionCubit extends Cubit<CheckConnectionState> {
  Connectivity connectivity;
  late StreamSubscription checkConnection;
  ConnectionCubit({required this.connectivity})
      : super(ConnectionEstablishedOnWifi()) {
    monitorConnection();
  }

  StreamSubscription monitorConnection() {
    return checkConnection =
        connectivity.onConnectivityChanged.listen((connectionType) {
      if (connectionType == ConnectivityResult.wifi) {
        connectionEstablishedOnWifi();
      }
      if (connectionType == ConnectivityResult.mobile) {
        connectionEstablishedOnData();
      }

      if (connectionType == ConnectivityResult.none) connectionLost();
    });
  }

  init() {
    connectivity.checkConnectivity().then((connection) {
      if (connection == ConnectivityResult.wifi) {
        connectionEstablishedOnWifi();
        return;
      }
      if (connection == ConnectivityResult.mobile) {
        connectionEstablishedOnData();
        return;
      }

      if (connection == ConnectivityResult.none) connectionLost();
    });
  }

  void connectionEstablishedOnWifi() => emit(ConnectionEstablishedOnWifi());
  void connectionEstablishedOnData() =>
      emit(ConnectionEstablishedOnMobileData());
  void connectionLost() => emit(ConnectionLost());
}
