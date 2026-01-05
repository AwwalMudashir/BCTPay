// test/transaction/transaction_flow_test.dart

import 'package:bctpay/globals/index.dart';
import 'package:flutter_test/flutter_test.dart';

// Assume these services exist in your app

void main() async {
  final loginNumber = "622123456";
  final loginPwd = "Kamlesh@12345";

  final receiverNumberCustomer = "622141032";
  final receiverNumberMerchant = "622332211";

  late String senderId;
  late String receiverId;
  late String transactionId;

  setUp(() async {
    // Create test accounts
    await dotenv.load(fileName: ".env.development");
    SharedPreferences.setMockInitialValues({});

    selectedCountry = (await getCountryList()).data?.firstOrNull;

    var res = await login(
        loginBody: LoginBody(
      phoneCode: "+224",
      email: loginNumber,
      password: loginPwd,
      otp: "252525",
      loginType: 'PHONE',
      deviceName: '',
      deviceId: '',
      deviceToken: '',
      lastLoginIp: '',
      model: '',
      os: 'Unit Testing',
      osVersion: '',
    ));

    expect(res.code, equals(200), reason: res.message);

    if (res.code == 200) await SharedPreferenceHelper.saveLoginData(res);

    final sender = await getBankAccountList();
    final receiver = await verifyContact(
        receiverPhoneCode: "+224", receiverPhoneNumber: receiverNumberCustomer);

    senderId = sender.data?.firstOrNull?.id ?? "";
    receiverId = receiver.data?.bankInfo?.id ?? "";
  });

  test(
    'C2C Transaction test',
    () async {
      // 1. Initiate transaction
      final txn = await initiateTxnC2C(
        senderAccountId: senderId,
        receiverAccountId: receiverId,
        amount: "100.00",
        txnNote: 'Unit testing',
        transferType: 'CONTACT',
        requestedAmount: 0,
        receiverType: 'CONTACT',
        userType: 'Customer',
        requestedId: '',
        senderPaymentType: 'MOMO',
        couponCode: '',
      );

      transactionId = txn.data?.transactionBctpayRefrenceNumber ?? "";

      expect(txn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      // expect(txn.amount, equals(100.0));
      // expect(txn.from, equals(senderId));
      // expect(txn.to, equals(receiverId));

      // 2. Checkout/confirm transaction
      final finalTxn = await checkoutTxn(
          amount: '100.00',
          senderAccountId: senderId,
          receiverAccountId: receiverId,
          txnNote: 'Unit testing',
          transactionRefNumber: transactionId,
          receiverType: 'CONTACT',
          senderPaymentType: 'MOMO',
          returnUrl: orangeMoneyReturnUrl,
          cancelUrl: orangeMoneyCancelUrl,
          landingUrl: PayWith.card == PayWith.card
              ? cardTxnReturnUrl("<paymentId>")
              : null,
          cardId: '');

      // expect(finalTxn.data?.transactionStepWithSender, equals('success'));
      expect(finalTxn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      expect(finalTxn.data?.transactionStep, equals("SUCCESSFUL"),
          reason: txn.message);
    },
  );

  final receiver = await verifyContact(
      receiverPhoneCode: "+224", receiverPhoneNumber: receiverNumberMerchant);
  receiverId = receiver.data?.bankInfo?.id ?? "";
  test(
    'C2M Transaction test',
    () async {
      // 1. Initiate transaction
      final txn = await initiateTxnC2C(
        senderAccountId: senderId,
        receiverAccountId: receiverId,
        amount: "100.00",
        txnNote: 'Unit testing',
        transferType: 'CONTACT',
        requestedAmount: 0,
        receiverType: 'CONTACT',
        userType: 'Merchant',
        requestedId: '',
        senderPaymentType: 'MOMO',
        couponCode: '',
      );

      transactionId = txn.data?.transactionBctpayRefrenceNumber ?? "";

      expect(txn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      // expect(txn.amount, equals(100.0));
      // expect(txn.from, equals(senderId));
      // expect(txn.to, equals(receiverId));

      // 2. Checkout/confirm transaction
      final finalTxn = await checkoutTxn(
          amount: '100.00',
          senderAccountId: senderId,
          receiverAccountId: receiverId,
          txnNote: 'Unit testing',
          transactionRefNumber: transactionId,
          receiverType: 'CONTACT',
          senderPaymentType: 'MOMO',
          returnUrl: orangeMoneyReturnUrl,
          cancelUrl: orangeMoneyCancelUrl,
          landingUrl: PayWith.card == PayWith.card
              ? cardTxnReturnUrl("<paymentId>")
              : null,
          cardId: '');

      // expect(finalTxn.data?.transactionStepWithSender, equals('success'));
      expect(finalTxn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      expect(finalTxn.data?.transactionStep, equals("SUCCESSFUL"),
          reason: txn.message);
    },
  );

  test(
    'Event Transaction test',
    () async {
      // 1. Initiate transaction
      final txn = await initiateTicketTxn(
          initiateTxnBody: InitiateTxnBody.fromJson({
        "receiver_account_id": "",
        "receiver_amount": null,
        "to_currency": null,
        "sender_account_id": "686cb31e5e9426c8387d3511",
        "sender_amount": null,
        "from_currency": null,
        "exchange_rate": null,
        "transaction_note": "",
        "coupon_code": "",
        "transaction_ref_number": null,
        "transfer_type": null,
        "requested_amount": null,
        "receiver_type": null,
        "user_type": "Merchant",
        "merchantId": "68529cd015e56cfa2892e243",
        "sender_payment_type": null,
        "amount": "1500.00",
        "ticketdata": [
          {
            "slot_id": "68676fb7d4dff56ff8113b28",
            "total_ticket": "1",
            "total_ticket_verified": null,
            "total_ticket_price": "1500.0",
            "attendees": [
              {
                "email": "raj.impetrosys@gmail.com",
                "user_full_name": "John Sie",
                "phone_number": "+224622123456",
                "organisation_name": null
              }
            ],
            "ticket_verification_history": null
          }
        ],
        "event_id": "68676fb7d4dff56ff8113b27",
        "event_ref_number": "#EREF_167E6740E6438C3",
        "live_mode": "false",
        "currency": "GNF",
        "receiverId": "68529cd015e56cfa2892e243"
      }));

      transactionId = txn.data?.transactionBctpayRefrenceNumber ?? "";

      expect(txn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      // expect(txn.amount, equals(100.0));
      // expect(txn.from, equals(senderId));
      // expect(txn.to, equals(receiverId));

      // 2. Checkout/confirm transaction
      final finalTxn = await checkoutTicketTxn(
        checkoutTxnBody: CheckoutTxnBody.fromJson({
          "receiver_account_id": "68550d3b663d2ba778a9ed80",
          "receiver_amount": "1500.00",
          "to_currency": null,
          "sender_account_id": "686cb31e5e9426c8387d3511",
          "sender_amount": "1500.00",
          "from_currency": null,
          "exchange_rate": null,
          "transaction_note": "",
          "coupon_code": null,
          "transaction_ref_number": "TGN-UBOOZR85172855FJROVY",
          "receiver_type": "BENEFICIARY",
          "user_type": null,
          "event_ref_number": "#EREF_167E6740E6438C3",
          "event_id": "68676fb7d4dff56ff8113b27",
          "receiverId": "68529cd015e56cfa2892e243"
        }),
      );

      // expect(finalTxn.data?.transactionStepWithSender, equals('success'));
      expect(finalTxn.code,
          equals(HTTPResponseStatusCodes.momoAccountStatusSuccessCode),
          reason: txn.message);
      expect(finalTxn.data?.transactionStep, equals("SUCCESSFUL"),
          reason: txn.message);
    },
  );
}
