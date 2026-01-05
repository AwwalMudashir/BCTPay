import 'package:bctpay/globals/index.dart';

class Service {
  final GlobalKey<State<StatefulWidget>>? key;
  final String route;
  final String name;
  final String image;

  Service({
    this.key,
    required this.route,
    required this.name,
    required this.image,
  });
}
