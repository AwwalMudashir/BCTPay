import 'package:bctpay/globals/index.dart';

class MyBillsAndSubscriptionsScreen extends StatefulWidget {
  const MyBillsAndSubscriptionsScreen({super.key});

  @override
  State<MyBillsAndSubscriptionsScreen> createState() =>
      _MyBillsAndSubscriptionsScreenState();
}

class _MyBillsAndSubscriptionsScreenState
    extends State<MyBillsAndSubscriptionsScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations(context).billsNSubscriptions,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: themeColorHeader,
            child: TabBar(
              indicatorColor: themeLogoColorOrange,
              controller: tabController,
              tabs: [
                Text(
                  appLocalizations(context).myBills,
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  appLocalizations(context).mySubscriptions,
                  style: textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [InvoiceList(), MySubscriptions()],
            ),
          )
        ],
      ),
    );
  }
}
