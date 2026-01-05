import 'dart:io';

import 'package:bctpay/globals/index.dart';

class SubscriptionDetail extends StatelessWidget {
  final Subscriber? subscriber;
  final bool isScanToPay;

  const SubscriptionDetail(
      {super.key, this.subscriber, this.isScanToPay = false});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SubscriptionDetail;
    Subscriber? subscriber = args.subscriber;
    KYCStatus? kycStatus;
    kycBloc.add(GetKYCDetailEvent());
    final subscriptionBloc = ApisBloc(ApisBlocInitialState());
    subscriptionBloc.add(GetSubscriptionByIdEvent(id: subscriber?.id ?? ""));
    final calculateAmountBloc = SelectionBloc(SelectStringState(""));
    ScreenshotController screenshotController = ScreenshotController();

    return BlocListener(
      bloc: kycBloc,
      listener: (context, state) {
        if (state is GetKYCDetailState) {
          var res = state.value;
          kycStatus = res.data?.kycStatus;
          if (res.code == 200) {
          } else if (res.code == HTTPResponseStatusCodes.sessionExpireCode) {
            sessionExpired(res.message ?? res.error ?? "", context);
          } else {
            showFailedDialog(res.message ?? res.error ?? "", context);
          }
        }
      },
      child: BlocConsumer(
          bloc: subscriptionBloc,
          listener: (context, state) {
            if (state is ApisBlocInitialState) {
              subscriptionBloc.add(GetSubscriptionByIdEvent(
                  id: subscriber?.subscriberUserAccId ?? ""));
            }
            if (state is GetSubscriptionByIdState) {
              var code = state.value.code;
              if (code == 200) {
                subscriber = Subscriber.fromJson(state.value.data);
              } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showToast(state.value.message ?? state.value.error ?? "");
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
                appBar: CustomAppBar(
                  title: subscriber?.planName ?? "",
                  actions: [
                    if (subscriber?.transactionData?.isNotEmpty ?? false)
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            builder: (context) => ListView.builder(
                                itemCount: subscriber?.transactionData?.length,
                                itemBuilder: (context, index) {
                                  var transactionData = subscriber!
                                      .transactionData![index]
                                      .copyWith(
                                          subscriptionDetails: subscriber);
                                  return TransactionListItem(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.transactionHistoryDetail,
                                          arguments: TransactionHistoryDetail(
                                            transaction: transactionData,
                                          ),
                                        );
                                      },
                                      transaction: transactionData);
                                }),
                          );
                        },
                        icon: Image.asset(
                          Assets.assetsImagesHistory,
                          scale: 4,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
                bottomNavigationBar: isAllPlansPaid(subscriber)
                    ? null
                    : BlocBuilder(
                        bloc: calculateAmountBloc,
                        builder: (context, state) {
                          var plans = getUpdatedAmountInPlans(subscriber
                              ?.planInfo
                              ?.where((e) => e.isSelected)
                              .toList());
                          var amount = getTotalSubscriptionAmount(plans);
                          if (amount.isEmpty || (double.parse(amount) <= 0)) {
                            return SizedBox.shrink();
                          } else {
                            return Container(
                              height: 80,
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(5, 5, 5,
                                  MediaQuery.of(context).viewInsets.bottom + 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (!isAllPlansPaid(subscriber))
                                    Text(
                                      formatCurrency(amount),
                                      style: textTheme(context)
                                          .headlineMedium!
                                          .copyWith(
                                              color: themeLogoColorOrange,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                isAllPlansPaid(subscriber)
                                                    ? Colors.green
                                                    : themeLogoColorOrange),
                                        onPressed: () {
                                          if (kycStatus != KYCStatus.approved) {
                                            showCustomDialog(
                                              appLocalizations(context)
                                                  .kycNotApprovedDialogMessage,
                                              context,
                                            );
                                          } else if (!isAllPlansPaid(
                                                  subscriber) &&
                                              (plans?.isNotEmpty ?? false)) {
                                            Navigator.pushNamed(context,
                                                AppRoutes.transactiondetail,
                                                arguments:
                                                    TransactionDetailScreen(
                                                  subscriptionData:
                                                      subscriber?.copyWith(
                                                          planInfo: plans),
                                                  isSubscriptionPay: true,
                                                  receiverType: "Merchant",
                                                  toAccount: BankAccount(
                                                      id: "",
                                                      accountRole: "",
                                                      beneficiaryname: subscriber
                                                              ?.merchantId
                                                              ?.businessCategoryName ??
                                                          "",
                                                      //TODO: businessCategoryName
                                                      accountnumber: subscriber
                                                              ?.merchantId
                                                              ?.phonenumber ??
                                                          "",
                                                      logo: subscriber
                                                              ?.merchantId
                                                              ?.companyLogo ??
                                                          "",
                                                      //TODO: companyLogo
                                                      merchantId: subscriber
                                                              ?.merchantId
                                                              ?.id ??
                                                          ""), //id
                                                ));
                                          } else {
                                            showToast(appLocalizations(context)
                                                .pleaseSelectAPlanWhichIsUnpaid);
                                          }
                                        },
                                        child: Text(
                                          getText(subscriber, context),
                                          style: textTheme(context)
                                              .labelLarge!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                body: ListView(
                  padding: const EdgeInsets.all(2),
                  children: [
                    20.height,
                    UserInfoView(
                      user: subscriber?.merchantId,
                    ),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "${appLocalizations(context).issuedOn}:",
                                style: textTheme(context)
                                    .bodySmall!
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                  subscriber?.createdAt?.formattedDate() ?? ""),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subscriber?.planInfo?.length,
                        itemBuilder: (context, index) {
                          return SubscriptionPlanView(
                            calculateAmountBloc: calculateAmountBloc,
                            plan: subscriber?.planInfo?[index],
                            subscriber: subscriber,
                          );
                        }),
                    10.height,
                    QRCodeViewWidget(
                      qrCodeString: subscriber?.paymentLink ?? "",
                      logo: (subscriber?.merchantId?.companyLogo?.isNotEmpty ??
                              false)
                          ? "$baseUrlProfileImage${subscriber?.merchantId?.companyLogo}"
                          : null,
                    ),
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton.icon(
                            onPressed: () {
                              screenshotController
                                  .captureFromWidget(
                                      buildSubscriptionQRScreenshot(
                                          context: context,
                                          subscriber: subscriber),
                                      context: context)
                                  .then((image) async {
                                DocumentFileSavePlus()
                                    .saveFile(
                                        image,
                                        "BCTPay_Subscription_QR_${DateTime.now()}.png",
                                        "appliation/png")
                                    .whenComplete(() {
                                  if (!context.mounted) return;
                                  showToast(
                                      appLocalizations(context).fileDownloaded);
                                });
                              });
                            },
                            icon: const Icon(
                              Icons.file_download_outlined,
                            ),
                            label: Text(
                              AppLocalizations.of(context)!.download,
                            )),
                        OutlinedButton.icon(
                            onPressed: () {
                              screenshotController
                                  .captureFromWidget(
                                      buildSubscriptionQRScreenshot(
                                          context: context,
                                          subscriber: subscriber),
                                      context: context)
                                  .then((image) async {
                                final directory =
                                    await getApplicationDocumentsDirectory();
                                final pathOfImage = await File(
                                        '${directory.path}/BCTPay_Subscription_QR_${DateTime.now()}.png')
                                    .create();
                                await pathOfImage
                                    .writeAsBytes(image.toList())
                                    .then((value) => SharePlus.instance.share(
                                        ShareParams(
                                            files: [XFile(value.path)])));
                              });
                            },
                            icon: const Icon(
                              Icons.share,
                            ),
                            label: Text(
                              AppLocalizations.of(context)!.share,
                            )),
                      ],
                    ),
                    10.height,
                  ],
                ));
          }),
    );
  }

  List<PlanInfo>? getUpdatedAmountInPlans(List<PlanInfo>? planInfo) {
    List<PlanInfo>? plans = [];
    if (planInfo != null) {
      for (var plan in planInfo) {
        var newPlan = plan.copyWith(totalPayableAmount: plan.payingAmount);
        plans.add(newPlan);
      }
    }
    return plans;
  }

  bool isAllPlanExpired(Subscriber? subscriber, {bool isRecurring = false}) {
    var plans = subscriber?.planInfo ?? [];

    return plans.map((e) => e.endDate?.isExpired()).contains(true);
  }

  bool isRecurring(Subscriber? subscriber) =>
      subscriber?.subscriptionType?.toLowerCase() == "recurring";

  bool isAllPlansPaid(Subscriber? subscriber) {
    var plans = subscriber?.planInfo ?? [];
    if (plans.isEmpty) {
      return true; // Or false, depending on your logic for empty lists.
    }

    for (PlanInfo plan in plans) {
      if (!(plan.paymentStatus?.toLowerCase() == 'paid') ||
          (plan.endDate?.isExpired() ?? false)) {
        return false; // Found a plan that's not paid or expired.
      } else {}
    }

    return true; // All plans are paid and not expired.
  }

  String getText(Subscriber? subscriber, BuildContext context) {
    if (isAllPlansPaid(subscriber)) {
      return appLocalizations(context).paid;
    } else if (isAllPlanExpired(subscriber)) {
      return isRecurring(subscriber)
          ? appLocalizations(context).reNew
          : appLocalizations(context).pay;
    } else {
      return appLocalizations(context).pay;
    }
  }
}

String getTotalSubscriptionAmount(List<PlanInfo>? planInfo) {
  double amount = 0;
  if (planInfo != null) {
    for (var plan in planInfo) {
      if (plan.endDate?.isExpired() ?? false) {
        amount += getTotalPayableAmount(plan);
      } else {
        amount += (double.tryParse(plan.totalPayableAmount ?? "0") ?? 0.0);
      }
    }
  }
  return amount.toStringAsFixed(2);
}

double getTotalPayableAmount(PlanInfo plan) {
  var planPrice = double.parse(plan.planPrice ?? '0');
  final dueDays = plan.endDate?.difference(DateTime.now());
  final overdueDays = dueDays?.inDays ?? 0;
  var lateFee = double.parse(plan.lateFeeAmount ?? '0') * overdueDays;
  var discount = double.parse(plan.discountValue ?? '0');
  return planPrice + lateFee - discount;
}
