import 'dart:math';

import 'package:bctpay/data/models/transactions/momo_lookup_response.dart';
import 'package:bctpay/data/models/transactions/wallet_balance_response_model.dart';
import 'package:bctpay/data/repository/transaction_repo/wallet/get_balance_api.dart';
import 'package:bctpay/globals/index.dart';
import 'package:intl/intl.dart';

class SendMobileMoneyScreen extends StatefulWidget {
  const SendMobileMoneyScreen({super.key});

  @override
  State<SendMobileMoneyScreen> createState() => _SendMobileMoneyScreenState();
}

class _SendMobileMoneyScreenState extends State<SendMobileMoneyScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _narrationController = TextEditingController();

  List<WalletAccount> _wallets = [];
  WalletAccount? _selectedWallet;
  bool _walletLoading = true;

  List<CountryData> _countries = [];
  CountryData? _selectedCountry;
  bool _countryLoading = true;

  List<MomoInfo> _momoList = [];
  MomoInfo? _selectedMomo;
  bool _momoLoading = true;

  bool _saveAsBeneficiary = false;
  bool _savingBeneficiary = false;

  @override
  void initState() {
    super.initState();
    _loadWallets();
    _loadCountries();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _narrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = appLocalizations(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeLogoColorBlue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.transferMobileMoney,
          style:
              textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _phoneRow(t, textTheme),
                    const SizedBox(height: 14),
                    _momoDropdown(t, textTheme),
                    const SizedBox(height: 14),
                    _textField(
                      controller: _nameController,
                      hint: t.beneficiaryName,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 14),
                    _textField(
                      controller: _amountController,
                      hint: t.amount,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 8),
                    _walletBalanceRow(t, textTheme),
                    const SizedBox(height: 14),
                    _textField(
                      controller: _narrationController,
                      hint: t.narration,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
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
                          t.saveAsBeneficiary,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.walletLabel,
                      style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    _walletDropdown(context),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _savingBeneficiary ? null : _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeLogoColorBlue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    textStyle:
                        const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
                      : Text(t.continueLabel),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _momoDropdown(AppLocalizations t, TextTheme textTheme) {
    if (_momoLoading) {
      return _loadingField(t.momoType);
    }
    return InkWell(
      onTap: _showMomoSheet,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.momoType,
                  style: textTheme.labelMedium
                      ?.copyWith(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  _selectedMomo?.name.isNotEmpty == true
                      ? _selectedMomo!.name
                      : t.momoType,
                  style: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget _phoneRow(AppLocalizations t, TextTheme textTheme) {
    if (_countryLoading) {
      return _loadingField(t.country);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.country,
          style: textTheme.labelMedium
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: InkWell(
                onTap: _showCountrySheet,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_selectedCountry != null)
                        Row(
                          children: [
                            CountryFlag.fromCountryCode(
                              _selectedCountry!.countryCode,
                              height: 18,
                              width: 24,
                            ),
                            const SizedBox(width: 6),
                            Text("+${_selectedCountry!.phoneCode}",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        )
                      else
                        Text(t.country,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey.shade600)),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: _textField(
                controller: _phoneController,
                hint: t.mobileNumber,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _walletBalanceRow(AppLocalizations t, TextTheme textTheme) {
    final wallet = _selectedWallet;
    final balance = wallet?.lcyBalance ?? 0;
    final ccy = wallet != null && wallet.lcyCcy.isNotEmpty
        ? wallet.lcyCcy
        : (wallet?.symbol ?? "");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${t.walletBalance}:",
          style: textTheme.bodySmall?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(
              ccy.isNotEmpty ? "$ccy ${_formatAmount(balance)}" : _formatAmount(balance),
              style: const TextStyle(
                  color: themeLogoColorOrange, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: _walletLoading ? null : _showWalletSheet,
              style: TextButton.styleFrom(
                  foregroundColor: themeLogoColorBlue,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0)),
              child: Text(t.change),
            )
          ],
        )
      ],
    );
  }

  Widget _walletDropdown(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    if (_walletLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Loading wallets...",
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    final selected = _selectedWallet;
    return InkWell(
      onTap: _showWalletSheet,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selected != null
                        ? (selected.label.isNotEmpty
                            ? selected.label
                            : (selected.name.isNotEmpty
                                ? selected.name
                                : selected.accountNo))
                        : "—",
                    style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (selected != null)
                    Text(
                      _formatAmount(selected.lcyBalance),
                      style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w600),
                    ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey)
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.white,
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
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
      ),
    );
  }

  Widget _loadingField(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        ],
      ),
    );
  }

  void _showMomoSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        final t = appLocalizations(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  t.momoType,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _momoList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final momo = _momoList[index];
                    return ListTile(
                      title: Text(momo.name),
                      subtitle: momo.description.isNotEmpty
                          ? Text(momo.description)
                          : null,
                      trailing: _selectedMomo?.code == momo.code
                          ? const Icon(Icons.check, color: themeLogoColorBlue)
                          : null,
                      onTap: () {
                        setState(() => _selectedMomo = momo);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showCountrySheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        final t = appLocalizations(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  t.country,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _countries.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final country = _countries[index];
                    return ListTile(
                      leading: CountryFlag.fromCountryCode(
                        country.countryCode,
                        height: 18,
                        width: 24,
                      ),
                      title: Text(country.countryName),
                      subtitle: Text("+${country.phoneCode}"),
                      trailing: _selectedCountry?.countryCode == country.countryCode
                          ? const Icon(Icons.check, color: themeLogoColorBlue)
                          : null,
                      onTap: () {
                        setState(() => _selectedCountry = country);
                        _loadMomoForCountry(country.countryCode);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _showWalletSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        final t = appLocalizations(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  t.walletLabel,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _wallets.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final wallet = _wallets[index];
                    final balance = wallet.lcyBalance;
                    final ccy = wallet.lcyCcy.isNotEmpty
                        ? wallet.lcyCcy
                        : (wallet.symbol.isNotEmpty ? wallet.symbol : "");
                    return ListTile(
                      title: Text(wallet.label.isNotEmpty
                          ? wallet.label
                          : (wallet.name.isNotEmpty ? wallet.name : wallet.accountNo)),
                      subtitle: Text(
                        ccy.isNotEmpty
                            ? "$ccy ${_formatAmount(balance)}"
                            : _formatAmount(balance),
                      ),
                      trailing: _selectedWallet?.accountNo == wallet.accountNo
                          ? const Icon(Icons.check, color: themeLogoColorBlue)
                          : null,
                      onTap: () {
                        setState(() => _selectedWallet = wallet);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _loadWallets() async {
    setState(() => _walletLoading = true);
    try {
      final res = await getWalletBalance();
      final wallets = res.allAccounts;
      setState(() {
        _wallets = wallets;
        _selectedWallet = wallets.isNotEmpty ? wallets.first : null;
        _walletLoading = false;
      });
    } catch (e) {
      setState(() => _walletLoading = false);
    }
  }

  Future<void> _loadCountries() async {
    setState(() => _countryLoading = true);
    try {
      final res = await getCountryList();
      final first = res.data.isNotEmpty ? res.data.first : null;
      setState(() {
        _countries = res.data;
        _selectedCountry = first;
        _countryLoading = false;
      });
      if (first != null) {
        _loadMomoForCountry(first.countryCode);
      }
    } catch (e) {
      setState(() => _countryLoading = false);
    }
  }

  Future<void> _loadMomoForCountry(String countryCode) async {
    setState(() {
      _momoLoading = true;
      _momoList = [];
      _selectedMomo = null;
    });
    try {
      final res = await getMomoList(countryCode: countryCode);
      setState(() {
        _momoList = res.list;
        _selectedMomo = res.list.isNotEmpty ? res.list.first : null;
        _momoLoading = false;
      });
    } catch (e) {
      setState(() => _momoLoading = false);
    }
  }

  Future<void> _onContinue() async {
    final t = appLocalizations(context);
    final wallet = _selectedWallet;
    final country = _selectedCountry;
    final momo = _selectedMomo;
    final phone = _phoneController.text.trim();
    final name = _nameController.text.trim();
    final amountText = _amountController.text.trim();
    final narration = _narrationController.text.trim();

    if (wallet == null) {
      showFailedDialog(t.pleaseSelectWallet, context);
      return;
    }
    if (momo == null) {
      showFailedDialog(t.pleaseSelectMomo, context);
      return;
    }
    if (country == null) {
      showFailedDialog(t.pleaseSelectCountry, context);
      return;
    }
    if (phone.isEmpty || name.isEmpty || amountText.isEmpty) {
      showFailedDialog(t.pleaseFillRequiredFields, context);
      return;
    }

    final numericAmount =
        double.tryParse(amountText.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    final currency = wallet.lcyCcy.isNotEmpty
        ? wallet.lcyCcy
        : (wallet.symbol.isNotEmpty ? wallet.symbol : "NGN");
    final randomRef = Random().nextInt(900000) + 100000;
    final externalRef = "REF$randomRef";
    final fullMobile = "+${country.phoneCode}$phone";

    if (_saveAsBeneficiary && !_savingBeneficiary) {
      setState(() => _savingBeneficiary = true);
      try {
        await addBeneficiary(
          bankcode: momo.code,
          bankname: momo.name,
          accountnumber: fullMobile,
          beneficiaryname: name,
          accountType: wallet.accountType,
        );
        showToast(t.saveAsBeneficiary);
      } catch (e) {
        showToast(e.toString());
      } finally {
        if (mounted) setState(() => _savingBeneficiary = false);
      }
    }

    if (!mounted) return;
    Navigator.pushNamed(context, AppRoutes.sendBankSummary, arguments: {
      "amount": amountText,
      "amountValue": numericAmount,
      "amountDisplay": "$currency ${numericAmount.toStringAsFixed(2)}",
      "bank": momo.name,
      "bankCode": momo.code,
      "accountNumber": fullMobile,
      "accountName": name,
      "mobileNo": fullMobile,
      "note": narration,
      "accountType": wallet.accountType,
      "currency": currency,
      "externalRefNo": externalRef,
      "walletLabel": wallet.label.isNotEmpty
          ? wallet.label
          : (wallet.name.isNotEmpty ? wallet.name : currency),
    });
  }

  String _formatAmount(double value) {
    return NumberFormat("#,##0.00").format(value);
  }
}
