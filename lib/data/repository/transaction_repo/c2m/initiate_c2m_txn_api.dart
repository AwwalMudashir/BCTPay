import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> initiateC2MTxn({
  required String amount,
  required String? senderAccountId,
  required String receiverAccountId,
  required String? txnNote,
  required String transferType,
  required double requestedAmount,
  required String receiverType,
  required String? userType,
  required String? merchantId,
  required String? requestedId,
  required String? senderPaymentType,
  required String? couponCode,
}) async {
  var body = {
    "receiver_account_id": receiverAccountId,
    "receiver_amount": amount,
    "to_currency": selectedCountry?.currencyCode,
    "sender_account_id": senderAccountId,
    "sender_amount": amount,
    "from_currency": selectedCountry?.currencyCode,
    "exchange_rate": "1",
    "transaction_note": txnNote,
    "coupon_code": couponCode,
    "transaction_ref_number": null,
    "transfer_type": transferType, //"REQUEST TO PAY TRANSFER" /"TRANSFER"
    "requested_amount": requestedAmount,
    "receiver_type": receiverType, //"BENEFICIARY/REQUESTED",
    "user_type": userType, //"Customer/Merchant/BENEFICIARY",
    "merchantId": merchantId //receiverId
  };
  if (requestedId != null) body["requested_id"] = requestedId;
  // if (userType != null) body["user_type"] = userType;
  if (senderPaymentType != null) {
    body["sender_payment_type"] = senderPaymentType;
  }
  // print(jsonEncode(body));
  //log("v6/initiate_c2m_transaction${jsonEncode(body)}");

  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.initiateC2MTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );
  // debugPrint("url -> $baseUrlCustomerTxn/${ApiEndpoint.initiateC2MTxn}");
  // debugPrint("initiateC2MTxn header -> ${await ApiClient.header()}");
  // debugPrint("initiateC2MTxn body -> ${jsonEncode(body)}");
  // debugPrint("initiateC2MTxn response -> ${response.body}");
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
