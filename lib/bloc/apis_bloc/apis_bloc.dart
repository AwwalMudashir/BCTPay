import 'package:bctpay/data/repository/transaction_repo/mtn_momo_txn/check_account_number_status_api.dart';
import 'package:bctpay/data/repository/transaction_repo/mtn_momo_txn/checkout_momo_payment_api.dart';
import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';

class ApisBloc extends Bloc<ApisBlocEvent, ApisBlocState> {
  ApisBloc(super.initialState) {
    on(eventHandler);
  }

  FutureOr<void> eventHandler(
      ApisBlocEvent event, Emitter<ApisBlocState> emit) async {
    if (event is ApisBlocInitialEvent) {
      emit(ApisBlocInitialState());
    }

    if (event is LoginEvent) {
      emit(ApisBlocLoadingState());
      try {
        await login(
          loginBody: event.loginBody,
        ).then((value) => emit(LoginState(value)));
      } catch (e) {
        if (e is TooManyRequestException) {
          emit(ApisBlocErrorState(message: e.error));
        } else {
          emit(ApisBlocErrorState(message: e.toString()));
        }
      }
    }

    if (event is SendOTPEvent) {
      emit(ApisBlocLoadingState());
      try {
        await sendOTP(loginBody: event.loginBody)
            .then((value) => emit(SendOTPState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is GetProfileEvent) {
      emit(ApisBlocLoadingState());
      await getProfile().then((value) => emit(GetProfileState(value)));
    }

    if (event is UpdateProfileEvent) {
      emit(ApisBlocLoadingState());
      await updateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        phoneCode: event.phoneCode,
        phoneNumber: event.phoneNumber,
        address: event.address,
        city: event.city,
        country: event.country,
        state: event.state,
        pinCode: event.pinCode,
        gender: event.gender,
      ).then((value) => emit(UpdateProfileState(value)));
    }

    if (event is SignUpEvent) {
      emit(ApisBlocLoadingState());
      try {
        await signup(
          email: event.email,
          phoneCode: event.phoneCode,
          phoneNumber: event.phoneNumber,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
          address: event.address,
          city: event.city,
          country: event.country,
          pinCode: event.pinCode,
          gender: event.gender,
        ).then((value) => emit(SignUpState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is AddBankAccountEvent) {
      emit(ApisBlocLoadingState());
      await addBankAccount(
        bankcode: event.bankcode,
        bankname: event.bankname,
        accountnumber: event.accountnumber,
        beneficiaryname: event.beneficiaryname,
        clientId: event.clientId,
        accountRole: event.accountRole,
        walletPhonenumber: event.walletPhoneNumber,
        phoneCode: event.phoneCode,
      ).then((value) => emit(AddBankAccountState(value)));
    }

    if (event is UpdateBankAccountEvent) {
      emit(ApisBlocLoadingState());
      await updateBankAccount(
              accountRole: event.accountRole,
              accountId: event.accountId,
              bankcode: event.bankcode,
              bankname: event.bankname,
              accountnumber: event.accountnumber,
              beneficiaryname: event.beneficiaryname,
              clientId: event.clientId,
              walletPhonenumber: event.walletPhonenumber,
              phoneCode: event.phoneCode)
          .then((value) => emit(UpdateBankAccountState(value)));
    }

    if (event is CheckBankBalanceEvent) {
      emit(ApisBlocLoadingState());
      await checkBankBalance(accountId: event.accountId)
          .then((value) => emit(CheckBankBalanceState(value)));
    }

    if (event is GetBankAccountListEvent) {
      emit(ApisBlocLoadingState());
      await getBankAccountList()
          .then((value) => emit(GetBankAccountListState(value)));
    }

    if (event is PrimaryAccountHistoryEvent) {
      emit(ApisBlocLoadingState());
      await primaryAccountHistory()
          .then((value) => emit(PrimaryAccountHistoryState(value)));
    }

    if (event is DeleteBankAccountEvent) {
      emit(ApisBlocLoadingState());
      await deleteBankAccount(
        account: event.account,
      ).then((value) => emit(DeleteBankAccountState(value)));
    }

    if (event is SetPrimaryAccountEvent) {
      emit(ApisBlocLoadingState());
      await setPrimaryAccount(
        account: event.account,
      ).then((value) => emit(SetPrimaryAccountState(value)));
    }

    if (event is SetActiveAccountEvent) {
      emit(ApisBlocLoadingState());
      await setActiveAccount(
        account: event.account,
      ).then((value) => emit(SetActiveAccountState(value)));
    }

    if (event is RecentTransactionsEvent) {
      emit(ApisBlocLoadingState());
      try {
        await recentTransactions()
            .then((value) => emit(RecentTransactionsState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is TransactionHistoryEvent) {
      emit(ApisBlocLoadingState());
      await transactionHistory(
        limit: event.limit,
        page: event.page,
        filter: event.filter,
      ).then((value) =>
          emit(TransactionHistoryState(value, event.fromAnotherScreen)));
    }

    if (event is CustomerSettingEvent) {
      emit(ApisBlocLoadingState());
      await customerSetting()
          .then((value) => emit(CustomerSettingState(value)));
    }

    if (event is UpdateCustomerSettingEvent) {
      emit(ApisBlocLoadingState());
      await updateCustomerSetting(
              language: event.language,
              currency: event.currency,
              currencySymbol: event.currencySymbol,
              themeColor: event.themeColor,
              timezone: event.timezone)
          .then((value) => emit(UpdateCustomerSettingState(value)));
    }

    if (event is CountryListEvent) {
      emit(ApisBlocLoadingState());
      await getCountryList().then((value) => emit(CountryListState(value)));
    }

    if (event is CurrencyListEvent) {
      emit(ApisBlocLoadingState());
      await getCurrencyList().then((value) => emit(CurrencyListState(value)));
    }

    if (event is ProviderListEvent) {
      emit(ApisBlocLoadingState());
      await getProviderList(
              providerCodes: event.providerCodes,
              countryIsos: event.countryIsos,
              regionCodes: event.regionCodes,
              accountNumber: event.accountNumber,
              benefits: event.benefits,
              skuCodes: event.skuCodes)
          .then((value) => emit(ProviderListState(value)));
    }

    if (event is RegionListEvent) {
      emit(ApisBlocLoadingState());
      await getRegionList(countryIsos: event.countryIsos)
          .then((value) => emit(RegionListState(value)));
    }

    if (event is ProductListEvent) {
      emit(ApisBlocLoadingState());
      await getProductList(
              regionCodes: event.regionCodes,
              accountNumber: event.accountNumber,
              providerCode: event.providerCode,
              benefits: event.benefits)
          .then((value) => emit(ProductListState(value)));
    }

    if (event is ProductStatusEvent) {
      emit(ApisBlocLoadingState());
      await getProductStatus().then((value) => emit(ProductStatusState(value)));
    }

    if (event is GetAccountLookupEvent) {
      emit(ApisBlocLoadingState());
      await getAccountLookup(accountNumber: event.accountNumber)
          .then((value) => emit(GetAccountLookupState(value)));
    }

    if (event is BillPaymentEvent) {
      emit(ApisBlocLoadingState());
      try {
        await billPayment(
                paymentwith: event.paymentwith,
                amount: event.amount,
                customerPhone: event.customerPhone,
                skuCode: event.skuCode,
                sendCurrencyIso: event.sendCurrencyIso,
                accountNumber: event.accountNumber)
            .then((value) => emit(BillPaymentState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is InitiateTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateTxnC2C(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transferType: event.transferType,
          requestedAmount: event.requestedAmount,
          receiverType: event.receiverType,
          userType: event.userType,
          requestedId: event.requestedId,
          senderPaymentType: event.senderPaymentType,
          couponCode: event.couponCode,
        ).then((value) => emit(InitiateTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is InitiateVerifyOMTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateVerifyOMTxn(
          phoneCode: event.phoneCode,
          phoneNumber: event.phoneNumber,
          returnUrl: event.returnUrl,
          cancelUrl: event.cancelUrl,
        ).then((value) => emit(InitiateVerifyOMTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is GetOrangeTxnStatusEvent) {
      emit(ApisBlocLoadingState());
      try {
        await getOrangeMoneyTxnStatus(
          orderId: event.orderId,
        ).then((value) => emit(GetOrangeTxnStatusState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }
    if (event is CheckAccountNumberStatusEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkAccountNumberStatus(
          accountNumber: event.accountNumber,
          phoneCode: event.phoneCode,
          institutionName: event.institutionName,
          accountType: event.accountType,
        ).then((value) => emit(CheckAccountNumberStatusState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is InitiateC2MTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateC2MTxn(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transferType: event.transferType,
          requestedAmount: event.requestedAmount,
          receiverType: event.receiverType,
          userType: event.userType,
          merchantId: event.merchantId,
          requestedId: event.requestedId,
          senderPaymentType: event.senderPaymentType,
          couponCode: event.couponCode,
        ).then((value) => emit(InitiateTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is InitiateC2MInvoiceTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateC2MInvoiceTxn(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transferType: event.transferType,
          requestedAmount: event.requestedAmount,
          receiverType: event.receiverType,
          userType: event.userType,
          merchantId: event.merchantId,
          requestedId: event.requestedId,
          senderPaymentType: event.senderPaymentType,
          invoiceNumber: event.invoiceNumber,
          couponCode: event.couponCode,
        ).then((value) => emit(InitiateTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is InitiateTicketTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateTicketTxn(
          initiateTxnBody: event.body,
        ).then((value) => emit(InitiateTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is InitiateSubscriptionTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await initiateSubscriptionTxn(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transferType: event.transferType,
          requestedAmount: event.requestedAmount,
          receiverType: event.receiverType,
          userType: event.userType,
          merchantId: event.merchantId,
          requestedId: event.requestedId,
          senderPaymentType: event.senderPaymentType,
          subscription: event.subscription,
          couponCode: event.couponCode,
        ).then((value) => emit(InitiateTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is CheckoutTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutTxn(
                amount: event.amount,
                senderAccountId: event.senderAccountId,
                receiverAccountId: event.receiverAccountId,
                txnNote: event.txnNote,
                transactionRefNumber: event.transactionRefNumber,
                receiverType: event.receiverType,
                senderPaymentType: event.senderPaymentType,
                returnUrl: event.returnUrl,
                cancelUrl: event.cancelUrl,
                landingUrl: event.landingUrl,
                cardId: event.cardId)
            .then((value) => emit(CheckoutTxnState(
                  value,
                  isMOMOTxn: event.isMOMOTxn,
                  isTransfer: event.isTransfer,
                )));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutEFTTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutEFTTxn(
          orderId: event.orderId,
        ).then((value) => emit(CheckoutEFTTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutC2MTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutC2MTxn(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transactionRefNumber: event.transactionRefNumber,
          receiverType: event.receiverType,
          merchantId: event.merchantId,
          senderPaymentType: event.senderPaymentType,
          returnUrl: event.returnUrl,
          cancelUrl: event.cancelUrl,
          landingUrl: event.landingUrl,
          cardId: event.cardId,
        ).then((value) => emit(CheckoutTxnState(
              value,
              isMOMOTxn: event.isMOMOTxn,
              isTransfer: event.isTransfer,
            )));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutC2MInvoiceTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutC2MInvoiceTxn(
                amount: event.amount,
                senderAccountId: event.senderAccountId,
                receiverAccountId: event.receiverAccountId,
                txnNote: event.txnNote,
                transactionRefNumber: event.transactionRefNumber,
                receiverType: event.receiverType,
                merchantId: event.merchantId,
                senderPaymentType: event.senderPaymentType,
                returnUrl: event.returnUrl,
                cancelUrl: event.cancelUrl,
                invoiceNumber: event.invoiceNumber,
                landingUrl: event.landingUrl,
                cardId: event.cardId)
            .then((value) => emit(CheckoutTxnState(
                  value,
                  isMOMOTxn: event.isMOMOTxn,
                  isInvoicePay: event.isInvoicePay,
                )));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutTicketTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutTicketTxn(
          checkoutTxnBody: event.body,
        ).then((value) => emit(CheckoutTxnState(
              value,
              isMOMOTxn: event.isMOMOTxn,
              isTicketPay: event.isTicketPay,
            )));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutSubscriptionTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutSubscriptionTxn(
          amount: event.amount,
          senderAccountId: event.senderAccountId,
          receiverAccountId: event.receiverAccountId,
          txnNote: event.txnNote,
          transactionRefNumber: event.transactionRefNumber,
          receiverType: event.receiverType,
          merchantId: event.merchantId,
          senderPaymentType: event.senderPaymentType,
          returnUrl: event.returnUrl,
          cancelUrl: event.cancelUrl,
          subscription: event.subscription,
          landingUrl: event.landingUrl,
          cardId: event.cardId,
        ).then((value) => emit(CheckoutTxnState(value,
            isMOMOTxn: event.isMOMOTxn,
            isSubscriptionPay: event.isSubscriptionPay)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CheckoutVerifyOMTxnEvent) {
      emit(ApisBlocLoadingState());
      await checkoutVerifyOMTxn(
        orderId: event.orderId,
      ).then((value) => emit(CheckoutVerifyOMTxnState(value)));
    }

    if (event is CheckoutC2MomoTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await checkoutMomoPayment(
                orderId: event.orderId,
                urlEndpoint: event.isInvoicePay
                    ? ApiEndpoint.checkoutMomoInvoiceTxn
                    : event.isSubscriptionPay
                        ? ApiEndpoint.checkoutMomoSubscriptionTxn
                        : event.isTicketPay
                            ? ApiEndpoint.checkoutMomoTicketTxn
                            : ApiEndpoint.checkoutMomoTxn)
            .then((value) => emit(CheckoutC2MomoTxnState(
                  value,
                  orderId: event.orderId,
                  showLoader: event.showLoader,
                  isInvoicePay: event.isInvoicePay,
                  isSubscriptionPay: event.isSubscriptionPay,
                  isTicketPay: event.isTicketPay,
                )));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is RecentBillTxnEvent) {
      emit(ApisBlocLoadingState());
      try {
        await getRecentBillTxn()
            .then((value) => emit(RecentBillTxnState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is ForgetPasswordEvent) {
      emit(ApisBlocLoadingState());
      await forgetPassword(email: event.email)
          .then((value) => emit(ForgetPasswordState(value)));
    }

    if (event is ForgetVerifyOTPEvent) {
      emit(ApisBlocLoadingState());
      await forgetOTPVerify(emailOtp: event.emailOTP)
          .then((value) => emit(ForgetVerifyOTPState(value)));
    }

    if (event is ForgetResetPasswordEvent) {
      emit(ApisBlocLoadingState());
      await forgetResetPassword(
              emailOtp: event.emailOTP, newpassword: event.newPassword)
          .then((value) => emit(ForgetResetPasswordState(value)));
    }

    if (event is ChangePasswordEvent) {
      emit(ApisBlocLoadingState());
      await changePassword(
              oldPassword: event.oldPassword, newPassword: event.newPassword)
          .then((value) => emit(ChangePasswordState(value)));
    }
    if (event is AddBeneficiaryEvent) {
      emit(ApisBlocLoadingState());
      await addBeneficiary(
        bankcode: event.bankcode,
        bankname: event.bankname,
        accountnumber: event.accountnumber,
        beneficiaryname: event.beneficiaryname,
        clientId: event.clientId,
        accountRole: event.accountRole,
        walletPhonenumber: event.walletPhoneNumber,
        phoneCode: event.phoneCode,
      ).then((value) => emit(AddBeneficiaryState(value)));
    }

    if (event is UpdateBeneficiaryEvent) {
      emit(ApisBlocLoadingState());
      await updateBeneficiary(
              accountRole: event.accountRole,
              accountId: event.accountId,
              bankcode: event.bankcode,
              bankname: event.bankname,
              accountnumber: event.accountnumber,
              beneficiaryname: event.beneficiaryname,
              clientId: event.clientId,
              walletPhonenumber: event.walletPhonenumber,
              phoneCode: event.phoneCode)
          .then((value) => emit(UpdateBeneficiaryState(value)));
    }

    if (event is GetBeneficiaryListEvent) {
      await getBeneficiaryList(limit: event.limit, page: event.page)
          .then((value) => emit(GetBeneficiaryListState(value)));
    }

    if (event is DeleteBeneficiaryEvent) {
      emit(ApisBlocLoadingState());
      await deleteBeneficiary(beneficiaryId: event.beneficiaryId)
          .then((value) => emit(DeleteBeneficiaryState(value)));
    }

    if (event is GetBCTPaySettingDetailsEvent) {
      emit(ApisBlocLoadingState());
      await getBctPaySettingDetails(countryId: event.countryId)
          .then((value) => emit(GetBCTPaySettingDetailsState(value)));
    }

    if (event is UploadProfilePicEvent) {
      emit(ApisBlocLoadingState());
      await uploadProfilePic(imageFile: event.profilePic)
          .then((value) => emit(UploadProfilePicState(value)));
    }

    if (event is KYCSubmitEvent) {
      emit(ApisBlocLoadingState());
      await submitKYC(
        userName: event.userName,
        dob: event.dob,
        identityProofList: event.identityProofList,
        addressProofList: event.addressProofList,
        oldKYCData: event.oldKYCData,
        selfieImage: event.selfieImage,
        email: event.email,
        phoneCode: event.phoneCode,
        phoneNumber: event.phoneNumber,
        address: event.address,
        city: event.city,
        pinCode: event.pinCode,
        state: event.state,
        line1: event.line1,
        line2: event.line2,
        landmark: event.landmark,
      ).then((value) => emit(KYCSubmitState(value)));
    }

    if (event is KYCUpdateEvent) {
      emit(ApisBlocLoadingState());
      await updateKYC(
              userName: event.userName,
              dob: event.dob,
              identityProofList: event.identityProofList,
              addressProofList: event.addressProofList,
              oldKYCData: event.oldKYCData,
              selfieImage: event.selfieImage,
              email: event.email,
              phoneCode: event.phoneCode,
              phoneNumber: event.phoneNumber,
              address: event.address,
              city: event.city,
              pinCode: event.pinCode,
              state: event.state)
          .then((value) => emit(KYCSubmitState(value)));
    }

    if (event is KYCUpdatePhotoProofEvent) {
      emit(ApisBlocLoadingState());
      await updateKYCSelfie(
        oldKYCData: event.oldKYCData,
        selfieImage: event.selfieImage,
      ).then((value) => emit(KYCSubmitState(value)));
    }

    if (event is KYCUpdateIdProofEvent) {
      emit(ApisBlocLoadingState());
      await updateKYCIdentityProof(
        userName: event.userName,
        dob: event.dob,
        identityProofList: event.identityProofList,
        oldKYCData: event.oldKYCData,
        email: event.email,
        phoneCode: event.phoneCode,
        phoneNumber: event.phoneNumber,
      ).then((value) => emit(KYCSubmitState(value)));
    }

    if (event is KYCUpdateAddressProofEvent) {
      emit(ApisBlocLoadingState());
      await updateKYCAddress(
        addressProofList: event.addressProofList,
        oldKYCData: event.oldKYCData,
        address: event.address,
        city: event.city,
        pinCode: event.pinCode,
        state: event.state,
        line1: event.line1,
        line2: event.line2,
        landmark: event.landmark,
      ).then((value) => emit(KYCSubmitState(value)));
    }

    if (event is DeleteKYCIdDocEvent) {
      emit(ApisBlocLoadingState());
      await deleteKycIdentityDoc(
              identityProof: event.identityProof,
              kycData: event.kycData,
              isFile: event.isFile)
          .then((value) => emit(DeleteKYCIdDocState(value)));
    }

    if (event is DeleteKYCAddressDocEvent) {
      emit(ApisBlocLoadingState());
      await deleteKycAddressDoc(
        identityProof: event.identityProof,
        kycData: event.kycData,
        isFile: event.isFile,
      ).then((value) => emit(DeleteKYCAddressDocState(value)));
    }

    if (event is GetKYCDetailEvent) {
      emit(ApisBlocLoadingState());
      await getKYCDetails().then((value) =>
          emit(GetKYCDetailState(value, showPreview: event.showPreview)));
    }

    if (event is GetKYCDocsListEvent) {
      emit(ApisBlocLoadingState());
      await getKYCDocsList().then((value) => emit(GetKYCDocsListState(value)));
    }

    if (event is GetKYCHistoryEvent) {
      await getKYCHistory(limit: event.limit, page: event.page)
          .then((value) => emit(GetKYCHistoryState(value)));
    }

    if (event is GetBanksListEvent) {
      emit(ApisBlocLoadingState());
      await getBanksList(accountType: event.accountType)
          .then((value) => emit(GetBanksListState(value)));
    }

    if (event is GetNotificationListEvent) {
      emit(ApisBlocLoadingState());
      await getNotificationsList(limit: event.limit, page: event.page).then(
          (value) =>
              emit(GetNotificationsListState(value, clear: event.clear)));
    }
    if (event is ReadNotificationEvent) {
      await readNotification(event.notificationId, event.readAll)
          .then((value) => emit(ReadNotificationState(value)));
    }

    if (event is BannersListEvent) {
      emit(ApisBlocLoadingState());
      await getBannersList(limit: event.limit, page: event.page)
          .then((value) => emit(BannersListState(value)));
    }

    if (event is BannersList2Event) {
      emit(ApisBlocLoadingState());
      await getBannersList2(limit: event.limit, page: event.page)
          .then((value) => emit(BannersListState(value)));
    }

    if (event is ClearNotificationsEvent) {
      await clearNotifications(event.notificationIds, clearAll: event.clearAll)
          .then((value) => emit(ClearNotificationsState(value)));
    }

    if (event is ContactUsEvent) {
      emit(ApisBlocLoadingState());
      try {
        await contactUs(
          fullname: event.fullname,
          email: event.email,
          phonenumber: event.phonenumber,
          message: event.message,
          type: event.type,
          queryImage: event.queryImage,
        ).then((value) => emit(ContactUsState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(message: e.toString()));
      }
    }

    if (event is CheckBeneficiaryAccountStatusEvent) {
      emit(ApisBlocLoadingState());
      try {
        await getReceiverAccountStatus(
          beneficiary: event.beneficiary,
          receiverType: event.receiverType,
          userType: event.userType,
        ).then((value) => emit(CheckBeneficiaryAccountStatusState(
            value: value,
            beneficiary: event.beneficiary,
            receiverType: event.receiverType,
            userType: event.userType,
            request: event.request,
            invoiceData: event.invoiceData)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is CouponListEvent) {
      emit(ApisBlocLoadingState());
      try {
        await getCouponList().then((value) => emit(CouponListState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is RequestToPayEvent) {
      emit(ApisBlocLoadingState());
      try {
        await requestTopay(
                amount: event.amount,
                receiverAccountId: event.receiverAccountId,
                txnNote: event.txnNote,
                requestReceiverPhoneCode: event.requestReceiverPhoneCode,
                requestReceiverPhoneNumber: event.requestReceiverPhoneNumber)
            .then((value) => emit(RequestToPayState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is PaymentRequestsByMeEvent) {
      try {
        await paymentRequestByMeList(limit: event.limit, page: event.page)
            .then((value) => emit(PaymentRequestsByMeState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is PaymentRequestsByOtherEvent) {
      try {
        await paymentRequestByOtherList(limit: event.limit, page: event.page)
            .then((value) => emit(PaymentRequestsByOtherState(value)));
      } catch (e) {
        emit(ApisBlocErrorState(
            message: HTTPExceptionMessage.serverExceptionMessage));
      }
    }

    if (event is OpenExpressAccountEvent) {
      emit(ApisBlocLoadingState());
      await openExpressAccount(
        body: event.body,
      ).then((value) => emit(OpenExpressAccountState(value)));
    }

    if (event is VerifyQREvent) {
      emit(ApisBlocLoadingState());
      await verifyQR(
        qrCode: event.qrCode,
        type: event.type,
      ).then((value) => emit(VerifyQRState(value)));
    }

    if (event is VerifyTxnQREvent) {
      emit(ApisBlocLoadingState());
      await verifyTxnQR(
        qrCode: event.qrCode,
        type: event.type,
      ).then((value) => emit(VerifyTxnQRState(value)));
    }

    if (event is InvoiceListEvent) {
      emit(ApisBlocLoadingState());
      await invoiceList(
              page: event.page, limit: event.limit, filter: event.filter)
          .then((value) => emit(InvoiceListState(value)));
    }

    if (event is InvoiceDetailEvent) {
      emit(ApisBlocLoadingState());
      await invoiceDetail(
        invoiceNumber: event.invoiceNumber,
      ).then((value) => emit(InvoiceDetailState(value)));
    }

    if (event is VerifyContactEvent) {
      emit(ApisBlocLoadingState());
      await verifyContact(
              receiverPhoneCode: event.receiverPhoneCode,
              receiverPhoneNumber: event.receiverPhoneNumber)
          .then((value) => emit(VerifyContactState(value)));
    }

    if (event is CheckContactExistEvent) {
      emit(ApisBlocLoadingState());
      await checkContactExist(
        receiverPhoneCode: event.receiverPhoneCode,
        receiverPhoneNumber: event.receiverPhoneNumber,
      ).then((value) => emit(CheckContactExistState(
            value,
            receiverPhoneCode: event.receiverPhoneCode,
            receiverPhoneNumber: event.receiverPhoneNumber,
          )));
    }

    if (event is GetAccountLimitEvent) {
      emit(ApisBlocLoadingState());
      await getAccountLimit().then((value) => emit(AccountLimitState(value)));
    }

    if (event is ResendVerificationLinkEvent) {
      emit(ApisBlocLoadingState());
      await resendVerificationLink(
              phoneCode: event.phoneCode, phone: event.phoneNumber)
          .then((value) => emit(ResendVerificationLinkState(value)));
    }

    if (event is GetQueriesEvent) {
      emit(ApisBlocLoadingState());
      await getQueries(
              page: event.page, limit: event.limit, filter: event.filter)
          .then((value) => emit(GetQueriesState(value)));
    }

    if (event is RejectPaymentRequestEvent) {
      emit(ApisBlocLoadingState());
      await rejectPaymentRequest(requestId: event.requestId)
          .then((value) => emit(RejectPaymentRequestState(value)));
    }

    if (event is GetPaymentRequestByIdEvent) {
      emit(ApisBlocLoadingState());
      await getPaymentRequestById(requestId: event.requestId)
          .then((value) => emit(GetPaymentRequestByIdState(value)));
    }

    if (event is GetOMChargesEvent) {
      emit(ApisBlocLoadingState());
      await getOmCharges(
              token: event.token,
              msisdnNumber: event.msisdnNumber,
              orderId: event.orderId)
          .then((value) => emit(GetOMChargesState(value)));
    }

    if (event is FinalizeOMPaymentEvent) {
      emit(ApisBlocLoadingState());
      await finalizeOMpayment(
              token: event.token,
              msisdnNumber: event.msisdnNumber,
              otp: event.otp,
              orderId: event.orderId)
          .then((value) => emit(FinalizeOMPaymentState(value)));
    }

    if (event is CheckoutOMTicketPaymentEvent) {
      emit(ApisBlocLoadingState());
      await checkoutOMTicketpayment(
        orderId: event.orderId,
      ).then((value) => emit(GetOrangeTxnStatusState(value)));
    }

    if (event is CancelOMTxnEvent) {
      emit(ApisBlocLoadingState());
      await cancelOMTxn(token: event.token, orderId: event.orderId)
          .then((value) => emit(CancelOMTxnState(value)));
    }

    if (event is GetSubscriptionsEvent) {
      emit(ApisBlocLoadingState());
      await getSubscriptions(
              page: event.page, limit: event.limit, filter: event.filter)
          .then((value) => emit(GetSubscriptionsState(value)));
    }

    if (event is GetSubscriptionByIdEvent) {
      emit(ApisBlocLoadingState());
      await getSubscriptionById(id: event.id)
          .then((value) => emit(GetSubscriptionByIdState(value)));
    }

    if (event is GetSubscriptionDetailEvent) {
      emit(ApisBlocLoadingState());
      await getSubscriptionDetails(id: event.id)
          .then((value) => emit(GetSubscriptionDetailState(value)));
    }

    if (event is GetSubscribersEvent) {
      emit(ApisBlocLoadingState());
      await getSubscribers(page: event.page, limit: event.limit)
          .then((value) => emit(GetSubscribersState(value)));
    }

    if (event is GetTypeOfQueriesEvent) {
      emit(ApisBlocLoadingState());
      await getTypeOfQueries()
          .then((value) => emit(GetTypeOfQueriesState(value)));
    }

    if (event is QueryDetailEvent) {
      emit(ApisBlocLoadingState());
      await getQueryDetail(queryId: event.queryId)
          .then((value) => emit(QueryDetailState(value)));
    }

    if (event is CloseQueryEvent) {
      emit(ApisBlocLoadingState());
      await closeQuery(queryId: event.queryId)
          .then((value) => emit(CloseQueryState(value)));
    }

    if (event is ReplyQueryEvent) {
      emit(ApisBlocLoadingState());
      await replyQuery(
              queryId: event.queryId,
              message: event.message,
              queryImage: event.queryImage)
          .then((value) => emit(ReplyQueryState(value)));
    }

    if (event is GetStateCitiesEvent) {
      emit(ApisBlocLoadingState());
      await getStateCitiesList()
          .then((value) => emit(GetStateCitiesState(value)));
    }

    if (event is GetCardsListEvent) {
      emit(ApisBlocLoadingState());
      await getCardsList(limit: event.limit, page: event.page)
          .then((value) => emit(GetCardsListState(value)));
    }

    if (event is GetThirdPartyListEvent) {
      emit(ApisBlocLoadingState());
      await getThirdPartyList()
          .then((value) => emit(GetThirdPartyListState(value)));
    }

    if (event is DeleteCustomerAccountEvent) {
      emit(ApisBlocLoadingState());
      await deleteCustomerAccount()
          .then((value) => emit(DeleteCustomerAccountState(value)));
    }

    if (event is GetFAQsEvent) {
      emit(ApisBlocLoadingState());
      await getFAQs(limit: event.limit, page: event.page)
          .then((value) => emit(GetFAQsState(value)));
    }
    return null;
  }
}
