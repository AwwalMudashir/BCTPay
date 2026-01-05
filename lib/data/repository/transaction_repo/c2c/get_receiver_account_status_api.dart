import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ReceiverAccountStatusResponse> getReceiverAccountStatus({
  required BankAccount beneficiary,
  required String receiverType,
  required String? userType,
}) async {
  var body = {
    "beneficiary_account_id": beneficiary.id,
    "receiver_type": receiverType, //"BENEFICIARY/REQUESTED"/"QR_SCAN",
    "user_type": userType ?? "Customer", //"Customer/Merchant"
  };
  //log("${ApiEndpoint.receiverAccStatus} ${jsonEncode(body)}");
  var response = await http.post(
    Uri.parse("$baseUrlCustomerTxn/${ApiEndpoint.receiverAccStatus}"),
    headers: await ApiClient.header(),
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
   // debugPrint(data.toString());
    return ReceiverAccountStatusResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
