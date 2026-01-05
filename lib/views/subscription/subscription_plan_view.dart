import 'package:bctpay/lib.dart';
import 'package:readmore/readmore.dart';

enum PaymentType { full, partial }

class SubscriptionPlanView extends StatelessWidget {
  final PlanInfo? plan;
  final Subscriber? subscriber;
  final SelectionBloc? calculateAmountBloc;
  final void Function()? onTap;
  final bool isTxnDetail;

  const SubscriptionPlanView(
      {super.key,
      required this.plan,
      required this.subscriber,
      this.onTap,
      required this.calculateAmountBloc,
      this.isTxnDetail = false});

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final selectPlanBloc =
        SelectionBloc(SelectBoolState(plan?.isSelected ?? false));
    var selectPaymentTypeBloc =
        SelectionBloc(SelectPaymentTypeState(PaymentType.full));

    return InkWell(
      onTap: () {
        if (isAbleToPay()) {
          plan?.isSelected = !(plan?.isSelected ?? false);
          selectPlanBloc.add(SelectBoolEvent(plan?.isSelected ?? false));
          calculateAmountBloc
              ?.add(SelectStringEvent(DateTime.now().toString()));
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Card(
            elevation: 10,
            color: isDarkMode(context) ? themeColorHeader : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  15.height,
                  Row(
                    children: [
                      if (isAbleToPay())
                        BlocBuilder(
                            bloc: selectPlanBloc,
                            builder: (context, state) {
                              return Checkbox(
                                visualDensity: VisualDensity.compact,
                                value: plan?.isSelected ?? false,
                                onChanged: (value) {
                                  if (isAbleToPay()) {
                                    plan?.isSelected = value ?? false;
                                    selectPlanBloc.add(SelectBoolEvent(
                                        plan?.isSelected ?? false));
                                    calculateAmountBloc?.add(SelectStringEvent(
                                        DateTime.now().toString()));
                                  }
                                },
                              );
                            }),
                      Expanded(
                          child: Text(
                        plan?.plansDurations ?? "",
                        style: textTheme(context)
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  10.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!isTxnDetail)
                        AmountSectionView(
                            title: appLocalizations(context).payable,
                            amount: formatCurrency(getPayableAmount())),
                      if (!isRecurringSubscription(subscriber))
                        AmountSectionView(
                            title: appLocalizations(context).paid,
                            amount: formatCurrency(plan?.paidAmount ?? "0")),
                      if (!isTxnDetail && !isRecurringSubscription(subscriber))
                        AmountSectionView(
                            title: appLocalizations(context).due,
                            amount:
                                formatCurrency(plan?.totalPayableAmount ?? "0"))
                    ],
                  ),
                  10.height,
                  if ((plan?.discountValue?.isNotEmpty ?? false) &&
                      double.parse(plan?.discountValue ?? "0") > 0)
                    _customRow(
                        "${appLocalizations(context).discount} : ",
                        getDiscount(plan?.discountType, plan?.discountValue),
                        context),
                  if ((plan?.lateFeeValue?.isNotEmpty ?? false) &&
                      double.parse(plan?.lateFeeValue ?? "0") > 0)
                    _customRow(
                        "${appLocalizations(context).lateFee} : ",
                        "${formatCurrency(plan?.lateFeeValue ?? "")}/${appLocalizations(context).day}",
                        context),
                  if ((plan?.planDays?.isNotEmpty ?? false) &&
                      double.parse(plan?.planDays ?? "0") > 0)
                    _customRow(
                        "${appLocalizations(context).validity} : ",
                        "${plan?.planDays ?? "0"} ${appLocalizations(context).days}",
                        context),
                  if (!isTxnDetail)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations(context).paymentStatus,
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        PaymentStatusView(
                          paymentStatus: plan?.paymentStatus,
                        ),
                      ],
                    ),
                  1.height,
                  if (!isTxnDetail && (plan?.endDate?.isExpired() ?? false))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations(context).status,
                          style: textTheme(context)
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        ExpiredStatusView(
                          status: (plan?.endDate?.isExpired() ?? false),
                        ),
                      ],
                    ),
                  if (plan?.allowedPaymentType == "PARTIALLY" && isAbleToPay())
                    Row(
                      children: [
                        Text(appLocalizations(context).paymentType),
                        Expanded(
                          child: BlocBuilder(
                              bloc: selectPaymentTypeBloc,
                              builder: (context, state) {
                                if (state is SelectPaymentTypeState) {
                                  return Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.white),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: RadioListTile<PaymentType>(
                                            contentPadding: EdgeInsets.zero,
                                            visualDensity:
                                                VisualDensity.compact,
                                            fillColor: WidgetStatePropertyAll(
                                              isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            title: Text(
                                              appLocalizations(context).full,
                                              style: textTheme(context)
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            value: PaymentType.full,
                                            groupValue: state.value,
                                            onChanged: (value) {
                                              selectPaymentTypeBloc.add(
                                                  SelectPaymentTypeEvent(
                                                      value!));
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: RadioListTile<PaymentType>(
                                            contentPadding: EdgeInsets.zero,
                                            visualDensity:
                                                VisualDensity.compact,
                                            fillColor: WidgetStatePropertyAll(
                                              isDarkMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            title: Text(
                                              appLocalizations(context)
                                                  .partial,
                                              style: textTheme(context)
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            value: PaymentType.partial,
                                            groupValue: state.value,
                                            onChanged: (value) {
                                              selectPaymentTypeBloc.add(
                                                  SelectPaymentTypeEvent(
                                                      value!));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const Loader();
                              }),
                        ),
                      ],
                    ),
                  ((plan?.paymentStatus == "PAID" || isTxnDetail) &&
                          !isExpired())
                      ? SizedBox.shrink()
                      : BlocBuilder(
                          bloc: selectPaymentTypeBloc,
                          builder: (context, state) {
                            if (state is SelectPaymentTypeState) {
                              if (state.value == PaymentType.full) {
                                amountController.text =
                                    currencyTextInputFormatter.formatDouble(
                                        double.parse(isExpired()
                                            ? calculateTotalPayableAmount()
                                            : plan?.totalPayableAmount ?? ""));
                                _updateAmount(amountController.text, formKey);
                                return Text(
                                  formatCurrency((double.parse(
                                              plan?.totalPayableAmount ?? "0") >
                                          0)
                                      ? (plan?.totalPayableAmount ?? "0")
                                      : plan?.paidAmount ?? "0"),
                                  style: textTheme(context)
                                      .headlineMedium
                                      ?.copyWith(
                                          color: themeLogoColorOrange,
                                          fontWeight: FontWeight.bold),
                                );
                              } else {
                                _updateAmount(amountController.text, formKey);
                                if (plan?.allowedPaymentType == "PARTIALLY" &&
                                    plan?.paymentStatus != "PAID") {
                                  return Form(
                                    key: formKey,
                                    child: CustomTextField(
                                      readOnly:
                                          (plan?.allowedPaymentType == "FULL")
                                              ? true
                                              : false,
                                      autofocus: true,
                                      inputFormatters: [
                                        currencyTextInputFormatter,
                                      ],
                                      controller: amountController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChanged: (value) {
                                        _updateAmount(value, formKey);
                                      },
                                      labelText:
                                          "${appLocalizations(context).howMuchYouWantToSendSubscription} *",
                                      hintText: "0",
                                      suffixText:
                                          selectedCountry?.currencySymbol,
                                      textAlign: TextAlign.center,
                                      style: textTheme(context)
                                          .titleLarge!
                                          .copyWith(
                                              fontSize: 25,
                                              color: Colors.black,
                                              height: 1,
                                              fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                      validator: (value) {
                                        final amount =
                                            currencyTextInputFormatter
                                                .getUnformattedValue();
                                        if (value!.isEmpty) {
                                          return appLocalizations(context)
                                              .pleaseEnterValidAmount;
                                        } else if (amount <= 0) {
                                          return appLocalizations(context)
                                              .amountShouldBeGreaterThanZeroSubscription;
                                        } else if (amount >
                                            (double.tryParse(
                                                    plan?.totalPayableAmount ??
                                                        "0") ??
                                                0)) {
                                          return "${appLocalizations(context).amountShouldNotBeGreaterThan} ${formatCurrency(plan?.totalPayableAmount ?? "")}";
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                }
                              }
                            }
                            return Loader();
                          }),
                  if (!isTxnDetail) 20.height,
                  if ((plan?.planDesc?.isNotEmpty ?? false) && !isTxnDetail)
                    ReadMoreText(
                      plan?.planDesc ?? "",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: themeGreyColor,
                      trimCollapsedText: appLocalizations(context).showMore,
                      trimExpandedText: appLocalizations(context).showLess,
                    ),
                ],
              ),
            ),
          ),
          if (plan?.dueDate != null || plan?.endDate != null)
            Positioned(
              right: 5,
              top: 5,
              child: RotationTransition(
                  turns: AlwaysStoppedAnimation(0 / 360),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isStillDue() ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      plan?.dueDate != null
                          ? "${appLocalizations(context).dueDate} : ${plan?.dueDate?.formattedDate() ?? ""}"
                          : "${appLocalizations(context).expiryDate} : ${plan?.endDate?.formattedDate() ?? ""}",
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
        ],
      ),
    );
  }

  void _updateAmount(String p1, GlobalKey<FormState> formKey) {
    var amount =
        currencyTextInputFormatter.getUnformattedValue().toStringAsFixed(2);
    if (formKey.currentState?.validate() ?? false) {
      plan?.payingAmount = amount;
      calculateAmountBloc?.add(SelectStringEvent(DateTime.now().toString()));
    } else {}
  }

  Row _customRow(String key, String value, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
          ),
          Text(value),
        ],
      );

  String getDiscount(String? type, String? value) {
    if (type?.toLowerCase() == "percentage") {
      return "${value ?? 0} %";
    } else if (type?.toLowerCase() == "fixed") {
      return formatCurrency(value ?? "0");
    } else {
      return "0 %";
    }
  }

  String getPayableAmount() {
    return plan?.planPrice ?? "0.00";
  }

  bool isStillDue() {
    if (plan?.dueDate != null) {
      return (plan?.dueDate?.isBefore(DateTime.now().toLocal()) ?? false) &&
          plan?.paymentStatus?.toLowerCase() != "paid";
    } else {
      return isExpired();
    }
  }

  bool isExpired() =>
      (plan?.endDate?.isBefore(DateTime.now().toLocal()) ?? false);

  bool isAbleToPay() =>
      plan?.paymentStatus != "PAID" && !isTxnDetail || isExpired();

  String calculateTotalPayableAmount() {
    return plan?.planPrice ?? "0";
  }

  bool isRecurringSubscription(Subscriber? subscriber) =>
      subscriber?.subscriptionType?.toLowerCase() == 'recurring';
}

class AmountSectionView extends StatelessWidget {
  const AmountSectionView({
    super.key,
    required this.title,
    required this.amount,
  });

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: themeLogoColorOrange,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              amount,
              textAlign: TextAlign.center,
              style: textTheme(context).bodySmall?.copyWith(
                  color: themeLogoColorOrange, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
