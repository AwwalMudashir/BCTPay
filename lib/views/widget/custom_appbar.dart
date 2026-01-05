import 'package:bctpay/globals/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.titleWidget,
    this.bottom,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      elevation: 0,
      backgroundColor: backgroundColor ??
          (isDarkMode(context) ? themeColorHeader : Colors.white),
      iconTheme: IconThemeData(
          color: isDarkMode(context) ? Colors.white : Colors.black),
      centerTitle: centerTitle,
      bottom: bottom,
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
                fontSize: 18),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(200, 50);
}
