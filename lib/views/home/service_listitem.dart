import 'package:bctpay/globals/index.dart';

class ServicesListItem extends StatelessWidget {
  final Service service;
  final int index;

  const ServicesListItem({
    super.key,
    required this.service,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      key: service.key,
      onTap: () {
        Navigator.pushNamed(
          context,
          service.route,
          arguments: RouteArguments(
            showAppbar: true,
            isRequestToPay: service.route == AppRoutes.requestToPay,
          ),
        );
      },
      child: Container(
        decoration: shadowDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.height,
            Image.asset(
              "assets/images/${service.image}.png",
              height: 40,
              width: 40,
            ),
            10.height,
            SizedBox(
                width: double.infinity,
                child: Text(
                  service.name,
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 10),
                ))
          ],
        ),
      ),
    );
  }
}
