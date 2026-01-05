import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class MobileRecharge extends StatefulWidget {
  const MobileRecharge({super.key});

  @override
  State<MobileRecharge> createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  var recentBillTxnBloc = ApisBloc(ApisBlocInitialState());

  List<Contact>? contacts = [];

  var mobileController = TextEditingController();
  var selectPhoneCountryBloc = SelectionBloc(SelectCountryState(
      Country.parse(selectedCountry?.countryName ?? "GN"), selectedCountry!));

  @override
  void initState() {
    kycBloc.add(GetKYCDetailEvent());
    selectPhoneCountryBloc.stream.listen((state) {
      if (state is SelectCountryState) {
        var selectedPhoneCode = "+${state.countryData.phoneCode}";
        if (mobileController.text.contains(selectedPhoneCode)) {
          mobileController.text =
              mobileController.text.replaceAll(selectedPhoneCode, "");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).mobileRecharge),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor:
                    isDarkMode(context) ? themeLogoColorBlue : Colors.white,
                builder: (context) => const NewContactForm(
                      isMobileRecharge: true,
                    ));
          },
          label: Text(appLocalizations(context).newContact,
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.black))),
      body: BlocConsumer(
          bloc: kycBloc,
          listener: (context, state) {
            if (state is GetKYCDetailState) {
              if (state.value.code == 200) {
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(
                    state.value.message ?? state.value.error ?? "", context);
              } else {
                showFailedDialog(
                    state.value.message ?? state.value.error ?? "", context);
              }
            }
          },
          builder: (context, kycState) {
            if (kycState is GetKYCDetailState) {
              var kycStatus =
                  kycState.value.data?.kycStatus ?? KYCStatus.pending;
              return Scrollbar(
                thickness: 10,
                interactive: true,
                radius: const Radius.circular(10),
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  children: [
                    TitleWidget(title: appLocalizations(context).mobileNumber),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            keyboardType: TextInputType.phone,
                            controller: mobileController,
                            labelText: appLocalizations(context).mobileNumber,
                            hintText:
                                appLocalizations(context).enterMobileNumber,
                            prefixWidget: CountryPickerTxtFieldPrefix(
                              showPhoneCodeAlso: false,
                              selectPhoneCountryBloc: selectPhoneCountryBloc,
                            ),
                            onChanged: (p0) {
                              seperatePhoneAndDialCode(p0,
                                  selectPhoneCountryBloc:
                                      selectPhoneCountryBloc);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TitleWidget(title: appLocalizations(context).myContact),
                        ContactsList(
                          physics: const NeverScrollableScrollPhysics(),
                          mobileController.text,
                          kycStatus: kycStatus,
                          isMobileRecharge: true,
                          showContactWhenNotExist: true,
                          selectPhoneCountryBloc: selectPhoneCountryBloc,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Loader();
          }),
    );
  }
}
