import 'package:bctpay/lib.dart';

class FilterQueriesBtn extends StatelessWidget {
  final SelectionBloc? selectQueryTypesBloc;
  final SelectionBloc? selectPaymentTypeBloc;
  final SelectionBloc? selectPaymentBloc;
  final SelectionBloc? selectDateRangeBloc;
  final QueryFilterModel? filter;

  const FilterQueriesBtn({
    super.key,
    required this.selectQueryTypesBloc,
    required this.selectPaymentTypeBloc,
    required this.selectPaymentBloc,
    required this.selectDateRangeBloc,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.filterQueriesScreen,
              arguments: FilterQueriesScreen(
                selectQueryTypesBloc: selectQueryTypesBloc,
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
    return (filter?.queryTypes?.isNotEmpty ?? false) ||
        (filter?.date?.start != null && filter?.date?.end != null);
  }
}
