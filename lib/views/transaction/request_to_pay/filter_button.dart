import 'package:bctpay/lib.dart';

class FilterBtn extends StatelessWidget {
  final SelectionBloc bloc;
  final String? filterString;

  const FilterBtn({super.key, required this.bloc, required this.filterString});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.filter_list,
        color: filterString?.isNotEmpty ?? false ? Colors.blue : Colors.black,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: RadioListTile(
          groupValue: filterString,
          value: "",
          title: Text(appLocalizations(context).all),
          onChanged: (v) {
            bloc.add(SelectStringEvent(v));
            Navigator.pop(context);
          },
        )),
        PopupMenuItem(
            child: RadioListTile(
          groupValue: filterString,
          value: "1",
          title: Text(appLocalizations(context).paid),
          onChanged: (v) {
            bloc.add(SelectStringEvent(v));
            Navigator.pop(context);
          },
        )),
        PopupMenuItem(
            child: RadioListTile(
          groupValue: filterString,
          value: "0",
          title: Text(appLocalizations(context).unpaid),
          onChanged: (v) {
            bloc.add(SelectStringEvent(v));
            Navigator.pop(context);
          },
        )),
        PopupMenuItem(
            child: RadioListTile(
          groupValue: filterString,
          value: "2",
          title: Text(appLocalizations(context).rejected),
          onChanged: (v) {
            bloc.add(SelectStringEvent(v));
            Navigator.pop(context);
          },
        ))
      ],
    );
  }
}
