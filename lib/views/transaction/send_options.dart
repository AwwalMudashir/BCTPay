import 'package:bctpay/globals/index.dart';

class SendOptionsScreen extends StatelessWidget {
  const SendOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final beneficiaries = _staticBeneficiaries;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Transfer",
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Beneficiaries",
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.sendBeneficiaries);
                      },
                      child: const Text("See All"))
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 74,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final b = beneficiaries[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: b.color.withValues(alpha: 0.15),
                          child: Text(
                            b.initials,
                            style: TextStyle(
                                color: b.color, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                            width: 70,
                            child: Text(
                              b.name,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall,
                            ))
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: beneficiaries.length,
                ),
              ),
              const SizedBox(height: 16),
              Text("Select the payment method you want to use.",
                  style: textTheme.bodySmall),
              const SizedBox(height: 12),
              _optionTile(
                context,
                title: "Send Via Usertag",
                subtitle: "Send funds to a friend using their tag",
                icon: Icons.person,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _optionTile(
                context,
                title: "Send to Bank Account",
                subtitle: "Send to a recipient bank account",
                icon: Icons.account_balance_wallet_outlined,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.sendBankTransfer,
                ),
              ),
              const SizedBox(height: 12),
              _optionTile(
                context,
                title: "Scan QR Code to Send",
                subtitle: "Send funds by scanning a QR code",
                icon: Icons.qr_code_rounded,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap}) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2))
            ]),
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
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
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

class SendBeneficiariesScreen extends StatelessWidget {
  const SendBeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final beneficiaries = _staticBeneficiaries;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Beneficiaries",
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final b = beneficiaries[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 22,
              backgroundColor: b.color.withValues(alpha: 0.15),
              child: Text(
                b.initials,
                style:
                    TextStyle(color: b.color, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(b.name,
                style: textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
            subtitle: const Text("30983465472"),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {},
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
        itemCount: beneficiaries.length,
      ),
    );
  }
}

class _Beneficiary {
  final String name;
  final Color color;
  const _Beneficiary(this.name, this.color);

  String get initials {
    final parts = name.split(" ");
    if (parts.length >= 2) {
      return parts[0].substring(0, 1) + parts[1].substring(0, 1);
    }
    return name.substring(0, 1);
  }
}

const _staticBeneficiaries = <_Beneficiary>[
  _Beneficiary("James David", Colors.deepOrange),
  _Beneficiary("Aliu Bashir", Color(0xFF0E7CE4)),
  _Beneficiary("James David", Color(0xFF6B1B96)),
  _Beneficiary("Adeyemi John", Color(0xFF0F66E7)),
  _Beneficiary("James David", Color(0xFF6B1B96)),
  _Beneficiary("James David", Colors.deepOrange),
];

