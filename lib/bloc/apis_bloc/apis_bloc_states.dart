import 'package:bctpay/globals/index.dart';

abstract class ApisBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ApisBlocInitialState extends ApisBlocState {
  @override
  List<Object?> get props => [];
}

class ApisBlocLoadingState extends ApisBlocState {
  @override
  List<Object?> get props => [];
}

class ApisBlocErrorState extends ApisBlocState {
  final String message;

  ApisBlocErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoginState extends ApisBlocState {
  final LoginResponse value;

  LoginState(this.value);

  @override
  List<Object?> get props => [value];
}

class SendOTPState extends ApisBlocState {
  final Response value;

  SendOTPState(this.value);

  @override
  List<Object?> get props => [value];
}

class SignUpState extends ApisBlocState {
  final Response value;

  SignUpState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetProfileState extends ApisBlocState {
  final ProfileResponse value;

  GetProfileState(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateProfileState extends ApisBlocState {
  final Response value;

  UpdateProfileState(this.value);

  @override
  List<Object?> get props => [value];
}

class AddBankAccountState extends ApisBlocState {
  final AddBankAccountResponse value;

  AddBankAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateBankAccountState extends ApisBlocState {
  final AddBankAccountResponse value;

  UpdateBankAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckBankBalanceState extends ApisBlocState {
  final CheckBankBalanceResponse value;

  CheckBankBalanceState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetBankAccountListState extends ApisBlocState {
  final BankAccountListResponse value;

  GetBankAccountListState(this.value);

  @override
  List<Object?> get props => [value];
}

class PrimaryAccountHistoryState extends ApisBlocState {
  final PrimaryAccountHistoryResponse value;

  PrimaryAccountHistoryState(this.value);

  @override
  List<Object?> get props => [value];
}

class DeleteBankAccountState extends ApisBlocState {
  final DeleteBankAccountResponse value;

  DeleteBankAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class SetPrimaryAccountState extends ApisBlocState {
  final SetPrimaryAccountResponse value;

  SetPrimaryAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class SetActiveAccountState extends ApisBlocState {
  final Response value;

  SetActiveAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class RecentTransactionsState extends ApisBlocState {
  final RecentTransactionsResponse value;

  RecentTransactionsState(this.value);

  @override
  List<Object?> get props => [value];
}

class TransactionHistoryState extends ApisBlocState {
  final bool fromAnotherScreen;
  final TransactionHistoryResponse value;

  TransactionHistoryState(this.value, this.fromAnotherScreen);

  @override
  List<Object?> get props => [value, fromAnotherScreen];
}

class CustomerSettingState extends ApisBlocState {
  final CustomerSettingResponse value;

  CustomerSettingState(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateCustomerSettingState extends ApisBlocState {
  final CustomerSettingResponse value;

  UpdateCustomerSettingState(this.value);

  @override
  List<Object?> get props => [value];
}

class CountryListState extends ApisBlocState {
  final CountryListResponse value;

  CountryListState(this.value);

  @override
  List<Object?> get props => [value];
}

class VerifyRegistrationOtpState extends ApisBlocState {
  final Response value;

  VerifyRegistrationOtpState(this.value);

  @override
  List<Object?> get props => [value];
}

class ResendRegistrationOtpState extends ApisBlocState {
  final Response value;

  ResendRegistrationOtpState(this.value);

  @override
  List<Object?> get props => [value];
}

class CurrencyListState extends ApisBlocState {
  final CurrencyListResponse value;

  CurrencyListState(this.value);

  @override
  List<Object?> get props => [value];
}

class ProviderListState extends ApisBlocState {
  final ProviderListResponse value;

  ProviderListState(this.value);

  @override
  List<Object?> get props => [value];
}

class RegionListState extends ApisBlocState {
  final RegionListResponse value;

  RegionListState(this.value);

  @override
  List<Object?> get props => [value];
}

class ProductListState extends ApisBlocState {
  final ProductListResponse value;

  ProductListState(this.value);

  @override
  List<Object?> get props => [value];
}

class ProductStatusState extends ApisBlocState {
  final ProductStatusResponse value;

  ProductStatusState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetAccountLookupState extends ApisBlocState {
  final GetAccountLookupResponse value;

  GetAccountLookupState(this.value);

  @override
  List<Object?> get props => [value];
}

class BillPaymentState extends ApisBlocState {
  final BillPaymentResponse value;

  BillPaymentState(this.value);

  @override
  List<Object?> get props => [value];
}

class InitiateTxnState extends ApisBlocState {
  final InitiateTransactionResponse value;

  InitiateTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckAccountNumberStatusState extends ApisBlocState {
  final Response value;

  CheckAccountNumberStatusState(this.value);

  @override
  List<Object?> get props => [value];
}

///Second checkout state for all three invoice, subscription and ticket payment
///If sender is MOMO
class CheckoutC2MomoTxnState extends ApisBlocState {
  final InitiateTransactionResponse value;
  final String orderId;
  final bool showLoader;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isTicketPay;
  final bool isTransfer;

  CheckoutC2MomoTxnState(
    this.value, {
    required this.orderId,
    this.showLoader = false,
    this.isInvoicePay = false,
    this.isSubscriptionPay = false,
    this.isTicketPay = false,
    this.isTransfer = false,
  });

  @override
  List<Object?> get props => [
        value,
        orderId,
        showLoader,
        isInvoicePay,
        isSubscriptionPay,
        isTicketPay,
        isTransfer,
      ];
}

class InitiateVerifyOMTxnState extends ApisBlocState {
  final InitiateVerifyOrangeTxnResponse value;

  InitiateVerifyOMTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetOrangeTxnStatusState extends ApisBlocState {
  final InitiateTransactionResponse value;

  GetOrangeTxnStatusState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckoutTxnState extends ApisBlocState {
  final InitiateTransactionResponse value;
  final bool isMOMOTxn;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isTicketPay;
  final bool isTransfer;

  CheckoutTxnState(
    this.value, {
    this.isMOMOTxn = false,
    this.isInvoicePay = false,
    this.isSubscriptionPay = false,
    this.isTicketPay = false,
    this.isTransfer = false,
  });

  @override
  List<Object?> get props => [
        value,
        isMOMOTxn,
        isInvoicePay,
        isSubscriptionPay,
        isTicketPay,
        isTransfer,
      ];
}

class CheckoutEFTTxnState extends ApisBlocState {
  final InitiateTransactionResponse value;

  CheckoutEFTTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckoutVerifyOMTxnState extends ApisBlocState {
  final Response value;

  CheckoutVerifyOMTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class RecentBillTxnState extends ApisBlocState {
  final RecentBillTransactionResponse value;

  RecentBillTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class ForgetPasswordState extends ApisBlocState {
  final ForgetPasswordResponse value;

  ForgetPasswordState(this.value);

  @override
  List<Object?> get props => [value];
}

class ForgetVerifyOTPState extends ApisBlocState {
  final ForgetOtpVerificationResponse value;

  ForgetVerifyOTPState(this.value);

  @override
  List<Object?> get props => [value];
}

class ForgetResetPasswordState extends ApisBlocState {
  final ForgetResetPasswordResponse value;

  ForgetResetPasswordState(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangePasswordState extends ApisBlocState {
  final ChangePasswordResponse value;

  ChangePasswordState(this.value);

  @override
  List<Object?> get props => [value];
}

class InitiatePasswordResetState extends ApisBlocState {
  final Response value;

  InitiatePasswordResetState(this.value);

  @override
  List<Object?> get props => [value];
}

class CompletePasswordResetState extends ApisBlocState {
  final Response value;

  CompletePasswordResetState(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangeTransactionPinState extends ApisBlocState {
  final Response value;
  ChangeTransactionPinState(this.value);

  @override
  List<Object?> get props => [value];
}

class InitiateForgotPinState extends ApisBlocState {
  final Response value;
  InitiateForgotPinState(this.value);

  @override
  List<Object?> get props => [value];
}

class ValidatePinResetOtpState extends ApisBlocState {
  final Response value;
  ValidatePinResetOtpState(this.value);

  @override
  List<Object?> get props => [value];
}

class SetPinState extends ApisBlocState {
  final Response value;
  SetPinState(this.value);

  @override
  List<Object?> get props => [value];
}

class AddBeneficiaryState extends ApisBlocState {
  final AddBeneficiaryResponse value;

  AddBeneficiaryState(this.value);

  @override
  List<Object?> get props => [value];
}

class UpdateBeneficiaryState extends ApisBlocState {
  final AddBankAccountResponse value;

  UpdateBeneficiaryState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetBeneficiaryListState extends ApisBlocState {
  final BeneficiaryFetchResponse value;

  GetBeneficiaryListState(this.value);

  @override
  List<Object?> get props => [value];
}

class DeleteBeneficiaryState extends ApisBlocState {
  final DeleteBeneficiaryResponse value;

  DeleteBeneficiaryState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetBCTPaySettingDetailsState extends ApisBlocState {
  final BctpaySettingDetailsResponse value;

  GetBCTPaySettingDetailsState(this.value);

  @override
  List<Object?> get props => [value];
}

class UploadProfilePicState extends ApisBlocState {
  final Response value;

  UploadProfilePicState(this.value);

  @override
  List<Object?> get props => [value];
}

class KYCSubmitState extends ApisBlocState {
  final SubmitKYCResponse value;

  KYCSubmitState(this.value);

  @override
  List<Object?> get props => [value];
}

class KYCUpdateState extends ApisBlocState {
  final SubmitKYCResponse value;

  KYCUpdateState(this.value);

  @override
  List<Object?> get props => [value];
}

class DeleteKYCIdDocState extends ApisBlocState {
  final Response value;

  DeleteKYCIdDocState(this.value);

  @override
  List<Object?> get props => [value];
}

class DeleteKYCAddressDocState extends ApisBlocState {
  final Response value;

  DeleteKYCAddressDocState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetKYCDetailState extends ApisBlocState {
  final KycDetailResponse value;
  final bool showPreview;

  GetKYCDetailState(this.value, {required this.showPreview});

  @override
  List<Object?> get props => [value];
}

class GetKYCDocsListState extends ApisBlocState {
  final KycDocsListResponse value;

  GetKYCDocsListState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetKYCHistoryState extends ApisBlocState {
  final KycHistoryResponse value;

  GetKYCHistoryState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetBanksListState extends ApisBlocState {
  final BanksListResponse value;

  GetBanksListState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetNotificationsListState extends ApisBlocState {
  final NotificationsListResponse value;
  final bool? clear;

  GetNotificationsListState(this.value, {this.clear = false});

  @override
  List<Object?> get props => [value, clear];
}

class ReadNotificationState extends ApisBlocState {
  final ReadNotificationResponse value;

  ReadNotificationState(this.value);

  @override
  List<Object?> get props => [value];
}

class BannersListState extends ApisBlocState {
  final BannersListResponse value;

  BannersListState(this.value);

  @override
  List<Object?> get props => [value];
}

class ClearNotificationsState extends ApisBlocState {
  final ClearNotificationResponse value;

  ClearNotificationsState(this.value);

  @override
  List<Object?> get props => [value];
}

class ContactUsState extends ApisBlocState {
  final ContactUsResponse value;

  ContactUsState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckBeneficiaryAccountStatusState extends ApisBlocState {
  final BankAccount beneficiary;
  final String? receiverType;
  final String? userType;
  final PaymentRequest? request;
  final ReceiverAccountStatusResponse value;
  final Invoice? invoiceData;

  CheckBeneficiaryAccountStatusState({
    required this.beneficiary,
    this.receiverType,
    this.userType,
    this.request,
    required this.value,
    required this.invoiceData,
  });

  @override
  List<Object?> get props =>
      [value, beneficiary, receiverType, userType, request, invoiceData];
}

class CouponListState extends ApisBlocState {
  final CouponListResponse value;

  CouponListState(this.value);

  @override
  List<Object?> get props => [value];
}

class RequestToPayState extends ApisBlocState {
  final RequestToPayResponse value;

  RequestToPayState(this.value);

  @override
  List<Object?> get props => [value];
}

class PaymentRequestsByMeState extends ApisBlocState {
  final PaymentRequestsByMeResponse value;

  PaymentRequestsByMeState(this.value);

  @override
  List<Object?> get props => [value];
}

class PaymentRequestsByOtherState extends ApisBlocState {
  final PaymentRequestsByOtherResponse value;

  PaymentRequestsByOtherState(this.value);

  @override
  List<Object?> get props => [value];
}

class OpenExpressAccountState extends ApisBlocState {
  final Response value;

  OpenExpressAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class VerifyQRState extends ApisBlocState {
  final VerifyQrResponse value;

  VerifyQRState(this.value);

  @override
  List<Object?> get props => [value];
}

class VerifyTxnQRState extends ApisBlocState {
  final Response value;

  VerifyTxnQRState(this.value);

  @override
  List<Object?> get props => [value];
}

class InvoiceListState extends ApisBlocState {
  final InvoiceListResponse value;

  InvoiceListState(this.value);

  @override
  List<Object?> get props => [value];
}

class InvoiceDetailState extends ApisBlocState {
  final InvoiceDetailResponse value;

  InvoiceDetailState(this.value);

  @override
  List<Object?> get props => [value];
}

class VerifyContactState extends ApisBlocState {
  final VerifyContactResponse value;

  VerifyContactState(this.value);

  @override
  List<Object?> get props => [value];
}

class CheckContactExistState extends ApisBlocState {
  final Response value;
  final String? receiverPhoneCode;
  final String? receiverPhoneNumber;

  CheckContactExistState(this.value,
      {this.receiverPhoneCode, this.receiverPhoneNumber});

  @override
  List<Object?> get props => [value];
}

class AccountLimitState extends ApisBlocState {
  final AccountLimitResponse value;

  AccountLimitState(this.value);

  @override
  List<Object?> get props => [value];
}

class ResendVerificationLinkState extends ApisBlocState {
  final Response value;

  ResendVerificationLinkState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetQueriesState extends ApisBlocState {
  final QueriesListResponse value;

  GetQueriesState(this.value);

  @override
  List<Object?> get props => [value];
}

class RejectPaymentRequestState extends ApisBlocState {
  final Response value;

  RejectPaymentRequestState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetPaymentRequestByIdState extends ApisBlocState {
  final Response value;

  GetPaymentRequestByIdState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetOMChargesState extends ApisBlocState {
  final Response value;

  GetOMChargesState(this.value);

  @override
  List<Object?> get props => [value];
}

class FinalizeOMPaymentState extends ApisBlocState {
  final Response value;

  FinalizeOMPaymentState(this.value);

  @override
  List<Object?> get props => [value];
}

class CancelOMTxnState extends ApisBlocState {
  final Response value;

  CancelOMTxnState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetSubscriptionsState extends ApisBlocState {
  final SubscriptionsResponse value;

  GetSubscriptionsState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetSubscriptionByIdState extends ApisBlocState {
  final Response value;

  GetSubscriptionByIdState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetSubscriptionDetailState extends ApisBlocState {
  final SubscriberUserDetailResponse value;

  GetSubscriptionDetailState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetSubscribersState extends ApisBlocState {
  final SubscriberUserListResponse value;

  GetSubscribersState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetTypeOfQueriesState extends ApisBlocState {
  final QueryTypeResponse value;

  GetTypeOfQueriesState(this.value);

  @override
  List<Object?> get props => [value];
}

class QueryDetailState extends ApisBlocState {
  final QueryDetailResponse value;

  QueryDetailState(this.value);

  @override
  List<Object?> get props => [value];
}

class CloseQueryState extends ApisBlocState {
  final QueryDetailResponse value;

  CloseQueryState(this.value);

  @override
  List<Object?> get props => [value];
}

class ReplyQueryState extends ApisBlocState {
  final QueryDetailResponse value;

  ReplyQueryState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetStateCitiesState extends ApisBlocState {
  final StateCitiesResponse value;

  GetStateCitiesState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetCardsListState extends ApisBlocState {
  final CardsListResponse value;

  GetCardsListState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetThirdPartyListState extends ApisBlocState {
  final ThirdPartyListResponse value;

  GetThirdPartyListState(this.value);

  @override
  List<Object?> get props => [value];
}

class DeleteCustomerAccountState extends ApisBlocState {
  final Response value;

  DeleteCustomerAccountState(this.value);

  @override
  List<Object?> get props => [value];
}

class GetFAQsState extends ApisBlocState {
  final FAQsListResponse value;

  GetFAQsState(this.value);

  @override
  List<Object?> get props => [value];
}
