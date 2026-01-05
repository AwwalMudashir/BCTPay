import 'package:bctpay/globals/index.dart';

abstract class PermissionState extends Equatable {}

class PermissionBlocInitialState extends PermissionState {
  @override
  List<Object?> get props => [];
}

class PermissionBlocLoadingState extends PermissionState {
  @override
  List<Object?> get props => [];
}

class PermissionRequestState extends PermissionState {
  final PermissionStatus value;
  PermissionRequestState(this.value);

  @override
  List<Object?> get props => [];
}
