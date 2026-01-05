import 'package:bctpay/globals/index.dart';

class Biller {
  final GlobalKey<State<StatefulWidget>>? key;
  final String route;
  final String name;
  final String image;

  Biller(
      {required this.key,
      required this.route,
      required this.name,
      required this.image});
}
