import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> initiateTxnC2C({
  required String amount,
  required String? senderAccountId,
  required String receiverAccountId,
  required String? txnNote,
  required String transferType,
  required double requestedAmount,
  required String receiverType,
  required String? userType,
  required String? requestedId,
  required String? senderPaymentType,
  required String? couponCode,
}) async {
  var body = {
    "receiver_account_id": receiverAccountId,
    "receiver_amount": amount,
    "to_currency": selectedCountry?.currencyCode,
    "sender_account_id": senderAccountId ?? "",
    "sender_amount": amount,
    "from_currency": selectedCountry?.currencyCode,
    "exchange_rate": "1",
    "transaction_note": txnNote,
    "coupon_code": couponCode,
    "transaction_ref_number": null,
    "transfer_type": transferType, //"REQUEST TO PAY TRANSFER" /"TRANSFER"
    "requested_amount": requestedAmount,
    "receiver_type": receiverType, //"BENEFICIARY/REQUESTED",
  };
  if (userType != null) body["user_type"] = userType;
  if (requestedId != null) body["requested_id"] = requestedId;
  if (senderPaymentType != null) {
    body["sender_payment_type"] = senderPaymentType;
  }
  log("${ApiEndpoint.initiateTxn} ${jsonEncode(body)}");
  // print(await ApiClient.header());

  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.initiateTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  // debugPrint("url -> $baseUrlCustomerTxn/${ApiEndpoint.initiateTxn}");
  // debugPrint("initiateTxn header -> ${await ApiClient.header()}");
  // debugPrint("initiateTxn body -> ${jsonEncode(body)}");
  // debugPrint("initiateTxn response -> ${response.body}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
