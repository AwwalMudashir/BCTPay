// import 'package:bct_pay_merchant/src/utils/index.dart';
// import 'package:bctpay/globals/index.dart';
// import 'package:open_file/open_file.dart';
// import 'package:pdf/widgets.dart';

// class SaveDownloadPdf {
//   static Future<File> saveDocument({
//     required String name,
//     required Document pdf,
//   }) async {
//     final bytes = await pdf.save();
//     File file;

//     // Platform.isIOS comes from dart:io
//     if (Platform.isIOS) {
//       final dir = await getApplicationDocumentsDirectory();
//       file = File('${dir.path}/bct_merchant_qr_$name');
//     } else {
//       final dir = await getExternalStorageDirectory();
//       debugPrint("dir path ${dir?.path}/bct_merchant_qr_$name");
//       file = File('${dir?.path}/bct_merchant_qr_$name');
//     }

//     await file.writeAsBytes(bytes).then((value) => debugPrint("hurray!!"));

//     return file;
//   }

// // use open file package if required
//   static Future openFile(File file) async {
//     final url = file.path;

//     debugPrint("open file path ${file.path}");
//     await OpenFile.open(url);
//   }
// }
