// Import the test package and Counter class
import 'package:bctpay/globals/globals.dart';
import 'package:test/test.dart';

void main() {
  test('Subscriber model', () {
    // final subscriber = Subscriber();
    var json = {
      "_id": "1",
    };

    var subscriber = Subscriber.fromJson(json);

    expect(subscriber.id, "1");
  });

  test('Subscription User Acc Model', () {
    // final subscriber = Subscriber();
    var json = {
      "_id": "1",
      "subscriber_user_acc": {
        "_id": "1",
      },
    };

    var subscriber = Subscription.fromJson(json);

    expect(subscriber.subscriberUserAcc?.id, "1");
  });
}
