import 'package:bctpay/lib.dart';

class FilterInvoiceBtn extends StatelessWidget {
  final SelectionBloc? selectPaymentStatusBloc;
  final SelectionBloc? selectPaymentTypeBloc;

  final SelectionBloc? selectPaymentBloc;

  final SelectionBloc? selectDateRangeBloc;
  final InvoiceFilterModel? filter;

  const FilterInvoiceBtn({
    super.key,
    required this.selectPaymentStatusBloc,
    required this.selectPaymentTypeBloc,
    required this.selectPaymentBloc,
    required this.selectDateRangeBloc,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.filterInvoiceScreen,
              arguments: FilterInvoiceScreen(
                selectPaymentStatusBloc: selectPaymentStatusBloc,
                selectPaymentTypeBloc: selectPaymentTypeBloc,
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
        (filter?.date?.start != null && filter?.date?.end != null);
  }
}
