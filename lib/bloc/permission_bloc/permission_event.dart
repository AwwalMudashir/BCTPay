import 'package:bctpay/globals/index.dart';

abstract class PermissionEvent extends Equatable {}

class PermissionRequestEvent extends PermissionEvent {
  final Permission permission;
  PermissionRequestEvent({required this.permission});
  @override
  List<Object?> get props => [permission];
}
