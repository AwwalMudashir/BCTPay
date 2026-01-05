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

  final List<_BankItem> _banks = const [
    _BankItem(name: "Vale", color: Color(0xFF0E7CE4)),
    _BankItem(name: "Kuda", color: Color(0xFF6B1B96)),
    _BankItem(name: "GTBank", color: Color(0xFFE65B00)),
    _BankItem(name: "Moniepoint", color: Color(0xFF0F66E7)),
    _BankItem(name: "Polaris", color: Color(0xFF7B1FA2)),
  ];

  String? _selectedBank;
  bool _saveAsBeneficiary = false;

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          appLocalizations(context).sendByBankTransfer,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _balanceCard(context),
              const SizedBox(height: 16),
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
                    style: textTheme.bodyMedium,
                  )
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppRoutes.sendBankSummary,
                        arguments: {
                          "amount": _amountController.text.isEmpty
                              ? "₦5,800"
                              : _amountController.text,
                          "bank": _selectedBank ?? "First Bank (FBN)",
                          "bankCode": _selectedBank ?? "FBN",
                          "accountNumber": _accountController.text.isEmpty
                              ? "30983465472"
                              : _accountController.text,
                          "accountName": _beneficiaryNameController.text.isEmpty
                              ? "James David"
                              : _beneficiaryNameController.text,
                          "mobileNo": _mobileController.text.isEmpty
                              ? "08000000000"
                              : _mobileController.text,
                          "note": _narrationController.text,
                          "accountType": "BANK",
                          "currency": "NGN",
                          "externalRefNo":
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeLogoColorBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  child: Text(appLocalizations(context).next),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _balanceCard(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeLogoColorBlue.withValues(alpha: 0.15)),
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
                  color: themeLogoColorBlue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  appLocalizations(context).ngnBalance,
                  style: textTheme.bodySmall?.copyWith(
                    color: themeLogoColorBlue,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "₦920,550.05",
                style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _bankDropdown(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => _openBankSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedBank ?? "Select bank",
              style: textTheme.bodyMedium?.copyWith(
                  color:
                      _selectedBank == null ? Colors.grey : Colors.black87),
            ),
            const Icon(Icons.arrow_drop_down_rounded, color: themeLogoColorBlue)
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
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) {
          List<_BankItem> filtered = _banks;
          return StatefulBuilder(builder: (context, setModalState) {
            void filter(String value) {
              setModalState(() {
                filtered = _banks
                    .where((b) =>
                        b.name.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            }

            return Padding(
              padding:
                  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Select Bank",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      onChanged: filter,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
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
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 24),
                        itemBuilder: (context, index) {
                          var bank = filtered[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: bank.color.withValues(alpha: 0.15),
                              child: Text(
                                bank.name.substring(0, 1),
                                style: TextStyle(color: bank.color),
                              ),
                            ),
                            title: Text(bank.name),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded,
                                size: 14),
                            onTap: () {
                              setState(() {
                                _selectedBank = bank.name;
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, thickness: 0.5),
                        itemCount: filtered.length),
                  )
                ],
              ),
            );
          });
        });
  }
}

class _BankItem {
  final String name;
  final Color color;

  const _BankItem({required this.name, required this.color});
}

