import 'package:bctpay/globals/index.dart';

abstract class ApisBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApisBlocInitialEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends ApisBlocEvent {
  final LoginBody? loginBody;

  LoginEvent({
    required this.loginBody,
  });

  @override
  List<Object?> get props => [loginBody];
}

class SendOTPEvent extends ApisBlocEvent {
  final LoginBody? loginBody;

  SendOTPEvent({
    required this.loginBody,
  });

  @override
  List<Object?> get props => [
        loginBody,
      ];
}

class SignUpEvent extends ApisBlocEvent {
  final String email;
  final String phoneCode;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String? lastName;
  final String? address;
  final String? city;
  final String? country;
  final String? pinCode;
  final String? gender;

  SignUpEvent({
    required this.email,
    required this.phoneCode,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.country,
    this.pinCode,
    this.gender,
  });

  @override
  List<Object?> get props => [
        email,
        phoneCode,
        phoneNumber,
        password,
        firstName,
        lastName,
        address,
        city,
        country,
        pinCode,
        gender
      ];
}

class GetProfileEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ApisBlocEvent {
  final String email;
  final String phoneCode;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String country;
  final String state;
  final String pinCode;
  final String? gender;

  UpdateProfileEvent({
    required this.email,
    required this.phoneCode,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.country,
    required this.state,
    required this.pinCode,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        email,
        phoneCode,
        phoneNumber,
        password,
        firstName,
        lastName,
        address,
        city,
        country,
        state,
        pinCode,
        gender
      ];
}

class AddBankAccountEvent extends ApisBlocEvent {
  final String bankcode;
  final String bankname;
  final String accountnumber;
  final String beneficiaryname;
  final String clientId;
  final String accountRole;
  final String walletPhoneNumber;
  final String phoneCode;

  AddBankAccountEvent({
    required this.bankcode,
    required this.bankname,
    required this.accountnumber,
    required this.beneficiaryname,
    required this.clientId,
    required this.accountRole,
    required this.walletPhoneNumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [
        bankcode,
        bankname,
        accountnumber,
        beneficiaryname,
        clientId,
        accountRole,
        walletPhoneNumber,
        phoneCode,
      ];
}

class UpdateBankAccountEvent extends ApisBlocEvent {
  final String accountRole;
  final String accountId;
  final String bankcode;
  final String bankname;
  final String accountnumber;
  final String beneficiaryname;
  final String clientId;
  final String walletPhonenumber;
  final String? phoneCode;

  UpdateBankAccountEvent({
    required this.accountRole,
    required this.accountId,
    required this.bankcode,
    required this.bankname,
    required this.accountnumber,
    required this.beneficiaryname,
    required this.clientId,
    required this.walletPhonenumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [
        accountRole,
        accountId,
        bankcode,
        bankname,
        accountnumber,
        beneficiaryname,
        clientId,
        walletPhonenumber,
        phoneCode
      ];
}

class CheckBankBalanceEvent extends ApisBlocEvent {
  final String accountId;

  CheckBankBalanceEvent({
    required this.accountId,
  });

  @override
  List<Object?> get props => [accountId];
}

class GetBankAccountListEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class PrimaryAccountHistoryEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class DeleteBankAccountEvent extends ApisBlocEvent {
  final BankAccount account;

  DeleteBankAccountEvent({
    required this.account,
  });

  @override
  List<Object?> get props => [account];
}

class SetPrimaryAccountEvent extends ApisBlocEvent {
  final BankAccount account;

  SetPrimaryAccountEvent({
    required this.account,
  });

  @override
  List<Object?> get props => [account];
}

class SetActiveAccountEvent extends ApisBlocEvent {
  final BankAccount account;

  SetActiveAccountEvent({
    required this.account,
  });

  @override
  List<Object?> get props => [account];
}

class RecentTransactionsEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class TransactionHistoryEvent extends ApisBlocEvent {
  final int page;
  final int limit;
  final bool fromAnotherScreen;
  final TxnFilterModel? filter;

  TransactionHistoryEvent({
    required this.page,
    required this.limit,
    this.fromAnotherScreen = true,
    this.filter,
  });

  @override
  List<Object?> get props => [page, limit, fromAnotherScreen, filter];
}

class CustomerSettingEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCustomerSettingEvent extends ApisBlocEvent {
  final String? language;
  final String? currency;
  final String? currencySymbol;
  final String? themeColor;
  final String? timezone;

  UpdateCustomerSettingEvent(
      {this.language,
      this.currency,
      this.currencySymbol,
      this.themeColor,
      this.timezone});

  @override
  List<Object?> get props =>
      [language, currency, currencySymbol, themeColor, timezone];
}

class CountryListEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class CurrencyListEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class ProviderListEvent extends ApisBlocEvent {
  final String? providerCodes;
  final String? countryIsos;
  final String? regionCodes;
  final String? accountNumber;
  final String? benefits;
  final String? skuCodes;

  ProviderListEvent(
      {required this.providerCodes,
      required this.countryIsos,
      required this.regionCodes,
      required this.accountNumber,
      required this.benefits,
      required this.skuCodes});

  @override
  List<Object?> get props => [
        providerCodes,
        countryIsos,
        regionCodes,
        accountNumber,
        benefits,
        skuCodes
      ];
}

class RegionListEvent extends ApisBlocEvent {
  final String countryIsos;

  RegionListEvent({required this.countryIsos});

  @override
  List<Object?> get props => [countryIsos];
}

class ProductListEvent extends ApisBlocEvent {
  final String regionCodes;
  final String accountNumber;
  final String providerCode;
  final String benefits;

  ProductListEvent({
    required this.regionCodes,
    required this.accountNumber,
    required this.providerCode,
    required this.benefits,
  });

  @override
  List<Object?> get props =>
      [regionCodes, accountNumber, providerCode, benefits];
}

class ProductStatusEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetAccountLookupEvent extends ApisBlocEvent {
  final String accountNumber;

  GetAccountLookupEvent({required this.accountNumber});

  @override
  List<Object?> get props => [accountNumber];
}

class BillPaymentEvent extends ApisBlocEvent {
  final String paymentwith;
  final double amount;
  final String customerPhone;
  final String skuCode;
  final String sendCurrencyIso;
  final String accountNumber;

  BillPaymentEvent(
      {required this.paymentwith,
      required this.amount,
      required this.customerPhone,
      required this.skuCode,
      required this.sendCurrencyIso,
      required this.accountNumber});

  @override
  List<Object?> get props => [
        paymentwith,
        amount,
        customerPhone,
        skuCode,
        sendCurrencyIso,
        accountNumber
      ];
}

class InitiateTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String transferType;
  final double requestedAmount;
  final String receiverType;
  final String? userType;
  final String? requestedId;
  final String? senderPaymentType;
  final String? couponCode;

  InitiateTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transferType,
    required this.requestedAmount,
    required this.receiverType,
    required this.userType,
    required this.requestedId,
    this.senderPaymentType,
    required this.couponCode,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transferType,
        requestedAmount,
        receiverType,
        userType,
        requestedId,
        senderPaymentType,
        couponCode
      ];
}

class InitiateVerifyOMTxnEvent extends ApisBlocEvent {
  final String phoneCode;
  final String phoneNumber;
  final String returnUrl;
  final String cancelUrl;

  InitiateVerifyOMTxnEvent(
      {required this.phoneCode,
      required this.phoneNumber,
      required this.returnUrl,
      required this.cancelUrl});

  @override
  List<Object?> get props => [
        phoneCode,
        phoneNumber,
        returnUrl,
        cancelUrl,
      ];
}

class GetOrangeTxnStatusEvent extends ApisBlocEvent {
  final String? orderId;

  GetOrangeTxnStatusEvent({
    required this.orderId,
  });

  @override
  List<Object?> get props => [
        orderId,
      ];
}

// To check status of momo account
class CheckAccountNumberStatusEvent extends ApisBlocEvent {
  final String phoneCode;
  final String accountNumber;
  final String institutionName;
  final String accountType;

  CheckAccountNumberStatusEvent({
    required this.phoneCode,
    required this.accountNumber,
    required this.institutionName,
    required this.accountType,
  });

  @override
  List<Object?> get props =>
      [phoneCode, accountNumber, institutionName, accountType];
}

class InitiateC2MTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String transferType;
  final double requestedAmount;
  final String receiverType;
  final String? userType;
  final String? merchantId;
  final String? requestedId;
  final String? senderPaymentType;
  final String? couponCode;

  InitiateC2MTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transferType,
    required this.requestedAmount,
    required this.receiverType,
    required this.userType,
    required this.merchantId,
    required this.requestedId,
    this.senderPaymentType,
    required this.couponCode,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transferType,
        requestedAmount,
        receiverType,
        userType,
        requestedId,
        senderPaymentType,
        couponCode
      ];
}

class InitiateC2MInvoiceTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String transferType;
  final double requestedAmount;
  final String receiverType;
  final String? userType;
  final String? merchantId;
  final String? requestedId;
  final String? senderPaymentType;
  final String? invoiceNumber;
  final String? couponCode;

  InitiateC2MInvoiceTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transferType,
    required this.requestedAmount,
    required this.receiverType,
    required this.userType,
    required this.merchantId,
    required this.requestedId,
    this.senderPaymentType,
    required this.invoiceNumber,
    required this.couponCode,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transferType,
        requestedAmount,
        receiverType,
        userType,
        requestedId,
        senderPaymentType,
        invoiceNumber,
        couponCode
      ];
}

class InitiateTicketTxnEvent extends ApisBlocEvent {
  final InitiateTxnBody body;

  InitiateTicketTxnEvent({required this.body});

  @override
  List<Object?> get props => [body];
}

class InitiateSubscriptionTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String transferType;
  final double requestedAmount;
  final String receiverType;
  final String? userType;
  final String? merchantId;
  final String? requestedId;
  final String? senderPaymentType;
  final Subscriber? subscription;
  final String? couponCode;

  InitiateSubscriptionTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transferType,
    required this.requestedAmount,
    required this.receiverType,
    required this.userType,
    required this.merchantId,
    required this.requestedId,
    this.senderPaymentType,
    required this.subscription,
    required this.couponCode,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transferType,
        requestedAmount,
        receiverType,
        userType,
        requestedId,
        senderPaymentType,
        subscription,
        couponCode
      ];
}

class CheckoutTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String? transactionRefNumber;
  final String receiverType;
  final String? senderPaymentType;
  final String? returnUrl;
  final String? cancelUrl;
  final String? landingUrl;
  final String? cardId;
  final bool isMOMOTxn;
  final bool isTransfer;

  CheckoutTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transactionRefNumber,
    required this.receiverType,
    this.senderPaymentType,
    this.returnUrl,
    this.cancelUrl,
    this.landingUrl,
    this.cardId,
    this.isMOMOTxn = false,
    this.isTransfer = false,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transactionRefNumber,
        receiverType,
        senderPaymentType,
        returnUrl,
        cancelUrl,
        landingUrl,
        cardId,
        isMOMOTxn,
        isTransfer,
      ];
}

class CheckoutEFTTxnEvent extends ApisBlocEvent {
  final String orderId;

  CheckoutEFTTxnEvent({
    required this.orderId,
  });

  @override
  List<Object?> get props => [
        orderId,
      ];
}

class CheckoutC2MTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String? transactionRefNumber;
  final String receiverType;
  final String? merchantId;
  final String? senderPaymentType;
  final String? returnUrl;
  final String? cancelUrl;
  final String? landingUrl;
  final String? cardId;
  final bool isMOMOTxn;
  final bool isTransfer;

  CheckoutC2MTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transactionRefNumber,
    required this.receiverType,
    required this.merchantId,
    this.senderPaymentType,
    this.returnUrl,
    this.cancelUrl,
    this.landingUrl,
    this.cardId,
    this.isMOMOTxn = false,
    this.isTransfer = false,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transactionRefNumber,
        receiverType,
        senderPaymentType,
        returnUrl,
        cancelUrl,
        cardId,
        landingUrl,
        isMOMOTxn,
        isTransfer,
      ];
}

class CheckoutC2MInvoiceTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String? transactionRefNumber;
  final String receiverType;
  final String? merchantId;
  final String? senderPaymentType;
  final String? returnUrl;
  final String? cancelUrl;
  final String? invoiceNumber;
  final String? landingUrl;
  final String? cardId;
  final bool isMOMOTxn;
  final bool isInvoicePay;

  CheckoutC2MInvoiceTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transactionRefNumber,
    required this.receiverType,
    required this.merchantId,
    this.senderPaymentType,
    this.returnUrl,
    this.cancelUrl,
    required this.invoiceNumber,
    this.landingUrl,
    this.cardId,
    this.isMOMOTxn = false,
    this.isInvoicePay = false,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transactionRefNumber,
        receiverType,
        senderPaymentType,
        returnUrl,
        cancelUrl,
        invoiceNumber,
        cardId,
        landingUrl,
        isMOMOTxn,
        isInvoicePay,
      ];
}

class CheckoutTicketTxnEvent extends ApisBlocEvent {
  final CheckoutTxnBody body;
  final bool isMOMOTxn;
  final bool isTicketPay;

  CheckoutTicketTxnEvent({
    required this.body,
    this.isMOMOTxn = false,
    this.isTicketPay = false,
  });

  @override
  List<Object?> get props => [
        body,
        isMOMOTxn,
        isTicketPay,
      ];
}

class CheckoutSubscriptionTxnEvent extends ApisBlocEvent {
  final String amount;
  final String? senderAccountId;
  final String receiverAccountId;
  final String? txnNote;
  final String? transactionRefNumber;
  final String receiverType;
  final String? merchantId;
  final String? senderPaymentType;
  final String? returnUrl;
  final String? cancelUrl;
  final Subscriber? subscription;
  final String? landingUrl;
  final String? cardId;
  final bool isMOMOTxn;
  final bool isSubscriptionPay;

  CheckoutSubscriptionTxnEvent({
    required this.amount,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.txnNote,
    required this.transactionRefNumber,
    required this.receiverType,
    required this.merchantId,
    this.senderPaymentType,
    this.returnUrl,
    this.cancelUrl,
    required this.subscription,
    this.landingUrl,
    this.cardId,
    this.isMOMOTxn = false,
    this.isSubscriptionPay = false,
  });

  @override
  List<Object?> get props => [
        amount,
        senderAccountId,
        receiverAccountId,
        txnNote,
        transactionRefNumber,
        receiverType,
        senderPaymentType,
        returnUrl,
        cancelUrl,
        subscription,
        cardId,
        landingUrl,
        isMOMOTxn,
        isSubscriptionPay,
      ];
}

class CheckoutVerifyOMTxnEvent extends ApisBlocEvent {
  final String orderId;

  CheckoutVerifyOMTxnEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

///Second checkout event for all three invoice, subscription and ticket payment
///If sender is MOMO
class CheckoutC2MomoTxnEvent extends ApisBlocEvent {
  final String orderId;
  final bool showLoader;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isTicketPay;
  final bool isTransfer;

  CheckoutC2MomoTxnEvent({
    required this.orderId,
    this.showLoader = false,
    this.isInvoicePay = false,
    this.isSubscriptionPay = false,
    this.isTicketPay = false,
    this.isTransfer = false,
  });

  @override
  List<Object?> get props => [
        orderId,
        showLoader,
        isInvoicePay,
        isSubscriptionPay,
        isTicketPay,
        isTransfer,
      ];
}

class RecentBillTxnEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordEvent extends ApisBlocEvent {
  final String email;

  ForgetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ForgetVerifyOTPEvent extends ApisBlocEvent {
  final String emailOTP;

  ForgetVerifyOTPEvent({required this.emailOTP});

  @override
  List<Object?> get props => [emailOTP];
}

class ForgetResetPasswordEvent extends ApisBlocEvent {
  final String newPassword;
  final String emailOTP;

  ForgetResetPasswordEvent({required this.emailOTP, required this.newPassword});

  @override
  List<Object?> get props => [newPassword, emailOTP];
}

class ChangePasswordEvent extends ApisBlocEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class AddBeneficiaryEvent extends ApisBlocEvent {
  final String bankcode;
  final String bankname;
  final String accountnumber;
  final String beneficiaryname;
  final String clientId;
  final String accountRole;
  final String walletPhoneNumber;
  final String phoneCode;

  AddBeneficiaryEvent({
    required this.bankcode,
    required this.bankname,
    required this.accountnumber,
    required this.beneficiaryname,
    required this.clientId,
    required this.accountRole,
    required this.walletPhoneNumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [
        bankcode,
        bankname,
        accountnumber,
        beneficiaryname,
        clientId,
        accountRole,
        walletPhoneNumber,
        phoneCode,
      ];
}

class UpdateBeneficiaryEvent extends ApisBlocEvent {
  final String accountRole;
  final String accountId;
  final String bankcode;
  final String bankname;
  final String accountnumber;
  final String beneficiaryname;
  final String clientId;
  final String walletPhonenumber;
  final String? phoneCode;

  UpdateBeneficiaryEvent({
    required this.accountRole,
    required this.accountId,
    required this.bankcode,
    required this.bankname,
    required this.accountnumber,
    required this.beneficiaryname,
    required this.clientId,
    required this.walletPhonenumber,
    required this.phoneCode,
  });

  @override
  List<Object?> get props => [
        accountRole,
        accountId,
        bankcode,
        bankname,
        accountnumber,
        beneficiaryname,
        clientId,
        walletPhonenumber,
        phoneCode
      ];
}

class GetBeneficiaryListEvent extends ApisBlocEvent {
  final int limit;
  final int page;

  GetBeneficiaryListEvent({required this.limit, required this.page});

  @override
  List<Object?> get props => [limit, page];
}

class DeleteBeneficiaryEvent extends ApisBlocEvent {
  final String beneficiaryId;

  DeleteBeneficiaryEvent({required this.beneficiaryId});

  @override
  List<Object?> get props => [beneficiaryId];
}

class GetBCTPaySettingDetailsEvent extends ApisBlocEvent {
  final String countryId;

  GetBCTPaySettingDetailsEvent({required this.countryId});

  @override
  List<Object?> get props => [countryId];
}

class UploadProfilePicEvent extends ApisBlocEvent {
  final XFile profilePic;

  UploadProfilePicEvent({required this.profilePic});

  @override
  List<Object?> get props => [profilePic];
}

class KYCSubmitEvent extends ApisBlocEvent {
  final KYCData? oldKYCData;

  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final List<IdentityProof>? addressProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? pinCode;
  final String? city;
  final String? state;
  final String? address;

  final String? line1;
  final String? line2;
  final String? landmark;

  KYCSubmitEvent({
    this.oldKYCData,
    required this.userName,
    required this.dob,
    required this.identityProofList,
    required this.addressProofList,
    this.selfieImage,
    required this.phoneCode,
    required this.phoneNumber,
    required this.email,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.address,
    required this.line1,
    required this.line2,
    required this.landmark,
  });

  @override
  List<Object?> get props => [
        oldKYCData,
        userName,
        dob,
        identityProofList,
        addressProofList,
        selfieImage,
        phoneCode,
        phoneNumber,
        email,
        pinCode,
        city,
        state,
        address,
        line1,
        line2,
        landmark,
      ];
}

class KYCUpdateEvent extends ApisBlocEvent {
  final KYCData? oldKYCData;
  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final List<IdentityProof>? addressProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? pinCode;
  final String? city;
  final String? state;
  final String? address;

  KYCUpdateEvent({
    this.oldKYCData,
    required this.userName,
    required this.dob,
    required this.identityProofList,
    required this.addressProofList,
    this.selfieImage,
    required this.phoneCode,
    required this.phoneNumber,
    required this.email,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.address,
  });

  @override
  List<Object?> get props => [
        oldKYCData,
        userName,
        dob,
        identityProofList,
        addressProofList,
        selfieImage,
        phoneCode,
        phoneNumber,
        email,
        pinCode,
        city,
        state,
        address,
      ];
}

class KYCUpdatePhotoProofEvent extends ApisBlocEvent {
  final KYCData? oldKYCData;
  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final List<IdentityProof>? addressProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? pinCode;
  final String? city;
  final String? state;
  final String? address;

  KYCUpdatePhotoProofEvent({
    this.oldKYCData,
    required this.userName,
    required this.dob,
    required this.identityProofList,
    required this.addressProofList,
    this.selfieImage,
    required this.phoneCode,
    required this.phoneNumber,
    required this.email,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.address,
  });

  @override
  List<Object?> get props => [
        oldKYCData,
        userName,
        dob,
        identityProofList,
        addressProofList,
        selfieImage,
        phoneCode,
        phoneNumber,
        email,
        pinCode,
        city,
        state,
        address,
      ];
}

class KYCUpdateIdProofEvent extends ApisBlocEvent {
  final KYCData? oldKYCData;
  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final List<IdentityProof>? addressProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? pinCode;
  final String? city;
  final String? state;
  final String? address;

  KYCUpdateIdProofEvent({
    this.oldKYCData,
    required this.userName,
    required this.dob,
    required this.identityProofList,
    required this.addressProofList,
    this.selfieImage,
    required this.phoneCode,
    required this.phoneNumber,
    required this.email,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.address,
  });

  @override
  List<Object?> get props => [
        oldKYCData,
        userName,
        dob,
        identityProofList,
        addressProofList,
        selfieImage,
        phoneCode,
        phoneNumber,
        email,
        pinCode,
        city,
        state,
        address,
      ];
}

class KYCUpdateAddressProofEvent extends ApisBlocEvent {
  final KYCData? oldKYCData;
  final String? userName;
  final String? dob;
  final List<IdentityProof>? identityProofList;
  final List<IdentityProof>? addressProofList;
  final XFile? selfieImage;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? pinCode;
  final String? city;
  final String? state;
  final String? address;
  final String? line1;
  final String? line2;
  final String? landmark;

  KYCUpdateAddressProofEvent({
    this.oldKYCData,
    required this.userName,
    required this.dob,
    required this.identityProofList,
    required this.addressProofList,
    this.selfieImage,
    required this.phoneCode,
    required this.phoneNumber,
    required this.email,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.address,
    required this.line1,
    required this.line2,
    required this.landmark,
  });

  @override
  List<Object?> get props => [
        oldKYCData,
        userName,
        dob,
        identityProofList,
        addressProofList,
        selfieImage,
        phoneCode,
        phoneNumber,
        email,
        pinCode,
        city,
        state,
        address,
        line1,
        line2,
        landmark
      ];
}

class DeleteKYCIdDocEvent extends ApisBlocEvent {
  final IdentityProof identityProof;
  final KYCData? kycData;
  final bool isFile;

  DeleteKYCIdDocEvent({
    required this.identityProof,
    required this.kycData,
    this.isFile = true,
  });

  @override
  List<Object?> get props => [
        identityProof,
        kycData,
        isFile,
      ];
}

class DeleteKYCAddressDocEvent extends ApisBlocEvent {
  final IdentityProof identityProof;
  final KYCData? kycData;
  final bool isFile;

  DeleteKYCAddressDocEvent({
    required this.identityProof,
    required this.kycData,
    this.isFile = true,
  });

  @override
  List<Object?> get props => [
        identityProof,
        kycData,
        isFile,
      ];
}

class GetKYCDetailEvent extends ApisBlocEvent {
  final bool showPreview;

  GetKYCDetailEvent({this.showPreview = false});

  @override
  List<Object?> get props => [showPreview];
}

class GetKYCDocsListEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetKYCHistoryEvent extends ApisBlocEvent {
  final int limit;
  final int page;

  GetKYCHistoryEvent({required this.limit, required this.page});

  @override
  List<Object?> get props => [limit, page];
}

class GetBanksListEvent extends ApisBlocEvent {
  final String accountType;

  GetBanksListEvent({required this.accountType});

  @override
  List<Object?> get props => [accountType];
}

class GetNotificationListEvent extends ApisBlocEvent {
  final int limit;
  final int page;
  final bool clear;

  GetNotificationListEvent(
      {required this.limit, required this.page, this.clear = false});

  @override
  List<Object?> get props => [limit, page, clear];
}

class ReadNotificationEvent extends ApisBlocEvent {
  final List<String>? notificationId;
  final bool readAll;

  ReadNotificationEvent({
    this.notificationId,
    this.readAll = false,
  });

  @override
  List<Object?> get props => [notificationId, readAll];
}

class BannersListEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  BannersListEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class BannersList2Event extends ApisBlocEvent {
  final int page;
  final int limit;

  BannersList2Event({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class ClearNotificationsEvent extends ApisBlocEvent {
  final List<String>? notificationIds;
  final bool clearAll;

  ClearNotificationsEvent({
    this.notificationIds,
    this.clearAll = false,
  });

  @override
  List<Object?> get props => [notificationIds, clearAll];
}

class ContactUsEvent extends ApisBlocEvent {
  final String fullname;
  final String email;
  final String phonenumber;
  final String message;
  final String type;
  final List<XFile?> queryImage;

  ContactUsEvent({
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.message,
    required this.type,
    required this.queryImage,
  });

  @override
  List<Object?> get props => [
        fullname,
        email,
        phonenumber,
        message,
        type,
        queryImage,
      ];
}

class CheckBeneficiaryAccountStatusEvent extends ApisBlocEvent {
  final BankAccount beneficiary;
  final PaymentRequest? request;
  final String receiverType;
  final String? userType;
  final Invoice? invoiceData;

  CheckBeneficiaryAccountStatusEvent(
      {required this.beneficiary,
      this.request,
      required this.receiverType,
      this.userType,
      this.invoiceData});

  @override
  List<Object?> get props => [beneficiary, receiverType, invoiceData];
}

class CouponListEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class RequestToPayEvent extends ApisBlocEvent {
  final String amount;
  final String receiverAccountId;
  final String txnNote;
  final String requestReceiverPhoneCode;
  final String requestReceiverPhoneNumber;

  RequestToPayEvent(
      {required this.amount,
      required this.receiverAccountId,
      required this.txnNote,
      required this.requestReceiverPhoneCode,
      required this.requestReceiverPhoneNumber});

  @override
  List<Object?> get props => [
        amount,
        receiverAccountId,
        txnNote,
        requestReceiverPhoneCode,
        requestReceiverPhoneNumber
      ];
}

class PaymentRequestsByMeEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  PaymentRequestsByMeEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class PaymentRequestsByOtherEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  PaymentRequestsByOtherEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class OpenExpressAccountEvent extends ApisBlocEvent {
  final OpenExpressAccountBody body;

  OpenExpressAccountEvent({
    required this.body,
  });

  @override
  List<Object?> get props => [body];
}

class VerifyQREvent extends ApisBlocEvent {
  final String qrCode;
  final String type;

  VerifyQREvent({
    required this.qrCode,
    required this.type,
  });

  @override
  List<Object?> get props => [qrCode, type];
}

class VerifyTxnQREvent extends ApisBlocEvent {
  final String qrCode;
  final String type;

  VerifyTxnQREvent({
    required this.qrCode,
    required this.type,
  });

  @override
  List<Object?> get props => [qrCode, type];
}

class InvoiceListEvent extends ApisBlocEvent {
  final int page;
  final int limit;
  final InvoiceFilterModel? filter;
  final bool? fromAnotherScreen;

  InvoiceListEvent({
    required this.page,
    required this.limit,
    this.filter,
    this.fromAnotherScreen,
  });

  @override
  List<Object?> get props => [page, limit, filter, fromAnotherScreen];
}

class InvoiceDetailEvent extends ApisBlocEvent {
  final String invoiceNumber;

  InvoiceDetailEvent({
    required this.invoiceNumber,
  });

  @override
  List<Object?> get props => [
        invoiceNumber,
      ];
}

class VerifyContactEvent extends ApisBlocEvent {
  final String receiverPhoneCode;
  final String receiverPhoneNumber;

  VerifyContactEvent({
    required this.receiverPhoneCode,
    required this.receiverPhoneNumber,
  });

  @override
  List<Object?> get props => [receiverPhoneCode, receiverPhoneNumber];
}

class CheckContactExistEvent extends ApisBlocEvent {
  final String receiverPhoneCode;
  final String receiverPhoneNumber;

  CheckContactExistEvent({
    required this.receiverPhoneCode,
    required this.receiverPhoneNumber,
  });

  @override
  List<Object?> get props => [receiverPhoneCode, receiverPhoneNumber];
}

class GetAccountLimitEvent extends ApisBlocEvent {}

class ResendVerificationLinkEvent extends ApisBlocEvent {
  final String phoneCode;
  final String phoneNumber;

  ResendVerificationLinkEvent({
    required this.phoneCode,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneCode, phoneNumber];
}

class GetQueriesEvent extends ApisBlocEvent {
  final int page;
  final int limit;
  final QueryFilterModel? filter;
  final bool? fromAnotherScreen;

  GetQueriesEvent({
    required this.page,
    required this.limit,
    this.filter,
    this.fromAnotherScreen,
  });

  @override
  List<Object?> get props => [page, limit, filter, fromAnotherScreen];
}

class RejectPaymentRequestEvent extends ApisBlocEvent {
  final String requestId;

  RejectPaymentRequestEvent({
    required this.requestId,
  });

  @override
  List<Object?> get props => [requestId];
}

class GetPaymentRequestByIdEvent extends ApisBlocEvent {
  final String requestId;

  GetPaymentRequestByIdEvent({
    required this.requestId,
  });

  @override
  List<Object?> get props => [requestId];
}

class GetOMChargesEvent extends ApisBlocEvent {
  final String token;
  final String msisdnNumber;
  final String orderId;

  GetOMChargesEvent({
    required this.token,
    required this.msisdnNumber,
    required this.orderId,
  });

  @override
  List<Object?> get props => [token, msisdnNumber, orderId];
}

class FinalizeOMPaymentEvent extends ApisBlocEvent {
  final String token;
  final String msisdnNumber;
  final String otp;
  final String orderId;

  FinalizeOMPaymentEvent({
    required this.token,
    required this.msisdnNumber,
    required this.otp,
    required this.orderId,
  });

  @override
  List<Object?> get props => [token, msisdnNumber, otp, orderId];
}

class CheckoutOMTicketPaymentEvent extends ApisBlocEvent {
  final String orderId;

  CheckoutOMTicketPaymentEvent({
    required this.orderId,
  });

  @override
  List<Object?> get props => [orderId];
}

class CancelOMTxnEvent extends ApisBlocEvent {
  final String token;
  final String orderId;

  CancelOMTxnEvent({
    required this.token,
    required this.orderId,
  });

  @override
  List<Object?> get props => [token, orderId];
}

class GetSubscriptionsEvent extends ApisBlocEvent {
  final int page;
  final int limit;
  final SubscriptionFilterModel? filter;
  final bool? fromAnotherScreen;

  GetSubscriptionsEvent({
    required this.page,
    required this.limit,
    this.filter,
    this.fromAnotherScreen,
  });

  @override
  List<Object?> get props => [page, limit, filter, fromAnotherScreen];
}

class GetSubscriptionByIdEvent extends ApisBlocEvent {
  final String id;

  GetSubscriptionByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetSubscriptionDetailEvent extends ApisBlocEvent {
  final String id;

  GetSubscriptionDetailEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetSubscribersEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  GetSubscribersEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class GetTypeOfQueriesEvent extends ApisBlocEvent {}

class QueryDetailEvent extends ApisBlocEvent {
  final String queryId;

  QueryDetailEvent({required this.queryId});

  @override
  List<Object?> get props => [queryId];
}

class CloseQueryEvent extends ApisBlocEvent {
  final String queryId;

  CloseQueryEvent({required this.queryId});

  @override
  List<Object?> get props => [queryId];
}

class ReplyQueryEvent extends ApisBlocEvent {
  final String queryId;
  final String message;
  final List<XFile?> queryImage;

  ReplyQueryEvent({
    required this.queryId,
    required this.message,
    required this.queryImage,
  });

  @override
  List<Object?> get props => [queryId, message, queryImage];
}

class GetStateCitiesEvent extends ApisBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetCardsListEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  GetCardsListEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}

class GetThirdPartyListEvent extends ApisBlocEvent {}

class DeleteCustomerAccountEvent extends ApisBlocEvent {}

class GetFAQsEvent extends ApisBlocEvent {
  final int page;
  final int limit;

  GetFAQsEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
