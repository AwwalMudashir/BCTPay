import 'package:bctpay/lib.dart';

class ExpansionMenu extends StatelessWidget {
  final List<Widget> children;
  final Widget title;
  final Widget leading;

  const ExpansionMenu(
      {super.key,
      required this.children,
      required this.title,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        backgroundColor: isDarkMode(context) ? themeColorHeader : Colors.grey,
        leading: leading,
        visualDensity: VisualDensity.compact,
        tilePadding: EdgeInsets.symmetric(horizontal: 16),
        iconColor: isDarkMode(context) ? Colors.white : Colors.black,
        collapsedIconColor: isDarkMode(context) ? Colors.white : Colors.black,
        title: title,
        collapsedShape: Border(
          bottom:
              BorderSide(width: 1.5, color: Colors.grey.withValues(alpha: 0.1)),
        ),
        shape: Border(
          bottom:
              BorderSide(width: 1.5, color: Colors.grey.withValues(alpha: 0.1)),
        ),
        childrenPadding: EdgeInsets.only(left: 20),
        children: children);
  }
}
