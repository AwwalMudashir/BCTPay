import 'package:bctpay/globals/index.dart';

abstract class SharedPrefState extends Equatable {
  const SharedPrefState();

  @override
  List<Object> get props => [];
}

/// UnInitialized
class SharedPrefInitialState extends SharedPrefState {
  const SharedPrefInitialState();

  @override
  String toString() => 'SharedPrefInitialState';
}

/// Initialized
class InSharedPrefState extends SharedPrefState {
  const InSharedPrefState(this.hello);

  final String hello;

  @override
  String toString() => 'InSharedPrefState $hello';

  @override
  List<Object> get props => [hello];
}

class ErrorSharedPrefState extends SharedPrefState {
  const ErrorSharedPrefState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorSharedPrefState';

  @override
  List<Object> get props => [errorMessage];
}

class SharedPrefGetUserDetailState extends SharedPrefState {
  const SharedPrefGetUserDetailState(this.user);
  final UserModel user;

  @override
  String toString() => 'InSharedPrefState $user';

  @override
  List<Object> get props => [user];
}
