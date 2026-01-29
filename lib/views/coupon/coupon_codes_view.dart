import 'package:bctpay/globals/index.dart';

class CouponCodeList extends StatelessWidget {
  final couponsListBloc = ApisBloc(ApisBlocInitialState())
    ..add(CouponListEvent());

  CouponCodeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: couponsListBloc,
        builder: (context, state) {
          if (state is CouponListState) {
            var coupon = state.value.data ?? [];
            if (coupon.isEmpty) {
              return const SizedBox();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(title: AppLocalizations.of(context)!.coupons),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: coupon.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CouponCodeListItem(
                      coupon: coupon[index],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Loader();
        });
  }
}
