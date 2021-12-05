part of 'network_connection_cubit.dart';

@immutable
abstract class NetworkConnectionState {}

class NetworkLoading extends NetworkConnectionState {}

class NetworkConnected extends NetworkConnectionState {
  final NetworkConnectionType connectionType;

  NetworkConnected({required this.connectionType});
}

class NetworkDisconnected extends NetworkConnectionState {}