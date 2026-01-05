// final LocalAuthentication auth = LocalAuthentication();
// bool dialogShowing = false;

// Future<bool> fingerPrintConfiguration(BuildContext context) async {
//   try {
//     final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
//     final bool isDeviceSupported = await auth.isDeviceSupported();
//     final bool canAuthenticate =
//         canAuthenticateWithBiometrics && isDeviceSupported;
//     // print("canAuthenticateWithBiometrics: $canAuthenticateWithBiometrics");
//     // print("isDeviceSupported: $isDeviceSupported");
//     // print("canAuthenticate: $canAuthenticate");

//     if (canAuthenticate) {
//       // if (kReleaseMode && !dialogShowing) show(context);
//       final bool didAuthenticate = await authenticate(context);
//       if (didAuthenticate) {
//         debugPrint("--------------Auth success");
//         // bool isNotBottomRoute =
//         //     ModalRoute.of(context)?.settings.name != AppRoutes.bottombar;
//         // print(ModalRoute.of(context)?.settings.name);
//         // if (isNotBottomRoute)
//         if (context.mounted) Navigator.pop(context);
//         dialogShowing = false;
//         return true;
//       } else {
//         //Not authenticated
//         dialogShowing = true;
//         return false;
//       }
//     } else {
//       debugPrint("------------------Auth not available");
//       dialogShowing = false;
//       return true;
//       //Auth not available
//     }
//   } catch (e) {
//     debugPrint("------------------$e");
//     //Exception
//     return false;
//   }
// }

// Future<bool> authenticate(BuildContext context) {
//   return auth.authenticate(
//       localizedReason: appLocalizations(context)
//           .enterPhoneScreenLockPatternPINPasswordOrFingerprint,
//       authMessages: [
//         AndroidAuthMessages(
//           signInTitle: appLocalizations(context).unlockBCTPay,
//           // cancelButton: appLocalizations(context).noThanks,
//         ),
//         const IOSAuthMessages(
//             // cancelButton: appLocalizations(context).noThanks,
//             ),
//       ],
//       options: const AuthenticationOptions(
//           stickyAuth: true,
//           useErrorDialogs: true,
//           sensitiveTransaction: false));
// }

// void show(BuildContext context) {
//   dialogShowing = true;
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => PopScope(
//       canPop: false,
//       child: AlertDialog(
//         title: Text(appLocalizations(context).bCTPayIsLocked),
//         content: Text(appLocalizations(context)
//             .authenticationIsRequiredToAccessTheBCTPayApp),
//         actions: [
//           ElevatedButton(
//             child: Text(appLocalizations(context).unlockNow),
//             onPressed: () {
//               authenticate(context).then((didAuthenticate) {
//                 if (didAuthenticate) {
//                   debugPrint("--------------Auth success");
//                   // bool isNotBottomRoute =
//                   //     ModalRoute.of(context)?.settings.name !=
//                   //         AppRoutes.bottombar;
//                   // print(ModalRoute.of(context)?.settings.name);
//                   // if (isNotBottomRoute)
//                   if (context.mounted) Navigator.pop(context);
//                   dialogShowing = false;
//                 } else {
//                   dialogShowing = true;
//                   //Not authenticated
//                 }
//               });

//               // fingerPrintConfiguration(context);
//               // Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     ),
//   );
// }
