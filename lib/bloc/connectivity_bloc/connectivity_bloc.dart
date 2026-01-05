import 'package:bctpay/globals/index.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  NetworkBloc() : super(ConnectionInitial()) {
    on<CheckConnection>(_listenConnection);
    on<ConnectionChanged>(_connectionChanged);
  }

  Future<void> _listenConnection(
      CheckConnection event, Emitter<NetworkState> emit) async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      emit(ConnectionFailure());
    } else {
      emit(ConnectionSuccess());
    }
    // });
  }

  FutureOr<void> _connectionChanged(
      ConnectionChanged event, Emitter<NetworkState> emit) {
    emit(ConnectionInitial());
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
