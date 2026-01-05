import 'package:bctpay/globals/index.dart';

class RechargeListItem extends StatelessWidget {
  final Bill recharge;
  final void Function()? onTap;

  const RechargeListItem({
    super.key,
    required this.recharge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: shadowDecoration.copyWith(),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
                height: 50,
                width: 50,
                decoration: shadowDecoration,
                child: Image.network(
                  recharge.payerTransactionlogo ?? "",
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.photo,
                    size: 50,
                    color: Colors.black45,
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recharge.payerName ?? appLocalizations(context).unknown,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge,
                ),
                Text(
                  recharge.payerAccount ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(color: themeGreyColor),
                ),
                Text(
                  "Recharged ${recharge.payerCurrencySymbol} ${recharge.payerAmount} on ${recharge.createdAt?.formatRelativeDateTime(context) ?? ""}",
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall
                      ?.copyWith(color: const Color(0xffAEA9BC)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
