import 'package:bctpay/globals/index.dart';

class QueryListItem extends StatelessWidget {
  final Query query;

  const QueryListItem({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.queryDetail,
            arguments: QueryHistoryDetail(
              query: query,
            ));
      },
      child: Card(
        elevation: 5,
        color: tileColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox.square(
                dimension: 50,
                child: Card(
                  elevation: 5,
                  color: tileColor,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.grey,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            query.tracingNo ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          query.createdAt?.formatRelativeDateTime(context) ??
                              "",
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      query.messages?.first.message ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.headlineSmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${appLocalizations(context).type} : ${query.typeOfQueriesEn}",
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        if (query.closeStatus == "true")
                          QueryStatusView(
                            queryStatus: query.closeStatus,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
