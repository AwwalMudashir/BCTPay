import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<InitiateTransactionResponse> checkoutSubscriptionTxn({
  required String amount,
  required String? senderAccountId,
  required String receiverAccountId,
  required String? txnNote,
  required String? transactionRefNumber,
  required String receiverType,
  required String? merchantId,
  required String? senderPaymentType,
  required String? returnUrl,
  required String? cancelUrl,
  required Subscriber? subscription,
  required String? landingUrl,
  required String? cardId,
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
    "coupon_code": "",
    "transaction_ref_number": transactionRefNumber,
    "receiver_type": receiverType, //"BENEFICIARY/REQUESTED/Customer",
    "user_type": "Merchant",
    "merchantId": merchantId, //receiverId
    "transfer_type": "SUBSCRIPTION_PAYMENT",
    "requested_amount": 0,
    // "plan_id": "67777f95f30ba41674067188",
  };
  if (senderPaymentType != null) {
    body["sender_payment_type"] = senderPaymentType;
  }
  if (returnUrl != null) {
    body["return_url"] = returnUrl;
  }
  if (cancelUrl != null) {
    body["cancel_url"] = cancelUrl;
  }
  if (landingUrl != null) {
    body["landing_url"] = landingUrl;
  }
  if (cardId != null) {
    body["CardId"] = cardId; //optional
  }

  ///extra parameter for subscription payment
  body["subscription_id"] = subscription?.id;
  body["subscriber_id"] = subscription?.subscriberId;
  // print(jsonEncode(body));
  //log("🚀Checkout subscription ~ ${jsonEncode(body)}:");
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.checkoutSubscriptionTxn}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    //debugPrint(data.toString());
    return InitiateTransactionResponse.fromMap(data);
  } else {
    throw Exception(response.body);
  }
}
