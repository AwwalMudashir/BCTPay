import 'package:bctpay/globals/index.dart';

class CustomBtn extends StatelessWidget {
  final bool isOkBtn;
  final double? width;
  final double? height;
  final void Function()? onTap;
  final Color? color;
  final String text;

  final double maxWidth;

  const CustomBtn(
      {super.key,
      this.onTap,
      required this.text,
      this.width,
      this.height,
      this.isOkBtn = true,
      this.color,
      this.maxWidth = 236});

  @override
  Widget build(BuildContext context) {
    var okBtnColors = [
      themeYellowColor,
      themeYellowColor,
    ];
    var cancelBtnColors = [
      Colors.grey,
      Colors.black38,
    ];
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        constraints: BoxConstraints(minHeight: 54, maxWidth: maxWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onTap == null
              ? Colors.grey.withValues(alpha: 0.4)
              : color ?? themeLogoColorOrange,
          gradient: (onTap == null || color != null)
              ? null
              : LinearGradient(
                  colors: isOkBtn ? okBtnColors : cancelBtnColors,
                ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: onTap == null ? Colors.grey : Colors.white),
          ),
        ),
      ),
    );
  }
}
