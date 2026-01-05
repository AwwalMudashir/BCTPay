import 'package:bctpay/globals/index.dart';

class DocumentData {
  final List<XFile?>? documentFiles;
  final String documentId;
  final String fullName;
  final String dob;
  final DateTimeRange? validity;

  DocumentData(
      {required this.documentFiles,
      required this.documentId,
      required this.fullName,
      required this.dob,
      required this.validity});
}
