import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class SelectBankDropDown extends StatefulWidget {
  final SelectionBloc selectBankBloc;
  final String accountType;

  const SelectBankDropDown(
      {super.key, required this.selectBankBloc, required this.accountType});

  @override
  State<SelectBankDropDown> createState() => _SelectBankDropDownState();
}

class _SelectBankDropDownState extends State<SelectBankDropDown> {
  @override
  void initState() {
    super.initState();
    banksListBloc.add(GetBanksListEvent(accountType: widget.accountType));
  }

  List<Bank> banksList = [];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: width,
      height: 60,
      padding: const EdgeInsets.only(left: 20, right: 30),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: shadowDecoration,
      child: BlocConsumer(
          bloc: banksListBloc,
          listener: (context, state) {
            if (state is GetBanksListState) {
              if (state.value.code == 200) {
                banksList = state.value.data == null
                    ? []
                    : state.value.data!.bankList
                        .where((e) =>
                            e.countryCode == selectedCountry?.countryCode &&
                            e.accountType == widget.accountType)
                        .toList();
                widget.selectBankBloc.add(SelectBankEvent(
                    banksList.isEmpty ? null : banksList.first));
              } else if (state.value.code ==
                  HTTPResponseStatusCodes.sessionExpireCode) {
                sessionExpired(state.value.message, context);
              } else {
                showToast(state.value.message);
              }
            }
          },
          builder: (context, state) {
            if (state is GetBanksListState) {
              banksList = state.value.data == null
                  ? []
                  : state.value.data!.bankList
                      .where((e) =>
                          e.countryCode == selectedCountry?.countryCode &&
                          e.accountType == widget.accountType)
                      .toList();
              if (banksList.isEmpty) {
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      appLocalizations(context).noAccount,
                      style:
                          textTheme.titleMedium?.copyWith(color: Colors.black),
                    ));
              }
              return BlocBuilder(
                  bloc: widget.selectBankBloc,
                  builder: (context, selectBankBlocState) {
                    if (selectBankBlocState is SelectBankState) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton(
                            style: textTheme.titleMedium!
                                .copyWith(color: Colors.black),
                            dropdownColor:
                                const Color.fromARGB(255, 221, 216, 216),
                            itemHeight: 60,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.black,
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: selectBankBlocState.bank!,
                            items: banksList
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white))),
                                      child: Row(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "$baseUrlBankLogo${e.logo}",
                                            progressIndicatorBuilder:
                                                progressIndicatorBuilder,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.image,
                                              color: Colors.grey,
                                            ),
                                            height: 60,
                                            width: 60,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(e.name),
                                        ],
                                      ),
                                    )))
                                .toList(),
                            onChanged: (value) {
                              widget.selectBankBloc.add(SelectBankEvent(value));
                            }),
                      );
                    }
                    return const Loader();
                  });
            }
            return const Loader();
          }),
    );
  }
}
