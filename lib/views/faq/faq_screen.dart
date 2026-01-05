import 'package:bctpay/lib.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  String? expandedId;

  List<FAQ> faqs = [];

  final faqBloc = ApisBloc(ApisBlocInitialState());

  List<FAQ> get filteredFaqs => faqs
      .where((faq) => faq.translations
          .where((e) => e.language_name == selectedLanguage)
          .first
          .question
          .toLowerCase()
          .contains(searchText.toLowerCase()))
      .toList();

  void toggleExpand(String id) {
    setState(() {
      expandedId = expandedId == id ? null : id;
    });
  }

  int page = 1;
  int limit = 10;

  @override
  void initState() {
    super.initState();
    faqBloc.add(GetFAQsEvent(page: page, limit: limit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations(context).faq),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),
            Text(
              appLocalizations(context).faqScreenHeading,
              style: textTheme(context).headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              appLocalizations(context).faqScreenDesc,
              style: textTheme(context).bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Search Bar
            CustomTextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              prefix: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: appLocalizations(context).searchHere,
              labelText: appLocalizations(context).search,
            ),
            const SizedBox(height: 16),
            // FAQ List
            BlocConsumer(
              bloc: faqBloc,
              listener: (context, state) {
                if (state is GetFAQsState) {
                  int code = state.value.code;
                  String msg = state.value.message;
                  if (code == 200) {
                    faqs = state.value.data.faqs;
                  } else if (code ==
                      HTTPResponseStatusCodes.sessionExpireCode) {
                    sessionExpired(msg, context);
                  } else {
                    showFailedDialog(msg, context);
                  }
                }
              },
              builder: (context, state) {
                return ModalProgressHUD(
                  progressIndicator: Loader(),
                  inAsyncCall: state is ApisBlocLoadingState,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredFaqs.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var faq = filteredFaqs[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                faq.translations
                                    .where((e) =>
                                        e.language_name == selectedLanguage)
                                    .first
                                    .question,
                                style: textTheme(context).titleMedium,
                              ),
                              trailing: Icon(
                                expandedId == faq.id ? Icons.remove : Icons.add,
                              ),
                              onTap: () => toggleExpand(faq.id),
                            ),
                            if (expandedId == faq.id)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  faq.translations
                                      .where((e) =>
                                          e.language_name == selectedLanguage)
                                      .first
                                      .answer,
                                  style: textTheme(context)
                                      .bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                            const Divider(),
                          ],
                        );
                      }),
                );
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    appLocalizations(context).stillStuckHelpUsAMailAway,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  CustomBtn(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.contactUs);
                    },
                    text: appLocalizations(context).sendAMsg,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
