import 'package:bctpay/lib.dart';

class FilterInvoiceScreen extends StatelessWidget {
  final SelectionBloc? selectPaymentStatusBloc;

  final SelectionBloc? selectPaymentTypeBloc;

  final SelectionBloc? selectPaymentBloc;

  final SelectionBloc? selectDateRangeBloc;
  final InvoiceFilterModel? filter;

  const FilterInvoiceScreen({
    super.key,
    this.selectPaymentStatusBloc,
    this.selectPaymentTypeBloc,
    this.selectPaymentBloc,
    this.selectDateRangeBloc,
    this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).filter),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          _filterByPaymentStatus(context),
          10.height,
          _filterByDate(context),
          10.height,
          Row(
            children: [
              Expanded(
                  child: CustomBtn(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: appLocalizations(context).applyInvoiceFilter)),
              5.width,
              Expanded(
                child: CustomBtn(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  text: appLocalizations(context).cancel,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _filterByPaymentStatus(BuildContext context) {
    var arg = args(context) as FilterInvoiceScreen;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: BlocBuilder(
          bloc: arg.selectPaymentStatusBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).paymentStatus,
                ),
                Wrap(
                  children: [
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentStatusBloc?.add(
                              SelectStringEvent("PAID", isSelected: value));
                        },
                        label: Text(appLocalizations(context).paid),
                        selected: arg.filter?.paymentStatus?.contains("PAID") ??
                            false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentStatusBloc?.add(
                              SelectStringEvent("UNPAID", isSelected: value));
                        },
                        label: Text(appLocalizations(context).unpaid),
                        selected:
                            arg.filter?.paymentStatus?.contains("UNPAID") ??
                                false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentStatusBloc?.add(
                              SelectStringEvent("EXPIRED", isSelected: value));
                        },
                        label: Text(appLocalizations(context).expired),
                        selected:
                            arg.filter?.paymentStatus?.contains("EXPIRED") ??
                                false),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Container _filterByDate(BuildContext context) {
    var arg = args(context) as FilterInvoiceScreen;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations(context).dueDate,
          ),
          TextButton(
              onPressed: () {
                showDateRangePicker(
                        context: context,
                        initialDateRange: (arg.filter?.date?.start == null &&
                                arg.filter?.date?.end == null)
                            ? null
                            : DateTimeRange(
                                start: arg.filter!.date!.start!,
                                end: arg.filter!.date!.end!,
                              ),
                        firstDate: DateTime(2025),
                        lastDate: DateTime.now())
                    .then((selectedDate) {
                  if (selectedDate != null) {
                    arg.selectDateRangeBloc
                        ?.add(SelectDateRangeEvent(selectedDate));
                  }
                });
              },
              child: Column(
                children: [
                  BlocConsumer(
                      bloc: arg.selectDateRangeBloc,
                      listener: (context, state) {
                        if (state is SelectDateRangeState) {}
                      },
                      builder: (context, state) {
                        if (state is SelectDateRangeState &&
                            state.value != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${state.value?.start.formatValidityDateTime()} - ${state.value?.end.formatValidityDateTime()}"),
                              IconButton(
                                onPressed: () {
                                  arg.selectDateRangeBloc
                                      ?.add(SelectDateRangeEvent(null));
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          );
                        }
                        return Text(appLocalizations(context).selectDate);
                      }),
                ],
              ))
        ],
      ),
    );
  }
}
