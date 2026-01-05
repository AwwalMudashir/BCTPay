import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class RequestToPayDetail extends StatefulWidget {
  final BankAccount? receivableAccount;
  final Contact? requestToContact;

  const RequestToPayDetail({
    super.key,
    this.requestToContact,
    this.receivableAccount,
  });

  @override
  State<RequestToPayDetail> createState() => _RequestToPayDetailState();
}

class _RequestToPayDetailState extends State<RequestToPayDetail> {
  var amountController = TextEditingController();
  double amount = 0.0;
  var noteController = TextEditingController();
  var requestPaymentBloc = ApisBloc(ApisBlocInitialState());

  var formKey = GlobalKey<FormState>();
  var selectPhoneCountryBloc = SelectionBloc(SelectCountryState(
      Country.parse(selectedCountry?.countryName ?? "GN"), selectedCountry!));

  String? phoneCode;

  Future<void> getPhoneCodeAndCountry() async {
    var args = ModalRoute.of(context)!.settings.arguments as RequestToPayDetail;
    var country = await seperatePhoneAndDialCode(
        args.requestToContact!.phones.first.number,
        selectPhoneCountryBloc: selectPhoneCountryBloc);
    phoneCode = country?.phoneCode;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      getPhoneCodeAndCountry();
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var args = ModalRoute.of(context)!.settings.arguments as RequestToPayDetail;
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).requestPayment),
      body: BlocConsumer(
          bloc: requestPaymentBloc,
          listener: (context, state) {
            if (state is RequestToPayState) {
              if (state.value.code ==
                  HTTPResponseStatusCodes.momoTxnSuccessCode) {
                showSuccessDialog(
                  appLocalizations(context).amountRequestedSuccessfully,
                  context,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  onOkBtnPressed: () {
                    Navigator.popUntil(context,
                        (route) => route.settings.name == AppRoutes.bottombar);
                  },
                );
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showFailedDialog(state.value.message, context);
              }
            }
            if (state is ApisBlocErrorState) {
              showFailedDialog(state.message, context);
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          appLocalizations(context).requestingFrom,
                          style: textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ContactListItem(contact: args.requestToContact!),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          appLocalizations(context).receivableAccount,
                          style: textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BeneficiaryListItem(
                        beneficiary: args.receivableAccount!,
                        showPoupMenuBtn: false,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: width * 0.95,
                        child: CustomTextField(
                          autofocus: true,
                          inputFormatters: [
                            currencyTextInputFormatter,
                          ],
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (p0) {
                            try {
                              amount = currencyTextInputFormatter
                                  .getUnformattedValue()
                                  .toDouble();
                            } catch (e) {
                              showFailedDialog(
                                  e is FormatException
                                      ? e.message
                                      : e.toString(),
                                  context);
                              amountController.clear();
                              amount = 0;
                            }
                            setState(() {});
                          },
                          labelText: "${appLocalizations(context).amount} *",
                          hintText: "0",
                          suffixText: selectedCountry?.currencySymbol,
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge!.copyWith(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return appLocalizations(context)
                                  .pleaseEnterValidAmount;
                            }
                            return null;
                          },
                        ),
                      ),
                      CustomTextField(
                        controller: noteController,
                        maxLines: 3,
                        height: 80,
                        labelText:
                            appLocalizations(context).paymentNoteRequestToPay,
                        hintText: appLocalizations(context)
                            .enterPaymentNoteRequestToPay,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomBtn(
                            text: appLocalizations(context).request,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                requestPaymentBloc.add(RequestToPayEvent(
                                    amount: amount.toStringAsFixed(2),
                                    receiverAccountId:
                                        args.receivableAccount!.id,
                                    txnNote: noteController.text,
                                    requestReceiverPhoneCode:
                                        "+${phoneCode ?? selectedCountry!.phoneCode!}",
                                    requestReceiverPhoneNumber: phoneCode ==
                                            null
                                        ? args.requestToContact!.phones.first
                                            .number
                                            .replaceAll(" ", "")
                                        : args.requestToContact!.phones.first
                                            .number
                                            .replaceAll(" ", "")
                                            .substring(
                                              (phoneCode?.length ?? 0) + 1,
                                            )));
                              }
                            },
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomBtn(
                              text: appLocalizations(context).cancel,
                              color: Colors.red,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
