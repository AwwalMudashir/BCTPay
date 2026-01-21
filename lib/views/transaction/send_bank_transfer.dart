import 'dart:math';

import 'package:bctpay/data/models/transactions/bank_lookup_response.dart';
import 'package:bctpay/data/models/transactions/beneficiary/beneficiary_fetch_response.dart';
import 'package:bctpay/data/models/transactions/wallet_balance_response_model.dart';
import 'package:bctpay/data/repository/transaction_repo/wallet/get_balance_api.dart';
import 'package:bctpay/globals/index.dart';

class SendBankTransferScreen extends StatefulWidget {
  const SendBankTransferScreen({super.key});

  @override
  State<SendBankTransferScreen> createState() => _SendBankTransferScreenState();
}

class _SendBankTransferScreenState extends State<SendBankTransferScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _beneficiaryNameController =
      TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _narrationController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  List<WalletAccount> _walletAccounts = [];
  WalletAccount? _selectedWallet;
  bool _walletLoading = true;

  List<CountryData> _countries = [];
  CountryData? _selectedCountry;
  bool _countryLoading = true;

  List<BankInfo> _banks = [];
  BankInfo? _selectedBank;
  bool _banksLoading = false;

  bool _saveAsBeneficiary = false;
  bool _savingBeneficiary = false;

  BeneficiaryItem? _selectedBeneficiary;

  @override
  void initState() {
    super.initState();
    _loadWallets();
    _loadCountries();

    // Check for beneficiary argument and store it for later use
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey('beneficiary')) {
        _selectedBeneficiary = args['beneficiary'] as BeneficiaryItem;
        // Pre-fill will happen after banks are loaded
        if (!_countryLoading && !_banksLoading) {
          _preFillBeneficiaryData(_selectedBeneficiary!);
        }
      }
    });
  }

  void _preFillBeneficiaryData(BeneficiaryItem beneficiary) {
    _beneficiaryNameController.text = beneficiary.beneficiaryName;
    _accountController.text = beneficiary.beneficiaryAccountNo;

    // Try to find and select the bank if it exists in our bank list
    if (_banks.isNotEmpty) {
      try {
        final matchingBank = _banks.firstWhere(
          (bank) => bank.name.toLowerCase() == beneficiary.beneficiaryBankName.toLowerCase(),
        );
        setState(() {
          _selectedBank = matchingBank;
        });
      } catch (e) {
        // No matching bank found, keep the default selection
      }
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _beneficiaryNameController.dispose();
    _accountController.dispose();
    _amountController.dispose();
    _narrationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          appLocalizations(context).sendByBankTransfer,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: themeLogoColorBlue,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations(context).walletLabel,
                style: textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              _walletDropdown(context),
              const SizedBox(height: 12),
              Text(
                appLocalizations(context).country,
                style: textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              _countryDropdown(context),
              const SizedBox(height: 16),
              Text(
                appLocalizations(context).bankName,
                style: textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              _bankDropdown(context),
              const SizedBox(height: 12),
              _buildField(
                controller: _mobileController,
                hint: appLocalizations(context).beneficiaryMobileNumber,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _beneficiaryNameController,
                hint: appLocalizations(context).beneficiaryName,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _accountController,
                hint: appLocalizations(context).senderAccountNumber,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _amountController,
                hint: appLocalizations(context).amountToSend,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              _buildField(
                controller: _narrationController,
                hint: appLocalizations(context).enterNarration,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Switch(
                    value: _saveAsBeneficiary,
                    thumbColor: WidgetStateProperty.resolveWith((states) =>
                        states.contains(WidgetState.selected)
                            ? themeLogoColorBlue
                            : null),
                    trackColor: WidgetStateProperty.resolveWith((states) =>
                        states.contains(WidgetState.selected)
                            ? themeLogoColorBlue.withValues(alpha: 0.35)
                            : Colors.grey.shade300),
                    onChanged: (v) => setState(() => _saveAsBeneficiary = v),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appLocalizations(context).saveAsBeneficiary,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _savingBeneficiary ? null : _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeLogoColorBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  child: _savingBeneficiary
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(appLocalizations(context).next),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _walletDropdown(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (_walletLoading) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const Text("Loading wallets..."),
            const SizedBox(width: 20),
          ],
        ),
      );
    }

    final selected = _selectedWallet;
    return InkWell(
      onTap: () => _openWalletSheet(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                    color: themeLogoColorBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                    selected?.lcyCcy.isNotEmpty == true
                        ? selected!.lcyCcy
                        : selected?.symbol.isNotEmpty == true
                            ? selected!.symbol
                            : appLocalizations(context).walletLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color: themeLogoColorBlue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Text(
                      selected?.label.isNotEmpty == true
                          ? selected!.label
                          : selected?.name.isNotEmpty == true
                              ? selected!.name
                              : appLocalizations(context).walletLabel,
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatBalance(
                          selected?.lcyBalance ?? selected?.balance ?? 0,
                          selected?.lcyCcy.isNotEmpty == true
                              ? selected!.lcyCcy
                              : selected?.symbol ?? ""),
                      style: textTheme.bodySmall
                          ?.copyWith(color: Colors.black54),
                    ),
                  ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Colors.black54),
        ],
      ),
      ),
    );
  }

  Widget _countryDropdown(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonFormField<CountryData>(
      value: _selectedCountry,
      isExpanded: true,
      dropdownColor: Colors.white,
      items: _countries
          .map((c) => DropdownMenuItem(
                value: c,
                child: Text(
                  "${c.countryName} (${c.countryCode})",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
        if (value != null) {
          _loadBanksForCountry(value.countryCode);
        }
      },
      decoration: InputDecoration(
        hintText: _countryLoading
            ? "Loading countries..."
            : appLocalizations(context).country,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      style: textTheme.bodyMedium?.copyWith(color: Colors.black87),
    );
  }

  Widget _bankDropdown(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final title = _banksLoading
        ? "Loading banks..."
        : _selectedBank?.name ?? "Select bank";
    final color =
        (_selectedBank == null && !_banksLoading) ? Colors.grey : Colors.black87;
    return InkWell(
      onTap: _banksLoading || _countries.isEmpty ? null : () => _openBankSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium?.copyWith(color: color),
            ),
            _banksLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_drop_down_rounded,
                    color: themeLogoColorBlue)
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      {required TextEditingController controller,
      required String hint,
      TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035, // 3.5% of screen width
              vertical: 16,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  void _openBankSheet(BuildContext context) {
    if (_banks.isEmpty) return;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.grey.shade50,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          List<BankInfo> filtered = _banks;
          return StatefulBuilder(builder: (context, setModalState) {
            void filter(String value) {
              setModalState(() {
                filtered = _banks
                    .where((b) =>
                        b.name.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                      height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04), // 4% of screen width
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(appLocalizations(context).bankName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04), // 4% of screen width
                    child: TextField(
                      controller: _searchController,
                      onChanged: filter,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.black87),
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                        style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.65,
                      ),
                    child: ListView.separated(
                        shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              bottom: 24, left: 16, right: 16),
                        itemBuilder: (context, index) {
                          var bank = filtered[index];
                            return Card(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: Colors.grey.shade200)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                            leading: CircleAvatar(
                                  backgroundColor:
                                      themeLogoColorBlue.withValues(alpha: 0.1),
                              child: Text(
                                bank.name.substring(0, 1),
                                    style:
                                        const TextStyle(color: themeLogoColorBlue),
                                  ),
                                ),
                                title: Text(
                                  bank.name,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                subtitle: Text(
                                  bank.code,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Colors.black54),
                            onTap: () {
                              setState(() {
                                    _selectedBank = bank;
                              });
                              Navigator.pop(context);
                            },
                              ),
                          );
                        },
                        separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                        itemCount: filtered.length),
                  )
                ],
                ),
              ),
            );
          });
        });
  }

  void _openWalletSheet(BuildContext context) {
    if (_walletAccounts.isEmpty) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade50,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appLocalizations(context).walletLabel,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder: (context, index) {
                    final wallet = _walletAccounts[index];
                    return Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200)),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        leading: CircleAvatar(
                          backgroundColor:
                              themeLogoColorBlue.withValues(alpha: 0.1),
                          child: Text(
                            wallet.symbol.isNotEmpty
                                ? wallet.symbol.substring(0, 1)
                                : wallet.name.isNotEmpty
                                    ? wallet.name.substring(0, 1)
                                    : "?",
                            style: const TextStyle(color: themeLogoColorBlue),
                          ),
                        ),
                        title: Text(
                          wallet.label.isNotEmpty ? wallet.label : wallet.name,
                          style: const TextStyle(color: Colors.black87),
                        ),
                        subtitle: Text(
                          _formatBalance(wallet.lcyBalance,
                              wallet.lcyCcy.isNotEmpty ? wallet.lcyCcy : wallet.symbol),
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: _selectedWallet?.accountNo == wallet.accountNo
                            ? const Icon(Icons.check, color: themeLogoColorBlue)
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedWallet = wallet;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemCount: _walletAccounts.length,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _loadWallets() async {
    try {
      final res = await getWalletBalance();
      var combined = res.allAccounts
          .where((a) => a.accountNo.isNotEmpty || a.name.isNotEmpty)
          .toList();
      if (combined.isEmpty &&
          (res.accountNo.isNotEmpty || res.balance > 0 || res.ccyCode.isNotEmpty)) {
        combined = [
          WalletAccount(
            id: null,
            accountNo: res.accountNo,
            virtualAccountNo: "",
            accountType: res.accountType,
            entityCode: "",
            symbol: res.ccyCode,
            chain: "",
            username: "",
            publicAddress: "",
            name: res.accountName,
            label: res.accountName.isNotEmpty ? res.accountName : res.ccyCode,
            balance: res.balance,
            usdBalance: 0,
            lcyBalance: res.balance,
            lcyCcy: res.ccyCode,
            logo: "",
            status: "",
            primaryWallet: true,
          )
        ];
      }
      WalletAccount? chosen;
      if (combined.isNotEmpty) {
        chosen = combined.firstWhere((e) => e.primaryWallet,
            orElse: () => combined.first);
      }
      setState(() {
        _walletAccounts = combined;
        _selectedWallet = chosen;
        _walletLoading = false;
      });
    } catch (e) {
      setState(() {
        _walletLoading = false;
      });
    }
  }

  void _loadCountries() async {
    try {
      final res = await getCountryList();
      setState(() {
        _countries = res.data;
        _selectedCountry = res.data.isNotEmpty ? res.data.first : null;
        _countryLoading = false;
      });
      if (_selectedCountry != null) {
        _loadBanksForCountry(_selectedCountry!.countryCode);
      }
    } catch (e) {
      setState(() {
        _countryLoading = false;
      });
    }
  }

  void _loadBanksForCountry(String countryCode) async {
    setState(() {
      _banksLoading = true;
      _selectedBank = null;
    });
    try {
      final res = await getBankList(countryCode: countryCode);
      setState(() {
        _banks = res.list;
        _selectedBank = res.list.isNotEmpty ? res.list.first : null;
        _banksLoading = false;
      });

      // Pre-fill beneficiary data if available
      if (_selectedBeneficiary != null) {
        _preFillBeneficiaryData(_selectedBeneficiary!);
      }
    } catch (e) {
      setState(() {
        _banksLoading = false;
      });
    }
  }

  Future<void> _onNext() async {
    final mobile = _mobileController.text.trim();
    final name = _beneficiaryNameController.text.trim();
    final accountNo = _accountController.text.trim();
    final amountText = _amountController.text.trim();
    final note = _narrationController.text.trim();
    final wallet = _selectedWallet;
    final bank = _selectedBank;

    if (wallet == null) {
      showFailedDialog("Please select a wallet", context);
      return;
    }
    if (bank == null) {
      showFailedDialog("Please select a bank", context);
      return;
    }
    if (_selectedCountry == null) {
      showFailedDialog("Please select a country", context);
      return;
    }
    if (mobile.isEmpty ||
        name.isEmpty ||
        accountNo.isEmpty ||
        amountText.isEmpty) {
      showFailedDialog("Please enter all required details", context);
      return;
    }

    final numericAmount =
        double.tryParse(amountText.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    final currency = wallet.lcyCcy.isNotEmpty
        ? wallet.lcyCcy
        : (wallet.symbol.isNotEmpty ? wallet.symbol : "NGN");
    final randomRef = Random().nextInt(900000) + 100000; // 6-digit
    final externalRef = "REF$randomRef";

    if (_saveAsBeneficiary && !_savingBeneficiary) {
      setState(() => _savingBeneficiary = true);
      try {
        await addBeneficiary(
          bankcode: bank.code,
          bankname: bank.name,
          accountnumber: accountNo,
          beneficiaryname: name,
          accountType: wallet.accountType,
        );
        showToast(appLocalizations(context).saveAsBeneficiary);
      } catch (e) {
        showToast(e.toString());
      } finally {
        if (mounted) setState(() => _savingBeneficiary = false);
      }
    }

    Navigator.pushNamed(context, AppRoutes.sendBankSummary, arguments: {
      "amount": amountText,
      "amountValue": numericAmount,
      "amountDisplay": "$currency ${numericAmount.toStringAsFixed(2)}",
      "bank": bank.name,
      "bankCode": bank.code,
      "accountNumber": accountNo,
      "accountName": name,
      "mobileNo": mobile,
      "note": note,
      "accountType": wallet.accountType,
      "currency": currency,
      "externalRefNo": externalRef,
      "walletLabel":
          wallet.label.isNotEmpty ? wallet.label : (wallet.name.isNotEmpty ? wallet.name : currency),
    });
  }

  String _formatBalance(double value, String ccy) {
    return "${ccy.isNotEmpty ? "$ccy " : ""}${value.toStringAsFixed(2)}";
  }
}

