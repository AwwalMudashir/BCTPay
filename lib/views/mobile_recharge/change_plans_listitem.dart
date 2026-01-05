import 'package:bctpay/globals/index.dart';

class ChangePlanListItem extends StatelessWidget {
  final Plan plan;

  const ChangePlanListItem({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: shadowDecoration.copyWith(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatCurrency(plan.minimum.sendValue.toStringAsFixed(2)),
                  style: textTheme.headlineLarge!.copyWith(
                    color: themeLogoColorOrange,
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Change Plan"))
              ],
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
                      style:
                          textTheme.bodyMedium?.copyWith(color: Colors.black)),
                  Text(
                    plan.defaultDisplayText,
                    style: textTheme.bodyMedium?.copyWith(
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

ISODuration isoDurationConverter(String durationToConvert) {
  final ISODurationConverter converter = ISODurationConverter();
  final ISODuration duration =
      converter.parseString(isoDurationString: durationToConvert);
  return duration;
}
