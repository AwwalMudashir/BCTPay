import 'package:bctpay/globals/index.dart';

Future<bool?> onBackButtonPressed(BuildContext context) {
  var textTheme = Theme.of(context).textTheme;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        appLocalizations(context).doYouReallyWantToExitTheApp,
        style: textTheme.titleMedium,
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context, false),
          child: Container(
            height: height * 0.0433,
            width: width * 0.166,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(width * 0.055),
            ),
            child: Center(
                child: Text(
              appLocalizations(context).no,
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ),
        GestureDetector(
          onTap: () {
            exit(0);
          },
          child: Container(
            height: height * 0.0433,
            width: width * 0.166,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(width * 0.055)),
            child: Center(
                child: Text(
              appLocalizations(context).yes,
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ),
      ],
    ),
  );
}
