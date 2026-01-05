import 'package:bctpay/lib.dart';
import 'package:flutter/cupertino.dart';

class PrimaryAccountHistoryListItem extends StatelessWidget {
  const PrimaryAccountHistoryListItem({super.key, required this.accountData});

  final PrimaryAcoountList accountData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                color: Colors.grey.withValues(alpha: 0.5))
          ]),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  accountData.updatedbyUserName ??
                      appLocalizations(context).unknown,
                  softWrap: true,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              Text(
                accountData.createdAt?.formatRelativeDateTime(context) ?? "",
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black54, fontSize: 10),
              ),
            ],
          ),
          1.width,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations(context).oldPrimary,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 10),
              ),
              Text(
                appLocalizations(context).newPrimary,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 10),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${appLocalizations(context).accountNumber} : ${(accountData.previousAccountNo?.isNotEmpty ?? false) ? accountData.previousAccountNo?.showLast4HideAll() : "N/A"}",
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 11),
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.minus,
                    color: themeLogoColorOrange,
                    size: 12,
                  ),
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: themeLogoColorOrange,
                    size: 12,
                  ),
                ],
              ),
              Text(
                "${appLocalizations(context).accountNumber} : ${(accountData.accountNo?.isNotEmpty ?? false) ? accountData.accountNo?.showLast4HideAll() : "N/A"}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, fontSize: 11),
              ),
            ],
          ),
          2.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${appLocalizations(context).type} : ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black87, fontSize: 11),
                  ),
                  Text(
                    accountData.previousAccountType ?? " ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: themeLogoColorOrange, fontSize: 11),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "${appLocalizations(context).type} : ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black87, fontSize: 11),
                  ),
                  Text(
                    accountData.accountType ?? " ",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: themeLogoColorOrange, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
