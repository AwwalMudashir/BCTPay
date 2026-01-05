import 'package:bctpay/lib.dart';

class FilterTxnScreen extends StatelessWidget {
  final SelectionBloc? selectPaymentStatusBloc;
  final List<String>? paymentStatusList;
  final SelectionBloc? selectPaymentTypeBloc;
  final List<String>? paymentTypeList;
  final SelectionBloc? selectPaymentBloc;
  final List<String>? paymentList;
  final DateTimeRange? dateTimeRange;
  final SelectionBloc? selectDateRangeBloc;

  const FilterTxnScreen(
      {super.key,
      this.selectPaymentStatusBloc,
      this.paymentStatusList,
      this.selectPaymentTypeBloc,
      this.paymentTypeList,
      this.selectPaymentBloc,
      this.paymentList,
      this.dateTimeRange,
      this.selectDateRangeBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).filter),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          _filterByPaymentStatus(context),
          10.height,
          _filterByPaymentTypes(context),
          10.height,
          _filterByPayments(context),
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
                      text: appLocalizations(context).applyTxnFilter)),
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
    var arg = args(context) as FilterTxnScreen;
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
                          arg.selectPaymentStatusBloc?.add(SelectStringEvent(
                              "SUCCESSFUL",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).txnStatusSuccess),
                        selected:
                            arg.paymentStatusList?.contains("SUCCESSFUL") ??
                                false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentStatusBloc?.add(
                              SelectStringEvent("FAILED", isSelected: value));
                        },
                        label: Text(appLocalizations(context).failed),
                        selected:
                            arg.paymentStatusList?.contains("FAILED") ?? false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentStatusBloc?.add(
                              SelectStringEvent("PENDING", isSelected: value));
                        },
                        label: Text(appLocalizations(context).pending),
                        selected: arg.paymentStatusList?.contains("PENDING") ??
                            false),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Container _filterByPaymentTypes(BuildContext context) {
    var arg = args(context) as FilterTxnScreen;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: BlocBuilder(
          bloc: arg.selectPaymentTypeBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).paymentType,
                ),
                Wrap(
                  children: [
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentTypeBloc?.add(SelectStringEvent(
                              "SUBSCRIPTION PAYMENT",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).subscription),
                        selected: arg.paymentTypeList
                                ?.contains("SUBSCRIPTION PAYMENT") ??
                            false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentTypeBloc?.add(SelectStringEvent(
                              "INVOICE PAYMENT",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).bill),
                        selected:
                            arg.paymentTypeList?.contains("INVOICE PAYMENT") ??
                                false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentTypeBloc?.add(SelectStringEvent(
                              "TO CONTACT",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).contact),
                        selected: arg.paymentTypeList?.contains("TO CONTACT") ??
                            false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentTypeBloc?.add(SelectStringEvent(
                              "REQUEST TO PAY TRANSFER",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).requestToPay),
                        selected: arg.paymentTypeList
                                ?.contains("REQUEST TO PAY TRANSFER") ??
                            false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentTypeBloc?.add(SelectStringEvent(
                              "QR PAYMENT",
                              isSelected: value));
                        },
                        label: Text(appLocalizations(context).qrPayment),
                        selected: arg.paymentTypeList?.contains("QR PAYMENT") ??
                            false),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Container _filterByDate(BuildContext context) {
    var arg = args(context) as FilterTxnScreen;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations(context).paymentDate,
          ),
          TextButton(
              onPressed: () {
                showDateRangePicker(
                        context: context,
                        initialDateRange: dateTimeRange,
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

  Container _filterByPayments(BuildContext context) {
    var arg = args(context) as FilterTxnScreen;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: shadowDecoration.copyWith(
          color: isDarkMode(context) ? themeLogoColorBlue : Colors.white),
      child: BlocBuilder(
          bloc: arg.selectPaymentBloc,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations(context).payment,
                ),
                Wrap(
                  children: [
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentBloc?.add(
                              SelectStringEvent("RECEIVED", isSelected: value));
                        },
                        label: Text(appLocalizations(context).received),
                        selectedColor: themeLogoColorOrange,
                        selected:
                            arg.paymentList?.contains("RECEIVED") ?? false),
                    5.width,
                    ChoiceChip.elevated(
                        onSelected: (value) {
                          arg.selectPaymentBloc?.add(
                              SelectStringEvent("SENT", isSelected: value));
                        },
                        label: Text(appLocalizations(context).sent),
                        selectedColor: themeLogoColorOrange,
                        selected: arg.paymentList?.contains("SENT") ?? false),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
