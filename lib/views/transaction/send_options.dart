import 'package:bctpay/globals/index.dart';

class SendOptionsScreen extends StatefulWidget {
  const SendOptionsScreen({super.key});

  @override
  State<SendOptionsScreen> createState() => _SendOptionsScreenState();
}

class _SendOptionsScreenState extends State<SendOptionsScreen> {
  List<BeneficiaryItem> _beneficiaries = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBeneficiaries();
  }

  Future<void> _fetchBeneficiaries() async {
    try {
      final res = await getBeneficiaryList(page: 1, limit: 10);
      setState(() {
        _beneficiaries = res.beneficiaryList;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final t = appLocalizations(context);

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
        centerTitle: true,
        title: Text(
          t.transfer,
          style:
              textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _optionTile(
                context,
                title: t.transferMobileMoney,
                subtitle: t.transferMobileMoneySubtitle,
                icon: Icons.send_rounded,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.sendMobileMoney),
              ),
              const SizedBox(height: 12),
              _optionTile(
                context,
                title: t.sendToBankAccount,
                subtitle: t.sendToBankAccountSubtitle,
                icon: Icons.account_balance_rounded,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.sendBankTransfer,
                ),
              ),
              const SizedBox(height: 20),
              _beneficiariesCard(context, textTheme, t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _beneficiariesCard(
      BuildContext context, TextTheme textTheme, AppLocalizations t) {
    Widget content;
    if (_loading) {
      content = const SizedBox(
        height: 120,
        child: Center(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    } else if (_error != null) {
      content = Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            t.unableToLoadBeneficiaries,
            style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
          ),
        ),
      );
    } else if (_beneficiaries.isEmpty) {
      content = SizedBox(
        height: 140,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.07, // Responsive radius
                backgroundColor: Colors.blueGrey.shade50,
                child: Icon(Icons.group_outlined,
                    color: Colors.grey, size: MediaQuery.of(context).size.width * 0.07), // Responsive icon size
              ),
              const SizedBox(height: 8),
              Text(
                t.noBeneficiaries,
                style:
                    textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      );
    } else {
      content = SizedBox(
        height: 130,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final b = _beneficiaries[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.065, // Responsive radius
                  backgroundColor: themeLogoColorBlue.withValues(alpha: 0.12),
                  child: Text(
                    b.beneficiaryName.isNotEmpty
                        ? b.beneficiaryName.substring(0, 1).toUpperCase()
                        : b.beneficiaryAccountNo.isNotEmpty
                            ? b.beneficiaryAccountNo.substring(0, 1)
                            : "?",
                    style: const TextStyle(
                        color: themeLogoColorBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25, // Responsive width
                    child: Text(
                      b.beneficiaryName.isNotEmpty
                          ? b.beneficiaryName
                          : b.beneficiaryAccountNo,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    )),
                SizedBox(
                  width: 120,
                  child: Text(
                    b.beneficiaryBankName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemCount: _beneficiaries.length,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.beneficiaries,
                  style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: themeLogoColorBlue)),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.sendBeneficiaries);
                },
                style: TextButton.styleFrom(
                  foregroundColor: themeLogoColorOrange,
                  textStyle: textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                child: Text(t.seeAll),
              )
            ],
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _optionTile(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap}) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: themeLogoColorBlue.withValues(alpha: 0.12),
              child: Icon(icon, color: themeLogoColorBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: textTheme.bodySmall
                          ?.copyWith(color: Colors.grey.shade700)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: Colors.black54)
          ],
        ),
      ),
    );
  }
}

class SendBeneficiariesScreen extends StatefulWidget {
  const SendBeneficiariesScreen({super.key});

  @override
  State<SendBeneficiariesScreen> createState() => _SendBeneficiariesScreenState();
}

class _SendBeneficiariesScreenState extends State<SendBeneficiariesScreen> {
  List<BeneficiaryItem> _beneficiaries = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchBeneficiaries();
  }

  Future<void> _fetchBeneficiaries() async {
    try {
      // Fetch all beneficiaries with a higher limit
      final res = await getBeneficiaryList(page: 1, limit: 100); // Increased limit to get all
      setState(() {
        _beneficiaries = res.beneficiaryList;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final t = appLocalizations(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(t.beneficiaries,
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(t.unableToLoadBeneficiaries),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchBeneficiaries,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              : _beneficiaries.isEmpty
                  ? Center(child: Text(t.noBeneficiaries))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemBuilder: (context, index) {
                        final b = _beneficiaries[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: themeLogoColorBlue.withValues(alpha: 0.15),
                            child: Text(
                              b.beneficiaryName.isNotEmpty
                                  ? b.beneficiaryName.substring(0, 1).toUpperCase()
                                  : b.beneficiaryAccountNo.isNotEmpty
                                      ? b.beneficiaryAccountNo.substring(0, 1)
                                      : "?",
                              style: TextStyle(
                                  color: themeLogoColorBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(
                              b.beneficiaryName.isNotEmpty
                                  ? b.beneficiaryName
                                  : b.beneficiaryAccountNo,
                              style: textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          subtitle: Text(b.beneficiaryBankName.isNotEmpty
                              ? b.beneficiaryBankName
                              : "Bank Account"),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                          onTap: () {
                            // Navigate to send money screen with this beneficiary
                            Navigator.pushNamed(
                              context,
                              AppRoutes.sendBankTransfer,
                              arguments: {
                                'beneficiary': b,
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
                      itemCount: _beneficiaries.length,
                    ),
    );
  }
}


