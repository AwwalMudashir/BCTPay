import 'dart:io';

import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class QueryHistoryDetail extends StatefulWidget {
  const QueryHistoryDetail({super.key, this.query});

  final Query? query;

  @override
  State<QueryHistoryDetail> createState() => _QueryHistoryDetailState();
}

class _QueryHistoryDetailState extends State<QueryHistoryDetail> {
  final queryDetailBloc = ApisBloc(ApisBlocInitialState());

  Query? query;
  String customerId = "";

  var messageController = TextEditingController();

  var imagePickerBloc = SelectionBloc(SelectionBlocInitialState());

  List<XFile?> selectedAttachments = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var widget = args(context) as QueryHistoryDetail;
      query = widget.query;
      customerId = query?.customerId ?? "";
      queryDetailBloc.add(QueryDetailEvent(queryId: widget.query?.id ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return BlocConsumer(
        bloc: queryDetailBloc,
        listener: (context, state) {
          if (state is QueryDetailState) {
            var code = state.value.code;
            if (code == 200) {
              query = state.value.data;
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message ?? "", context);
            } else {
              showFailedDialog(state.value.message ?? "", context);
            }
          }
          if (state is CloseQueryState) {
            var code = state.value.code;
            if (code == 200) {
              showSuccessDialog(state.value.message ?? "", context);
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message ?? "", context);
            } else {
              showFailedDialog(state.value.message ?? "", context);
            }
            queryDetailBloc.add(QueryDetailEvent(queryId: query?.id ?? ""));
          }
          if (state is ReplyQueryState) {
            var code = state.value.code;
            if (code == 200) {
              clearSendBox();
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message ?? "", context);
            } else {
              showFailedDialog(state.value.message ?? "", context);
            }
            queryDetailBloc.add(QueryDetailEvent(queryId: query?.id ?? ""));
          }
        },
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: BlocConsumer(
                  bloc: imagePickerBloc,
                  listener: (context, state) {
                    if (state is SelectMultipleMediaState) {
                      selectedAttachments.addAll(state.files);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight: selectedAttachments.isNotEmpty ? 200 : 100,
                      ),
                      margin: EdgeInsets.fromLTRB(5, 5, 5,
                          MediaQuery.of(context).viewInsets.bottom + 5),
                      child: query?.closeStatus == "true"
                          ? Text(
                              appLocalizations(context).queryClosedYouCantReply,
                              textAlign: TextAlign.center,
                              style: textTheme(context)
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            )
                          : Column(
                              children: [
                                if (selectedAttachments.isNotEmpty)
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: selectedAttachments.length,
                                      itemBuilder: (context, index) => Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Image.file(File(
                                                selectedAttachments[index]
                                                        ?.path ??
                                                    "")),
                                          ),
                                          Positioned(
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {
                                                detach(
                                                    selectedAttachments[index]);
                                              },
                                              child: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        height: null,
                                        borderRadius: 10,
                                        minLines: 1,
                                        maxLines: 4,
                                        controller: messageController,
                                        hintText: appLocalizations(context)
                                            .enterMessage,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (query?.isAttachmentAllowed
                                                ?.toLowerCase() ==
                                            "true")
                                          IconButton(
                                              onPressed: attach,
                                              icon: Icon(
                                                  Icons.attach_file_outlined)),
                                        IconButton(
                                          onPressed: send,
                                          icon: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: themeLogoColorOrange,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.send_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    );
                  }),
              appBar: CustomAppBar(
                title: selectedLanguage == "en"
                    ? query?.typeOfQueriesEn ?? ""
                    : query?.typeOfQueriesGn ?? "",
                actions: [
                  if (query?.closeStatus == "true")
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: query?.closeStatus == "true"
                                ? Colors.white
                                : null,
                            backgroundColor: query?.closeStatus == "true"
                                ? Colors.red
                                : null),
                        onPressed: () {
                          if (query?.closeStatus == "true") {
                            showToast(appLocalizations(context).closed);
                          } else {
                            queryDetailBloc
                                .add(CloseQueryEvent(queryId: query?.id ?? ""));
                          }
                        },
                        child: Text(query?.closeStatus == "true"
                            ? appLocalizations(context).closed
                            : appLocalizations(context).closeQuery))
                ],
              ),
              body: ListView.separated(
                reverse: true,
                padding: EdgeInsets.all(2),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: query?.messages?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
                itemBuilder: (context, index) {
                  QueryMessage queryData = query?.messages?[
                          (query?.messages?.length ?? 0) - index - 1] ??
                      QueryMessage();
                  return messageView(queryData,
                      isMyMessage: customerId != queryData.senderId);
                },
              ));
        });
  }

  Widget messageView(QueryMessage queryData, {required bool isMyMessage}) {
    return Row(
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: width * 0.2,
            maxWidth: width * 0.8,
          ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: isMyMessage ? Radius.zero : Radius.circular(15),
              topRight: isMyMessage ? Radius.circular(15) : Radius.zero,
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: isMyMessage
                ? themeLogoColorOrange.withValues(alpha: 1)
                : themeColorHeader,
          ),
          child: Column(
            crossAxisAlignment:
                isMyMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                queryData.senderName ?? "",
                style: textTheme(context).bodySmall?.copyWith(
                      color: !isMyMessage
                          ? themeLogoColorOrange
                          : themeColorHeader,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              5.height,
              if (queryData.queryImage?.isNotEmpty ?? false)
                StaggeredPhotoGridview(
                  queryMessage: queryData,
                ),
              5.height,
              Text(
                queryData.message ?? "",
                style: textTheme(context)
                    .bodySmall
                    ?.copyWith(color: Colors.white, fontSize: 12),
              ),
              2.toSpace,
              Text(
                queryData.createdAt?.formatRelativeDateTime(context) ?? "",
                style: textTheme(context)
                    .bodySmall
                    ?.copyWith(color: Colors.white, fontSize: 9),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void send() {
    if (messageController.text.trim().isNotEmpty ||
        selectedAttachments.isNotEmpty) {
      queryDetailBloc.add(ReplyQueryEvent(
          queryId: query?.id ?? "",
          message: messageController.text,
          queryImage: selectedAttachments));
    }
  }

  void attach() {
    if (query?.isAttachmentAllowed?.toLowerCase() == "true") {
      ImagePickerController.pickMultipleMedia(enableImageCrop: false).then(
          (value) => imagePickerBloc.add(SelectMultipleMediaEvent(value)));
    } else {
      showToast(appLocalizations(context).notAllowed);
    }
  }

  void detach(XFile? image) {
    imagePickerBloc.add(SelectImageEvent(image));
    selectedAttachments.remove(image);
  }

  void clearSendBox() {
    messageController.clear();
    selectedAttachments.clear();
  }
}
