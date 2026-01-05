import 'package:bctpay/data/models/subscriptions/subscriptions_response.dart';
import 'package:bctpay/views/subscription/subscription_detail.dart';
import 'package:test/test.dart';

void main() {
  test('Calculate total payable amount', () {
    var plan = PlanInfo(
        planPrice: "1000",
        lateFeeAmount: "100",
        discountValue: "400",
        endDate: DateTime.now().subtract(Duration(days: 2)));
    var totalAmount = getTotalPayableAmount(plan);
    expect(totalAmount, 400.0);
  });
}
