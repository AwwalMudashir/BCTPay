import 'package:bctpay/globals/index.dart';
import 'package:bctpay/utils/http_with_logging.dart' as http;
import 'package:bctpay/data/models/transactions/payment_link_generate_response.dart';

Future<PaymentLinkGenerateResponse> generatePaymentLink({
  required double amount,
  required String paymentNote,
  required String email,
  required String name,
  required String phoneNo,
  required String ccy,
  required String ref,
}) async {
  final uri = Uri.parse("$baseUrlCore/payment-link/create-payment-link");
  final body = {
    "paymentType": "TRANSFER",
    "ccy": ccy,
    "amount": amount,
    "email": email,
    "mobile": phoneNo,
    "name": name,
    "paymentNote": paymentNote,
    "refNo": ref,
  };

  final headers = await ApiClient.header(useCore: true);
  print("[REQ] POST $uri body=$body headers=$headers");
  final response =
      await http.post(uri, headers: headers, body: json.encode(body));
  print("[RESP] POST $uri status=${response.statusCode} body=${response.body}");

  if (response.statusCode == 200) {
    return PaymentLinkGenerateResponse.fromJson(json.decode(response.body));
  }
  throw ExceptionHandler.handleHttpResponse(response);
}
