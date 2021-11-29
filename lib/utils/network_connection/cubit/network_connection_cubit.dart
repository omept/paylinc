import 'package:bloc/bloc.dart';

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:paylinc/constants/app_constants.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  NetworkConnectionCubit({required this.connectivity})
      : super(NetworkLoading()) {
    monitorNetworkConnection();
  }

  StreamSubscription<ConnectivityResult> monitorNetworkConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitNetworkConnected(NetworkConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitNetworkConnected(NetworkConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitNetworkDisconnected();
      }
    });
  }

  void emitNetworkConnected(NetworkConnectionType _connectionType) =>
      emit(NetworkConnected(connectionType: _connectionType));

  void emitNetworkDisconnected() => emit(NetworkDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
