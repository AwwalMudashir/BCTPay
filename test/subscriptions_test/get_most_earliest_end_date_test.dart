// Import the test package and Counter class
import 'package:bctpay/globals/globals.dart';
import 'package:test/test.dart';

void main() {
  test('Get most earliest end date of recurring subscription', () {
    final planInfo = [
      PlanInfo(endDate: DateTime(2020, 1, 1)),
      PlanInfo(endDate: DateTime(2023, 9, 1)),
      PlanInfo(endDate: DateTime(2023, 8, 1)),
      PlanInfo(endDate: DateTime(2023, 10, 1)),
      PlanInfo(endDate: DateTime(2023, 1, 1)),
    ];
    var subscriber = Subscriber(planInfo: planInfo);

    final date = getMostEarliestEndDate([subscriber]);

    expect(date, DateTime(2020, 1, 1),
        reason: 'Should return the earliest end date $date');
  });
}
