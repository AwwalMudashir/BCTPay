import 'package:bctpay/globals/index.dart';

class KYCHistoryListItem extends StatelessWidget {
  final KycList kyc;

  const KYCHistoryListItem({super.key, required this.kyc});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: shadowDecoration,
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: (kyc.currentStatus == KYCStatus.uploaded)
                      ? "$baseUrlProfileImage${kyc.createdBy?.profilePic}"
                      : "$baseUrlProfileImage${kyc.updatedBy?.profilePic}",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: progressIndicatorBuilder,
                  errorWidget: (context, url, error) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(Assets.assetsImagesPerson),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            (kyc.currentStatus == KYCStatus.uploaded)
                                ? "${kyc.createdBy?.fullName}"
                                : kyc.updatedBy?.fullName ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: textTheme.titleSmall),
                      ),
                      Text(
                        kyc.createdAt?.formatRelativeDateTime(context) ?? "",
                        style: textTheme.bodySmall
                            ?.copyWith(color: themeGreyColor),
                      ),
                    ],
                  ),
                  if (kyc.identityProof?.isNotEmpty ?? false)
                    Text(
                      "${appLocalizations(context).documentType}: ${kyc.identityProof?.first.docType}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  if (kyc.updatationType?.isNotEmpty ?? false)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "${appLocalizations(context).kycType}: ${kyc.updatationType}"),
                        )
                      ],
                    ),
                  if (kyc.docType?.isNotEmpty ?? false)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "${appLocalizations(context).docType}: ${kyc.docType}"),
                        )
                      ],
                    ),
                  Row(
                    children: [
                      KYCStatusView(
                        kycStatus: kyc.currentStatus ?? KYCStatus.pending,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (kyc.previewStutus != null) //prevKYCStatus
                        Text(
                          "${kyc.previewStutus?.value}",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  if (kyc.viewComment == "true" &&
                      (kyc.commentsOn?.isNotEmpty ?? false))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${appLocalizations(context).comment}: ",
                        ),
                        Expanded(
                          child: Text(
                            kyc.commentsOn ?? "",
                            style: textTheme.headlineSmall?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
