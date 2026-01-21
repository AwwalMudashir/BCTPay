import 'dart:math';

import 'package:bctpay/data/models/transactions/payment_link_generate_response.dart';
import 'package:bctpay/globals/index.dart';
import 'package:intl/intl.dart';

class GeneratePaymentLinkScreen extends StatefulWidget {
  const GeneratePaymentLinkScreen({super.key});

  @override
  State<GeneratePaymentLinkScreen> createState() =>
      _GeneratePaymentLinkScreenState();
}

class _GeneratePaymentLinkScreenState extends State<GeneratePaymentLinkScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  List<CountryData> _countries = [];
  CountryData? _selectedCountry;
  bool _loading = false;
  PaymentLinkGenerateResponse? _result;
  late String _ref;
  bool _countriesLoading = true;

  @override
  void initState() {
    super.initState();
    _ref = _generateRef();
    _loadCountries();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  String _generateRef() {
    final rnd = Random();
    final num = rnd.nextInt(900000) + 100000;
    return num.toString();
  }

  Future<void> _loadCountries() async {
    setState(() {
      _countriesLoading = true;
    });
    try {
      final res = await getCountryList();
      if (!mounted) return;
      setState(() {
        _countries = res.data;
        _selectedCountry = res.data.isNotEmpty ? res.data.first : null;
        _countriesLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _countriesLoading = false;
      });
      showToast(appLocalizations(context).unableToLoadBeneficiaries);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCountry == null) {
      showToast(appLocalizations(context).pleaseSelectCountry);
      return;
    }
    setState(() {
      _loading = true;
      _result = null;
    });
    try {
      final response = await generatePaymentLink(
        amount: double.tryParse(_amountCtrl.text.trim()) ?? 0,
        paymentNote: _noteCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        name: _nameCtrl.text.trim(),
        phoneNo: _phoneCtrl.text.trim(),
        ccy: _selectedCountry!.currencyCode,
        ref: _ref,
      );
      if (!mounted) return;
      setState(() {
        _result = response;
        _loading = false;
      });
      showSuccessDialog(
        appLocalizations(context).paymentLinkGenerated,
        context,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      showFailedDialog(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = appLocalizations(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: themeLogoColorBlue,
        title: Text(
          t.generatePaymentLink,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: themeLogoColorBlue,
          ),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: const Loader(),
        child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04, // 4% of screen width
                  vertical: 12,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _card(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: themeLogoColorBlue.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.link_rounded,
                              color: themeLogoColorBlue),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            t.generatePaymentLinkSubtitle,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _countryDropdown(textTheme, t),
                          const SizedBox(height: 12),
                          _amountField(textTheme, t),
                          const SizedBox(height: 12),
                          _textField(
                            controller: _noteCtrl,
                            label: t.paymentNote,
                            maxLines: 2,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? t.requiredField : null,
                          ),
                          const SizedBox(height: 12),
                          _textField(
                            controller: _emailCtrl,
                            label: t.emailAddress,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? t.requiredField : null,
                          ),
                          const SizedBox(height: 12),
                          _textField(
                            controller: _nameCtrl,
                            label: t.fullName,
                            validator: (v) =>
                                (v == null || v.isEmpty) ? t.requiredField : null,
                          ),
                          const SizedBox(height: 12),
                          _phoneField(textTheme, t),
                          const SizedBox(height: 12),
                          _readOnlyField(
                              label: t.reference, value: "REF$_ref"),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeLogoColorBlue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _submit,
                              child: Text(
                                t.generateLink,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_result != null) _card(
                context,
                child: _resultCard(textTheme, t, _result!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: child,
    );
  }

  Widget _countryDropdown(TextTheme textTheme, AppLocalizations t) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: t.country,
        labelStyle:
            textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: _countriesLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : DropdownButton<CountryData>(
                value: _selectedCountry,
                isExpanded: true,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                items: _countries
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Row(
                          children: [
                            CountryFlag.fromCountryCode(
                              c.countryCode,
                              height: 18,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                c.countryName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                },
              ),
      ),
    );
  }

  Widget _amountField(TextTheme textTheme, AppLocalizations t) {
    final currencyCode = _selectedCountry?.currencyCode ?? "";
    final prefixText = currencyCode.isNotEmpty ? "$currencyCode " : "";

    return TextFormField(
      controller: _amountCtrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      validator: (v) {
        final val = double.tryParse(v ?? "");
        if (val == null || val <= 0) {
          return t.enterValidAmount;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: t.amount,
        labelStyle: textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        prefixText: prefixText,
        prefixStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _phoneField(TextTheme textTheme, AppLocalizations t) {
    final phoneCode = _selectedCountry?.phoneCode ?? "";
    final prefixText = phoneCode.isNotEmpty ? "+$phoneCode -" : "";

    return TextFormField(
      controller: _phoneCtrl,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      validator: (v) => (v == null || v.isEmpty) ? t.requiredField : null,
      decoration: InputDecoration(
        labelText: t.mobileNumber,
        labelStyle: textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        prefixText: prefixText,
        prefixStyle: textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _readOnlyField({required String label, required String value}) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
          icon: const Icon(Icons.copy_outlined, size: 18, color: themeLogoColorBlue),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            showToast(appLocalizations(context).copied);
          },
        ),
      ),
      controller: TextEditingController(text: value),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.grey.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: themeLogoColorBlue, width: 1.2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      ),
    );
  }

  Widget _resultCard(
      TextTheme textTheme, AppLocalizations t, PaymentLinkGenerateResponse r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: themeLogoColorBlue.withValues(alpha: 0.12),
                  shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: themeLogoColorBlue),
            ),
            const SizedBox(width: 10),
            Text(
              t.paymentLinkGenerated,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _row(textTheme, t.accountNumber, r.accountNo ?? ""),
        _row(textTheme, t.virtualAccount, r.virtualAccountNo ?? ""),
        _row(textTheme, t.currency, r.lcyCcy ?? r.symbol ?? ""),
        _row(
            textTheme,
            t.balance,
            NumberFormat('#,##0.00').format(
                (r.lcyBalance ?? r.balance ?? 0).toDouble())),
        _row(textTheme, t.status, r.status ?? ""),
      ],
    );
  }

  Widget _row(TextTheme textTheme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: themeLogoColorBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
