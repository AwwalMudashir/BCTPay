import 'package:bctpay/globals/index.dart';

class CouponCodeListItem extends StatelessWidget {
  final Coupon coupon;

  const CouponCodeListItem({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.couponDetail,
            arguments: CouponDetailView(
              coupon: coupon,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(5.0),
        decoration: shadowDecoration,
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: baseUrlBanner + coupon.coupenImage,
                fit: BoxFit.cover,
                height: 80,
                width: 180,
                progressIndicatorBuilder: progressIndicatorBuilder,
                errorWidget: (context, url, error) => const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.card_giftcard_rounded,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              coupon.coupenTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              coupon.termsAndCondition,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  textTheme(context).bodySmall?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
