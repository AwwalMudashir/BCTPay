class Recharge {
  final String customerName;
  final String provider;
  final String mobileNo;
  final String image;
  final String countryCode;
  final String resionCode;
  // final String amount;
  // final String rechargeDate;
  // final String expiryDate;
  final String desc;

  var payerCurrencySymbol = "\$";

  DateTime createdAt = DateTime.now();

  var payerAmount = 500;

  Recharge({
    required this.customerName,
    required this.provider,
    required this.mobileNo,
    required this.image,
    required this.desc,
    required this.countryCode,
    required this.resionCode,
  });
}
