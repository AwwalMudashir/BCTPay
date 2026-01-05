import 'package:bctpay/globals/index.dart';

class RouteArguments {
  final bool showAppbar;
  final bool isRequestToPay;
  // final BankAccount? requestToAccount;
  final Contact? requestToContact;
  RouteArguments({
    this.showAppbar = false,
    this.isRequestToPay = false,
    // this.requestToAccount,
    this.requestToContact,
  });
}
