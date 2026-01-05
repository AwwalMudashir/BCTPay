import 'package:bctpay/globals/index.dart';

bool canUploadKYC(
    {required String? canUpload,
    required KYCStatus? docStatus,
    required KYCStatus? mainKYCStatus}) {
  bool isTrue = (mainKYCStatus != KYCStatus.underReview &&
      ((docStatus == KYCStatus.suspended && canUpload == "true") ||
          docStatus == KYCStatus.expired ||
          docStatus == KYCStatus.rejected ||
          docStatus == KYCStatus.updated ||
          docStatus == KYCStatus.uploaded ||
          docStatus == KYCStatus.pending ||
          docStatus == null));
  return isTrue;
}

///Note: Do not allow user to edit/update while status is approved/ under review 