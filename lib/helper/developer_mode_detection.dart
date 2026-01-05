import 'package:bctpay/globals/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

class DeveloperModeDetector {
  static Future<void> isEnabled(BuildContext context) async {
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    bool developerMode =
        await FlutterJailbreakDetection.developerMode; // android only.
    debugPrint("jailbroken $jailbroken");
    debugPrint("developerMode $developerMode");
    if ((jailbroken || developerMode) && !kReleaseMode) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: Text(appLocalizations(context).bCTPayIsLocked),
            content:
                Text(appLocalizations(context).developerModeDialogDiscription),
          ),
        ),
      );
    }
  }
}
