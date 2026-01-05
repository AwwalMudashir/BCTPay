import 'package:bctpay/lib.dart';

class FilterTxnBtn extends StatelessWidget {
  final SelectionBloc? selectPaymentStatusBloc;
  final List<String>? paymentStatusList;
  final SelectionBloc? selectPaymentTypeBloc;
  final List<String>? paymentTypeList;
  final SelectionBloc? selectPaymentBloc;
  final List<String>? paymentList;
  final DateTimeRange? dateTimeRange;
  final SelectionBloc? selectDateRangeBloc;

  const FilterTxnBtn(
      {super.key,
      required this.selectPaymentStatusBloc,
      required this.paymentStatusList,
      required this.selectPaymentTypeBloc,
      required this.paymentTypeList,
      required this.selectPaymentBloc,
      required this.paymentList,
      required this.dateTimeRange,
      required this.selectDateRangeBloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.filterTxnScreen,
              arguments: FilterTxnScreen(
                selectPaymentStatusBloc: selectPaymentStatusBloc,
                paymentStatusList: paymentStatusList,
                selectPaymentTypeBloc: selectPaymentTypeBloc,
                paymentTypeList: paymentTypeList,
                selectPaymentBloc: selectPaymentBloc,
                paymentList: paymentList,
                selectDateRangeBloc: selectDateRangeBloc,
                dateTimeRange: dateTimeRange,
              ));
        },
        icon: Icon(
          Icons.filter_list,
          color: isFilterApplied() ? Colors.blue : Colors.grey,
        ));
  }

  bool isFilterApplied() {
    return (paymentStatusList?.isNotEmpty ?? false) ||
        (paymentTypeList?.isNotEmpty ?? false) ||
        dateTimeRange != null;
  }
}
