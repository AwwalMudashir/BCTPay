import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

Future<DeleteBeneficiaryResponse> deleteBeneficiary({
  required String beneficiaryId,
}) async {
  var response = await http.post(
    Uri.parse("$baseUrlCustomer/${ApiEndpoint.deleteBeneficiary}"),
    headers: await ApiClient.header(),
    body: jsonEncode({
      "beneficiary_id": beneficiaryId,
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return DeleteBeneficiaryResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}
