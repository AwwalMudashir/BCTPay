import 'package:bctpay/globals/index.dart';

class OperatorListItem extends StatelessWidget {
  final ProviderListItem item;
  final void Function()? onTap;

  const OperatorListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: shadowDecoration.copyWith(),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: item.logoUrl ?? "",
              height: 50,
              width: 50,
              progressIndicatorBuilder: progressIndicatorBuilder,
              errorWidget: (context, error, stackTrace) => const Icon(
                Icons.photo,
                size: 50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
