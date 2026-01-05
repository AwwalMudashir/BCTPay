import 'package:bctpay/globals/index.dart';

class SendBankEnterPinScreen extends StatefulWidget {
  const SendBankEnterPinScreen({super.key});

  @override
  State<SendBankEnterPinScreen> createState() => _SendBankEnterPinScreenState();
}

class _SendBankEnterPinScreenState extends State<SendBankEnterPinScreen> {
  final List<String> _pin = ["", "", "", ""];

  void _onDigit(String digit) {
    for (int i = 0; i < _pin.length; i++) {
      if (_pin[i].isEmpty) {
        setState(() => _pin[i] = digit);
        break;
      }
    }
    if (_pin.every((d) => d.isNotEmpty)) {
      _submit();
    }
  }

  void _backspace() {
    for (int i = _pin.length - 1; i >= 0; i--) {
      if (_pin[i].isNotEmpty) {
        setState(() => _pin[i] = "");
        break;
      }
    }
  }

  void _submit() {
    Navigator.pushNamed(context, AppRoutes.sendBankSuccess);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(appLocalizations(context).enterYourPin,
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(appLocalizations(context).enterYourPinDesc,
                  style: textTheme.bodySmall),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  4,
                  (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          _pin[i].isNotEmpty ? "•" : "",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _pin.any((d) => d.isNotEmpty) ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeLogoColorBlue,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  child: Text(appLocalizations(context).continueLabel),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _numberPad(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _numberPad() {
    final numbers = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"],
      ["*", "0", "<"]
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: numbers
            .map((row) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: row.map((value) {
                      if (value == "<") {
                        return _key(
                            icon: Icons.backspace_outlined, onTap: _backspace);
                      }
                      return _key(
                          label: value,
                          onTap: () {
                            if (int.tryParse(value) != null) {
                              _onDigit(value);
                            }
                          });
                    }).toList(),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _key({String? label, IconData? icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: Colors.black87)
            : Text(
                label ?? "",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}

