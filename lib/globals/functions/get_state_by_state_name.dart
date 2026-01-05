import 'package:bctpay/globals/index.dart';

Future<StateData?> getStateByStateName(String state) async {
  StateData? matchedState;
  await getStateCitiesList().then((states) {
    var matchedStateList =
        states.data?.where((e) => e.state == state).toList() ?? [];
    if (matchedStateList.isNotEmpty) {
      matchedState = matchedStateList.first;
      return matchedState;
    } else {
      debugPrint("No state exist with name $state");
      return null;
    }
  });
  return matchedState;
}
