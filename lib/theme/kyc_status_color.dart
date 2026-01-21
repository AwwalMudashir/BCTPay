import 'package:bctpay/globals/index.dart';

Color getKYCStatusColor(KYCStatus? kycStatus) {
  switch (kycStatus) {
    case KYCStatus.uploaded:
      return Colors.amber;
    case KYCStatus.underReview:
      return Colors.amber;
    case KYCStatus.pending:
      return Colors.red;
    case KYCStatus.approved:
      return Colors.green;
    case KYCStatus.rejected:
      return Colors.red;
    case KYCStatus.updated:
      return Colors.amber;
    case KYCStatus.suspended:
      return Colors.red;
    case KYCStatus.expired:
      return Colors.red;
    default:
      return Colors.red;
  }
}
