import 'package:bctpay/globals/index.dart';

class PrimaryAccountHistoryScreen extends StatelessWidget {
  const PrimaryAccountHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryAccountHistoryBloc = ApisBloc(ApisBlocInitialState());
    primaryAccountHistoryBloc.add(PrimaryAccountHistoryEvent());
    return Scaffold(
      appBar:
          CustomAppBar(title: appLocalizations(context).primaryAccountHistory),
      body: BlocBuilder(
        bloc: primaryAccountHistoryBloc,
        builder: (context, state) {
          if (state is PrimaryAccountHistoryState) {
            var accounts = state.value.data?.primaryAcoountList ?? [];
            if (accounts.isEmpty) {
              return Center(
                child: Text(
                  appLocalizations(context).noData,
                ),
              );
            }
            return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) =>
                  PrimaryAccountHistoryListItem(accountData: accounts[index]),
            );
          }
          return Loader();
        },
      ),
    );
  }
}
