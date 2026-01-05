import 'package:bctpay/bloc/connectivity_bloc/connectivity_state.dart';

abstract class NetworkEvent {}

class CheckConnection extends NetworkEvent {}

class ConnectionChanged extends NetworkEvent {
  NetworkState connection;
  ConnectionChanged(this.connection);
}
