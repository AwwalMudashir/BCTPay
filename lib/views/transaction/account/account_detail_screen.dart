import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class AccountDetail extends StatefulWidget {
  final BankAccount? account;

  const AccountDetail({super.key, this.account});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final setPrimaryBloc = SelectionBloc(SelectionBlocInitialState());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments as AccountDetail;
      var account = args.account;
      setPrimaryBloc.add(SelectStringEvent(account?.primaryaccount));
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as AccountDetail;
    var account = args.account;
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:
          CustomAppBar(title: appLocalizations(context).accountDetailDrawer),
      body: BlocConsumer(
          bloc: bankAccountListBloc,
          listener: (context, state) {
            if (state is SetPrimaryAccountState) {
              if (state.value.code == 200) {
                setPrimaryBloc.add(SelectStringEvent(
                    account?.primaryaccount == "YES" ? "NO" : "YES"));
              }
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: const Loader(),
              inAsyncCall: state is ApisBlocLoadingState,
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: account!.id,
                        child: SizedBox.square(
                          dimension: 120,
                          child: Card(
                              color: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          "$baseUrlBankLogo${account.logo}",
                                      progressIndicatorBuilder:
                                          progressIndicatorBuilder,
                                      errorWidget: (BuildContext c, String s,
                                              Object o) =>
                                          const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                            size: 70,
                                          )),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        account.beneficiaryname ??
                            appLocalizations(context).unknown,
                        style: textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedCountry!.countryCode,
                            style: textTheme.bodySmall?.copyWith(),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CountryFlag.fromCountryCode(
                            selectedCountry!.countryCode,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            account.accountRole == "BANK"
                                ? (account.accountnumber ?? "")
                                : ("${account.phoneCode ?? ""} ${account.accountnumber ?? ""}"),
                            style: textTheme.bodySmall?.copyWith(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer(
                          bloc: setPrimaryBloc,
                          listener: (context, state) {
                            if (state is SelectStringState) {}
                          },
                          builder: (context, state) {
                            if (state is SelectStringState) {
                              var primaryaccount = state.value;
                              return Row(
                                children: [
                                  if (primaryaccount != "YES" &&
                                      account.accountstatus == "1")
                                    InkWell(
                                      onTap: () {
                                        bankAccountListBloc.add(
                                            SetPrimaryAccountEvent(
                                                account: account));
                                      },
                                      child: Row(
                                        children: [
                                          Radio(
                                            groupValue: true,
                                            visualDensity:
                                                VisualDensity.compact,
                                            value: primaryaccount == "YES",
                                            onChanged: (value) {
                                              bankAccountListBloc.add(
                                                  SetPrimaryAccountEvent(
                                                      account: account));
                                            },
                                          ),
                                          Text(
                                            appLocalizations(context)
                                                .setPrimary,
                                            style:
                                                textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (primaryaccount == "YES")
                                    const PrimaryStatusView()
                                ],
                              );
                            }
                            return const Loader();
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      ActiveInactiveStatusView(
                          isActive: account.accountstatus == "1"),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _listItem(appLocalizations(context).institutionName,
                      account.bankname ?? "", context),
                  if (account.accountRole == "BANK")
                    _listItem(appLocalizations(context).institutionCode,
                        account.bankcode ?? "", context),
                  if (account.accountRole == "BANK")
                    _listItem(appLocalizations(context).clientId,
                        account.clientId ?? "", context),
                  _listItem(
                      appLocalizations(context).accountAddedOnAccDetail,
                      account.createdAt?.formatRelativeDateTime(context) ?? "",
                      context),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: Text(appLocalizations(context).goBack),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Padding _listItem(String key, String value, context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$key : "),
            Text(value),
          ],
        ),
      );
}
