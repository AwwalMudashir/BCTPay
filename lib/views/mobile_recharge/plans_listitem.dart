import 'package:bctpay/globals/index.dart';

class PlanListItem extends StatelessWidget {
  final Plan plan;
  final Contact contact;

  const PlanListItem({
    super.key,
    required this.plan,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.mobileRechargePay,
            arguments: MobileRechargePayScreen(
              plan: plan,
              contact: contact,
            ));
      },
      child: Container(
        decoration: shadowDecoration.copyWith(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Text(
              formatCurrency(plan.minimum.sendValue.toString()),
              style: textTheme.bodyLarge?.copyWith(
                  color: themeLogoColorOrange, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: width - 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Validity: ${isoDurationConverter(plan.validityPeriodIso ?? "P0D").day.toString()} days",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                  Text(
                    plan.defaultDisplayText,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
