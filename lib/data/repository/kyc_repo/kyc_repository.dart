import 'package:bctpay/data/models/kyc/kyc_response.dart';
import 'package:bctpay/globals/index.dart';
import 'package:http/http.dart' as http;

class SaveKycResult {
  final bool success;
  final String? errorMessage;

  SaveKycResult({required this.success, this.errorMessage});
}

class KycRepository {
  // Then your fetchKycData becomes much cleaner:
  Future<KYCResponse> fetchKycData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrlCore/customer-kyc/fetch'),
        headers: await ApiClient.header(useCore: true),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final kycResponse = KYCResponse.fromJson(data);

        if (kycResponse.responseCode == '000') {
          return kycResponse;
        } else {
          throw Exception(kycResponse.responseMessage ?? 'KYC Error');
        }
      } else {
        throw Exception('Failed to fetch KYC data');
      }
    } catch (e) {
      throw Exception('Failed to fetch KYC data: ${e.toString()}');
    }
  }

  Future<SaveKycResult> saveKycData(KYCItem kycItem) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrlCore/customer-kyc/save'),
        headers: await ApiClient.header(useCore: true),
        body: json.encode(kycItem.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final kycResponse = SubmitKYCResponse.fromJson(data);

        if (kycResponse.code == 200) {
          return SaveKycResult(success: true);
        } else {
          return SaveKycResult(success: false, errorMessage: kycResponse.message);
        }
      } else {
        return SaveKycResult(success: false, errorMessage: 'Failed to save KYC data');
      }
    } catch (e) {
      return SaveKycResult(success: false, errorMessage: 'Failed to save KYC data: ${e.toString()}');
    }
  }
}