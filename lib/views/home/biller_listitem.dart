import 'package:bctpay/globals/index.dart';

class BillerListItem extends StatelessWidget {
  final Biller biller;

  const BillerListItem({super.key, required this.biller});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        if (biller.name == appLocalizations(context).data ||
            biller.name == appLocalizations(context).giftCard) {
          showToast(
              appLocalizations(context).thisFuctionalityWillAvailableSoon);
          return;
        }
        Navigator.pushNamed(context, biller.route);
      },
      child: Container(
        key: biller.key,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: shadowDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/${biller.image}.png",
              height: width / 3 - 90,
              width: width / 3 - 90,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              biller.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
