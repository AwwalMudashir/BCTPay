import 'package:bctpay/globals/index.dart';

class CardListItem extends StatelessWidget {
  final CardData card;
  final double elevation;
  final double leadingDimension;
  final bool showActiveInactiveStatus;

  const CardListItem({
    super.key,
    required this.card,
    this.elevation = 5,
    this.leadingDimension = 70,
    this.showActiveInactiveStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: tileColor,
      elevation: elevation,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            height: leadingDimension,
            width: leadingDimension,
            margin: EdgeInsets.only(left: 5),
            decoration: shadowDecoration,
            child: Center(child: Text("CARD")),
          ),
          title: Text(
            card.alias ?? "",
            style: textTheme(context)
                .titleMedium
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "************${card.last4Digits ?? ""}",
                style:
                    textTheme(context).bodySmall?.copyWith(color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${appLocalizations(context).expiryDate} : ",
                        style: textTheme(context)
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        card.expires?.formattedDate() ?? "",
                        style: textTheme(context)
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  if (showActiveInactiveStatus)
                    ActiveInactiveStatusView(
                      isActive: card.status?.toLowerCase() == "active",
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry contentPadding;

  const CustomListTile(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.contentPadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding,
      child: Row(children: [
        if (leading != null) leading!,
        5.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) title!,
              if (subtitle != null) subtitle!,
            ],
          ),
        ),
        5.width,
        if (trailing != null) trailing!,
      ]),
    );
  }
}
