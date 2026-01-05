import 'package:bctpay/lib.dart';

class FilterSubscriptionBtn extends StatelessWidget {
  final SelectionBloc? selectPaymentStatusBloc;
  final SelectionBloc? selectSubscriptionTypeBloc;
  final SelectionBloc? selectPaymentBloc;
  final SelectionBloc? selectDateRangeBloc;
  final SubscriptionFilterModel? filter;

  const FilterSubscriptionBtn({
    super.key,
    required this.selectPaymentStatusBloc,
    required this.selectSubscriptionTypeBloc,
    required this.selectPaymentBloc,
    required this.selectDateRangeBloc,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.filterSubscriptionScreen,
              arguments: FilterSubscriptionScreen(
                selectPaymentStatusBloc: selectPaymentStatusBloc,
                selectSubscriptionTypeBloc: selectSubscriptionTypeBloc,
                selectPaymentBloc: selectPaymentBloc,
                selectDateRangeBloc: selectDateRangeBloc,
                filter: filter,
              ));
        },
        icon: Icon(
          Icons.filter_list,
          color: isFilterApplied() ? Colors.blue : Colors.grey,
        ));
  }

  bool isFilterApplied() {
    return (filter?.paymentStatus?.isNotEmpty ?? false) ||
        (filter?.subscriptionType?.isNotEmpty ?? false) ||
        (filter?.date?.start != null && filter?.date?.end != null);
  }
}
