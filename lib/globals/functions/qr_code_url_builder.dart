class QRCode {
  static String buildProfileQR(String? id) =>
      "myapp://bctpay?type=customer&id=$id";

  static String buildTxnVerifyQR(String? id) =>
      "myapp://bctpay?type=verify_transaction&id=$id";

  static String buildInvoiceTxnQR(String? id) =>
      "myapp://bctpay?type=invoice_transaction&id=$id";

  static String buildSubscriptionTxnQR(String? id) =>
      "myapp://bctpay?type=subscription_transaction&id=$id";
}
