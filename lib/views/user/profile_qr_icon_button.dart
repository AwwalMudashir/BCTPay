import 'package:bctpay/lib.dart';

class ProfileQRCodeBtn extends StatelessWidget {
  final bool enableBorder;

  const ProfileQRCodeBtn({super.key, this.enableBorder = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.profileQR);
      },
      child: Container(
        padding: EdgeInsets.all(enableBorder ? 2 : 0),
        decoration: enableBorder
            ? BoxDecoration(
                border: Border.all(
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                    width: 1.2),
                borderRadius: BorderRadius.circular(5))
            : null,
        child: const Icon(Icons.qr_code_2),
      ),
    );
  }
}
