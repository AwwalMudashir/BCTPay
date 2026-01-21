class ApiEndpoint {
  //Authentication
  static const String forgotOtpVerify = "customeremailotpverify";
  static const String forgotPassword = "customerforgetpassword";
  static const String forgotResetPassword = "customerresetpassword";
  static const String login = "ecommerce/login";
  static const String sendOTP = "send_otp";

  // static const String signUp = "customersignup";
  static const String signUp = "onboarding/customer/simple-onboard";
  static const String resendVerificationLink = "resend_c_email";
  static const String verifyRegistrationOtp = "onboarding/customer/verify-otp";
  static const String resendRegistrationOtp = "usermanager/resendotp";

  //User
  static const String changePwd = "changepassword";
  static const String initiatePasswordReset = "ecommerce/initiatePasswordReset";
  static const String selfPasswordReset = "ecommerce/selfPasswordReset";
  // PIN management (Core)
  static const String setPin = "ecommerce/setPIN";
  static const String initiateForgotPin = "ecommerce/initiateForgotPin";
  static const String changeTransactPin = "ecommerce/changeTransactPin";
  static const String validatePinResetOtp = "ecommerce/validatePinResetOtp";
  static const String customerSettingDetail = "settingdetails";
  static const String getProfile = "v1/getprofile";
  static const String updateSetting = "updatesetting";
  static const String updateProfile = "updateprofile";
  static const String uploadProfile = "uploadcustomerprofilepic";
  static const String deleteCustomerAccount = "delete_customer_acc";

  //KYC
  // static const String kycDetail = "getkycdetails";
  static const String kycDetail = "kyc_details";
  static const String kycDocList = "kycdoclist";
  // static const String kycHistory = "getkychistory";
  static const String kycHistory = "kyc_history_details";
  // static const String submitKYC = "uploadcustomerkyc";
  // static const String submitKYC = "upload_kyc";
  // static const String submitKYC = "add_kyc";
  static const String submitKYC = "add_kyc_v2";
  static const String updateKYC = "update_kyc"; //not used
  static const String updateKYCSelfie = "update_kyc_selfie_proof";
  // static const String updateKYCIdentity = "update_kyc_identity";
  // static const String updateKYCAddress = "update_kyc_add_proof";
  static const String updateKYCIdentity = "update_kyc_identity_v1";
  static const String updateKYCAddress = "update_kyc_add_proof_v1";
  static const String deleteKycIdentityDocument = "delete_indentity_document";
  static const String deleteKycAddressDocument =
      "delete_address_proof_document";

  //Transaction
  static const String initiateTxn = "v6/initiate_transaction";
  // static const String initiateOMTxn = "initiate_om_transaction";
  static const String initiateC2MTxn = "v6/initiate_c2m_transaction";
  static const String initiateC2MInvoiceTxn = "v6/initiate_invoice_payment";
  static const String initiateSubscriptionTxn = "initiate_subscription_payment";
  // 'http://localhost:3055/api/customertransaction/initiate_subscription_payment',
  static const String checkoutTxn = "v6/checkout_transfer_payment";
  static const String checkoutC2MTxn = "v6/checkout_c2m_transfer_payment";
  static const String checkoutC2MInvoiceTxn = "v6/checkout_invoice_payment";
  static const String checkoutSubscriptionTxn = "checkout_subscription_payment";
  static const String checkoutEFTTxn = "/v6/checkout_eft_transfer_payment";
  static const String checkoutEFTInvoiceTxn =
      "/v6/checkout_eft_invoice_payment";
  static const String checkoutEFTSubscriptionTxn =
      "checkout_eft_subscription_payment";
  static const String getOMTxnStatus = "v1/checkout_om_transfer_payment";
  // static const String getOMTxnStatus = "/v1/get_update_om_transaction_status";
  // static const String getOMTxnStatus = "v1/om_transaction_details";
  static const String getOMCharges = "get_om_charges";
  static const String finalizeOMPayment = "finalize_om_payment";
  static const String cancelOMPayment = "cancle_om_payment";
  static const String initiateVerifyOMWalletTxn =
      "initiate_verify_payment"; //To verify Orange Money wallet by OTP
  static const String checkoutVerifyOMWalletTxn = "checkout_verify_payment";
  static const String thirdPartyList = "tp_list";
  static const String checkContactExist = "check_contact_number";
  static const String receiverAccStatus = "v2/receiver_account_status";

  static const String checkoutOMInvoicePayment = "checkout_om_invoice_payment";
  static const String checkoutOMSubscriptionPayment =
      "checkout_om_subscription_payment";

  ///Payment link (Ticket) txn
  static const String ticketInitiatePayment = "ticket_initiate_payment";
  static const String ticketCheckoutPayment = "ticket_checkout_payment";
  static const String checkoutEftTicketPayment = "checkout_eft_ticket_payment";
  static const String checkoutOmTicketPayment = "checkout_om_ticket_payment";
  static const String eventTransactionDetails = "event_transaction_details";
  static const String downloadTicket = "/download_ticket/:transaction_id";

  ///Txn history
  static const String recentBillTxnList = "recentbilltransaction";
  static const String recentTxn = "recenttransaction";
  static const String txnDetail = "v2/get_transaction_details";
  static const String txnList = "v3/transaction_list";

  ///Checkout transaction apis when sender is MOMO,
  ///In all three cases (Invoice, subscription and payment link)
  static const String checkoutMomoInvoiceTxn = "checkout_momo_invoice_payment";
  static const String checkoutMomoSubscriptionTxn = "checkout_momo_subscription_payment";
  static const String checkoutMomoTicketTxn = "checkout_momo_ticket_payment";
  static const String checkoutMomoTxn = "checkout_momo_payment";

  ///Check third party account status in case of MOMO
  static const String checkThirdPartyAccountStatus = "check_account_status";

  //Account
  static const String addAcc = "addbankaccount";
  static const String addBeneficiary = "addbeneficiary";
  static const String updateAcc = "updatebankaccount";
  static const String updateBeneficiary = "updatebenificiary";
  static const String checkBal = "checkbankbalance";
  static const String cardList = "list_card";
  static const String deleteAcc = "deletebankaccount";
  static const String deleteBeneficiary = "deletebenefiary";
  static const String accAddLimit = "getpermissionlist";
  static const String accountList = "getaccountprofile";
  static const String bankList = "lookupdata/banks";
  static const String beneficiaryList = "listbeneficiary";
  static const String beneficiariesFetch = "beneficiary/fetch";
  static const String beneficiarySave = "beneficiary/save";
  static const String openExpressAcc = "openexpressaccount";
  static const String primaryAccountHistory =
      "customer_primery_account_history";
  static const String setAccActive = "makeactiveaccount";
  static const String setAccPrimary = "makeprimaryaccount";
  static const String momoList = "lookupdata/momo";

  ///Global
  static const String bannerList = "getcustomerpromotionlist";
  // static const String bannerList2 = "getcustomerpromotionbannerlist";
  static const String bannerList2 = "getcustomerpromotionbannerlist_v1";
  static const String bctPaySettingDetail = "bctpaysettingdetails";
  static const String countryList = "country/list";
  static const String stateCitiesList = "state_cities_list";
  static const String currencyList = "getcurrency";
  static const String couponList = "getcouponlist";
  // static const String mySubscription = "customer_promotion_banner_list";
  static const String faq = "faq";

  //Recharge
  static const String billPayment = "billpayment";
  static const String accountLookup = "getaccountlookup";
  static const String productList = "getproductlist";
  static const String productStatus = "getproductstatus";
  static const String providerList = "getproviderlist";
  static const String regionList = "getregionlist";

  //Notifications
  static const String clearNotification = "clearallnotifcation";
  static const String notificationList = "getcustomertnotification";
  // static const String notificationList = "getCustomernotificationByType";
  static const String readNotification = "readallnotifcation";

  //Payment request
  static const String sendPaymentRequest = "get_request_to_pay";
  static const String paymentRequestListForReceiiver =
      "v1/receiver_requesttopay_list";
  static const String paymentRequestListForSender =
      "v1/sender_requesttopay_list";
  static const String rejectPR = "reject_pay_request";
  static const String requestToPay = "requesttopay";

  //Invoice
  static const String invoiceDetail = "invoice_details";
  // static const String invoiceList = "getmyinvoice";
  static const String invoiceList = "getmyinvoice_v1";

  ///Subscription
  // static const String mySubscription = "my_subscription";
  static const String mySubscription = "my_subscription_v1";
  static const String subscriptionDetails = "subscription_details";
  static const String getSubscriberUserList = "get_subscriber_user_list";
  static const String getAllSubscriberUserAccDetails =
      "get_all_subscriber_userAcc_details";

  ///Query
  static const String getTypeOfQueries = "get_type_of_queries";
  static const String enquiry = "inquiry";
  // static const String queriesList = "querieslist";
  static const String queriesList = "querieslist_v1";

  static const String queryDetail = "query_details";
  static const String closeQuery = "query_closed";
  static const String queryReply = "reply_to_admin_msg";

  //Scan QR
  // static const String verifyTransaction =
  //     "verify_transaction"; //to verify txn customer side
  static const String verifyTxnQR = "verify_transaction_qr";
  static const String getEventDetails = "get_event_details"; //Not used
  static const String verifyContact = "v1/verify_contact_number";
  // static const String verifyQR = "verifyqrcode";
  static const String verifyQR = "/v1/verify_qr_code";
  static const String walletBalance = "coinwallet/balance";
  static const String momoSendMoney = "momobank/send-money";
  static const String fetchMyQr = "pay-with-qr/fetch-my-qr";
  static const String getWalletNameByQr = "pay-with-qr/getWalletNameByQr";
  // static const String verifyInvoiceQR = "verify_invoice_qr_link";
}
