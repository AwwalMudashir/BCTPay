import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:bctpay/data/models/kyc/kyc_response.dart' as kyc_models;
import 'package:bctpay/views/transaction/send_bank_transfer.dart';
import 'package:bctpay/views/transaction/send_bank_summary.dart';
import 'package:bctpay/views/transaction/send_bank_enter_pin.dart';
import 'package:bctpay/views/transaction/send_bank_success.dart';
import 'package:bctpay/views/transaction/send_options.dart';
import 'package:bctpay/views/transaction/send_mobile_money.dart';
import 'package:bctpay/views/transaction/receive_money/receive_money_screen.dart';
import 'package:bctpay/views/transaction/qr/my_qr_screen.dart';
import 'package:bctpay/views/transaction/payment_link/generate_payment_link_screen.dart';
import 'package:bctpay/views/auth/signup_otp.dart';
import 'package:bctpay/views/user/change_pin.dart';
import 'package:bctpay/views/user/forgot_pin.dart';
import 'package:bctpay/views/kyc/kyc_screen.dart';
import 'package:bctpay/views/kyc/kyc_document_upload_screen.dart';
import 'package:bctpay/views/kyc/kyc_face_verification.dart';
import 'package:bctpay/views/transaction/transaction_preview.dart';

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String bottombar = '/bottombar';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String signupOtp = '/signupOtp';
  static const String otp = '/otp';
  static const String forgot = '/forgot';
  static const String forgotOTPVerification = '/forgotOTPVerification';
  static const String reset = '/reset';
  static const String dashboard = '/dashboard';
  static const String profileQR = '/profileQR';
  static const String beneficiaryList = '/beneficiaryList';
  static const String selectAccountFromList = '/selectAccountFromList';
  static const String selftransfer = '/selftransfer';
  static const String transactiondetail = '/transactiondetail';
    static const String transactionPreview = '/transactionPreview';
  static const String accountsList = '/accountsList';
  static const String requestToPay = '/requestToPay';
  static const String requestToPayDetail = '/requestToPayDetail';
  static const String bankbalance = '/bankbalance';
  static const String walletbalance = '/walletbalance';
  static const String transactionhistory = '/transactionhistory';
  static const String transactionHistoryDetail = '/transactionHistoryDetail';
  static const String mobilerecharge = '/mobilerecharge';
  static const String mobilerechargeform = '/mobilerechargeform';
  static const String mobileRechargePay = '/mobile_recharge_pay';
  static const String mobileRechargeSelectAccount =
      '/mobile_recharge_select_account';
  static const String qrscan = '/qrscan';
  static const String updateProfile = '/updateProfile';
  static const String changePassword = '/changePassword';
  static const String changePin = '/changePin';
  static const String forgotPin = '/forgotPin';
  static const String notifications = '/notifications';
  static const String notificationDetail = '/notificationDetail';
  static const String contactUs = '/contactUs';
  static const String language = '/language';
  static const String kyc = '/kyc';
  static const String kycDetail = '/kycDetail';
  static const String kycHistory = '/kycHistory';
  static const String kycDocumentUpload = '/kycDocumentUpload';
  static const String webview = '/webview';
  static const String paymentRequests = '/paymentRequests';
  static const String openExpressAccount = '/openExpressAccount';
  static const String imageView = '/imageView';
  static const String accountDetail = '/account_detail';
  static const String queries = '/queries';
  static const String queryDetail = '/queryDetail';
  static const String beneficiaryDetail = '/beneficiaryDetail';
  static const String txnSuccess = '/txnSuccess';
  static const String couponDetail = '/couponDetail';
  static const String invoiceList = '/invoiceList';
  static const String invoiceDetail = '/invoiceDetail';
  static const String billsNSubscription = '/billsNSubscription';
  static const String kycProofOfIdentity = '/kycProofOfIndentity';
  static const String kycProofOfAddress = "/kycProofOfAddress";
  static const String kycTakeASelfie = "/kycTakeASelfie";
  static const String kycViewAllDocsScreen = "/kycViewAllDocsScreen";
  static const String kycFileView = "/kycFileView";
  static const String subscriptionDetail = "/subscriptionDetail";
  static const String kycSelfiePreview = "/kycSelfiePreview";
    static const String kycFaceVerification = "/kycFaceVerification";
  static const String profileDetails = "/profileDetails";
  static const String filterTxnScreen = "/filterTxnScreen";
  static const String filterSubscriptionScreen = "/filterSubscriptionScreen";
  static const String filterInvoiceScreen = "/filterInvoiceScreen";
  static const String filterQueriesScreen = "/filterQueriesScreen";
  static const String kycIdentityVerificationDetails =
      "/kycIdentityVerificationDetails";
  static const String primaryAccountHistory = "/primaryAccountHistory";
  static const String paymentLinkScreen = "/paymentLinkScreen";
  static const String receiveMoney = "/receiveMoney";
  static const String generatePaymentLink = "/generatePaymentLink";
  static const String myQr = "/myQr";
  static const String videoPlayer = "/videoPlayer";
  static const String faq = "/faq";
  static const String sendBankTransfer = "/sendBankTransfer";
  static const String sendBankSummary = "/sendBankSummary";
  static const String sendBankEnterPin = "/sendBankEnterPin";
  static const String sendBankSuccess = "/sendBankSuccess";
  static const String sendOptions = "/sendOptions";
  static const String sendBeneficiaries = "/sendBeneficiaries";
  static const String sendMobileMoney = "/sendMobileMoney";
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.splash: (context) => const SplashScreen(),
  AppRoutes.intro: (context) => const IntroScreen(),
  AppRoutes.bottombar: (context) => const BottomNavigation(),
  AppRoutes.login: (context) => const LoginScreen(),
  AppRoutes.signup: (context) => const SignUpScreen(),
  AppRoutes.signupOtp: (context) => const SignupOtpScreen(),
  AppRoutes.otp: (context) => const OTPScreen(),
  AppRoutes.forgot: (context) => const ForgotPasswordScreen(),
  AppRoutes.forgotOTPVerification: (context) =>
      const ForgetOTPVerificationScreen(),
  AppRoutes.reset: (context) => const ResetPasswordScreen(),
  AppRoutes.dashboard: (context) => const Dashboard(),
  AppRoutes.profileQR: (context) => const ProfileQRScreen(),
  AppRoutes.beneficiaryList: (context) => const BeneficiaryListScreen(),
  AppRoutes.selectAccountFromList: (context) => const SelectAccountFromList(),
  AppRoutes.selftransfer: (context) => const SelfTransferScreen(),
  AppRoutes.transactiondetail: (context) => const TransactionDetailScreen(),
    AppRoutes.transactionPreview: (context) => const TransactionPreviewScreen(),
  // '/transfersuccess': (context) => TransferSuccessfullScreen(),
  AppRoutes.accountsList: (context) => const AccountsListScreen(),
  AppRoutes.requestToPay: (context) => const RequestToPayScreen(),
  AppRoutes.requestToPayDetail: (context) => const RequestToPayDetail(),
  AppRoutes.bankbalance: (context) => const BankBalance(),
  AppRoutes.walletbalance: (context) => const WalletBalance(),
  // '/addbankaccount': (context) => const AddBankAcountScreen(),
  AppRoutes.transactionhistory: (context) => const TransactionHistory(),
  AppRoutes.transactionHistoryDetail: (context) =>
      const TransactionHistoryDetail(),
  AppRoutes.mobilerecharge: (context) => const MobileRecharge(),
  AppRoutes.mobilerechargeform: (context) => const MobileRechargeForm(),
  AppRoutes.mobileRechargePay: (context) => const MobileRechargePayScreen(),
  AppRoutes.mobileRechargeSelectAccount: (context) =>
      const MobileRechargeSelectAccount(),
  AppRoutes.qrscan: (context) => const QRScanScreen(),
  AppRoutes.updateProfile: (context) => const UpdateProfile(),
  AppRoutes.changePassword: (context) => const ChangePassword(),
  AppRoutes.changePin: (context) => const ChangePinScreen(),
  AppRoutes.forgotPin: (context) => const ForgotPinScreen(),
  AppRoutes.notifications: (context) => const NotificationScreen(),
  AppRoutes.notificationDetail: (context) => const NotificationDetail(),
  AppRoutes.contactUs: (context) => const ContactUs(),
  AppRoutes.language: (context) => const LanguageDropDown(),
  AppRoutes.kyc: (context) => const KycScreen(),
  AppRoutes.kycDocumentUpload: (context) => KycDocumentUploadScreen(
        item: ModalRoute.of(context)!.settings.arguments as kyc_models.KYCItem,
      ),
  AppRoutes.kycHistory: (context) => const KYCHistory(),
  AppRoutes.webview: (context) => const CustomWebView(),
  AppRoutes.paymentRequests: (context) => const PaymentRequestsScreen(),
  AppRoutes.openExpressAccount: (context) => const OpenExpressAccountScreen(),
  AppRoutes.imageView: (context) => const ImageView(),
  AppRoutes.accountDetail: (context) => const AccountDetail(),
  AppRoutes.queries: (context) => QueriesScreen(),
  AppRoutes.queryDetail: (context) => const QueryHistoryDetail(),
  AppRoutes.beneficiaryDetail: (context) => const BeneficiaryDetail(),
  AppRoutes.txnSuccess: (context) => TransferSuccessfullScreen(),
  AppRoutes.couponDetail: (context) => const CouponDetailView(),
  AppRoutes.invoiceList: (context) => const InvoiceList(),
  AppRoutes.invoiceDetail: (context) => const InvoiceDetail(),
  AppRoutes.billsNSubscription: (context) =>
      const MyBillsAndSubscriptionsScreen(),
  AppRoutes.kycProofOfIdentity: (context) => const KYCProofOfIdentity(),
  AppRoutes.kycProofOfAddress: (context) => const KYCProofOfAddress(),
  AppRoutes.kycTakeASelfie: (context) => const KYCTakeASelfie(),
  AppRoutes.kycViewAllDocsScreen: (context) => const KYCViewAllDocsScreen(),
  AppRoutes.kycFileView: (context) => const KYCFileView(),
  AppRoutes.subscriptionDetail: (context) => const SubscriptionDetail(),
  AppRoutes.kycSelfiePreview: (context) => const KYCSelfiePreview(),
    AppRoutes.kycFaceVerification: (context) => const KycFaceVerification(),
  AppRoutes.profileDetails: (context) => const ProfileDetails(),
  AppRoutes.filterTxnScreen: (context) => const FilterTxnScreen(),
  AppRoutes.filterSubscriptionScreen: (context) =>
      const FilterSubscriptionScreen(),
  AppRoutes.filterInvoiceScreen: (context) => const FilterInvoiceScreen(),
  AppRoutes.filterQueriesScreen: (context) => const FilterQueriesScreen(),
  AppRoutes.kycIdentityVerificationDetails: (context) =>
      const KYCIdentityVerificationDetails(),
  AppRoutes.primaryAccountHistory: (context) =>
      const PrimaryAccountHistoryScreen(),
  AppRoutes.paymentLinkScreen: (context) => const PaymentLinkScreen(),
  AppRoutes.videoPlayer: (context) => const VideoPlayer1(),
  AppRoutes.faq: (context) => const FAQsScreen(),
  AppRoutes.generatePaymentLink: (context) =>
      const GeneratePaymentLinkScreen(),
  AppRoutes.receiveMoney: (context) => const ReceiveMoneyScreen(),
  AppRoutes.myQr: (context) => const MyQrScreen(),
  AppRoutes.sendBankTransfer: (context) => const SendBankTransferScreen(),
  AppRoutes.sendBankSummary: (context) => const SendBankSummaryScreen(),
  AppRoutes.sendBankEnterPin: (context) => const SendBankEnterPinScreen(),
  AppRoutes.sendBankSuccess: (context) => const SendBankSuccessScreen(),
  AppRoutes.sendOptions: (context) => const SendOptionsScreen(),
  AppRoutes.sendBeneficiaries: (context) => const SendBeneficiariesScreen(),
  AppRoutes.sendMobileMoney: (context) => const SendMobileMoneyScreen(),
};
