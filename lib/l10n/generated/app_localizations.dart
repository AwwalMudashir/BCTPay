import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @aadharCard.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Card'**
  String get aadharCard;

  /// No description provided for @acceptedHere.
  ///
  /// In en, this message translates to:
  /// **'Accepted Here'**
  String get acceptedHere;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @accountAddedOn.
  ///
  /// In en, this message translates to:
  /// **'Account Added On'**
  String get accountAddedOn;

  /// No description provided for @accountAddedOnAccDetail.
  ///
  /// In en, this message translates to:
  /// **'Account Added On'**
  String get accountAddedOnAccDetail;

  /// No description provided for @accountAddedOnBeneficiaryDetail.
  ///
  /// In en, this message translates to:
  /// **'Account Added On'**
  String get accountAddedOnBeneficiaryDetail;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account Created!'**
  String get accountCreated;

  /// No description provided for @accountDetail.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetail;

  /// No description provided for @accountDetailDrawer.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetailDrawer;

  /// No description provided for @accountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accountHolderName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @addBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get addBankAccount;

  /// No description provided for @addBankAccountSelfTransfer.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get addBankAccountSelfTransfer;

  /// No description provided for @addBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Add Beneficiary'**
  String get addBeneficiary;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressVerification.
  ///
  /// In en, this message translates to:
  /// **'Address Verification'**
  String get addressVerification;

  /// No description provided for @addressVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In Order To Completed Your KYC, Please Upload A Copy Of Your Address Proof'**
  String get addressVerificationDesc;

  /// No description provided for @adminCommision.
  ///
  /// In en, this message translates to:
  /// **'Admin Commision: '**
  String get adminCommision;

  /// No description provided for @adminFee.
  ///
  /// In en, this message translates to:
  /// **'Admin Fee'**
  String get adminFee;

  /// No description provided for @alignQRCodeWithinFrameToScan.
  ///
  /// In en, this message translates to:
  /// **'Align QR Code Within Frame To Scan'**
  String get alignQRCodeWithinFrameToScan;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get allTransactions;

  /// No description provided for @alreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Already Paid'**
  String get alreadyPaid;

  /// No description provided for @alreadyPaidInvoice.
  ///
  /// In en, this message translates to:
  /// **'Already Paid'**
  String get alreadyPaidInvoice;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountRequestedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Amount Requested Successfully'**
  String get amountRequestedSuccessfully;

  /// No description provided for @amountShouldBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount Should Be Greater Than 0'**
  String get amountShouldBeGreaterThanZero;

  /// No description provided for @amountShouldBeGreaterThanZeroSubscription.
  ///
  /// In en, this message translates to:
  /// **'Amount Should Be Greater Than 0'**
  String get amountShouldBeGreaterThanZeroSubscription;

  /// No description provided for @amountShouldNotBeGreaterThan.
  ///
  /// In en, this message translates to:
  /// **'Amount Should Not Be Greater Than'**
  String get amountShouldNotBeGreaterThan;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @applyCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyCouponCode;

  /// No description provided for @applyInvoiceFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyInvoiceFilter;

  /// No description provided for @applyQueriesFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyQueriesFilter;

  /// No description provided for @applySubscriptionFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applySubscriptionFilter;

  /// No description provided for @applyTxnFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyTxnFilter;

  /// No description provided for @asPerDocument.
  ///
  /// In en, this message translates to:
  /// **'As Per Document'**
  String get asPerDocument;

  /// No description provided for @authenticationIsRequiredToAccessTheBCTPayApp.
  ///
  /// In en, this message translates to:
  /// **'Authentication Is Required To Access The BCTPay App.'**
  String get authenticationIsRequiredToAccessTheBCTPayApp;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @availableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots'**
  String get availableSlots;

  /// No description provided for @bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds.
  ///
  /// In en, this message translates to:
  /// **'Reach A Wider Audience With BCTPay\'s Targeted Campaigns Tailored To Your Business Needs.'**
  String
      get bCTPayCanHelpYouReachAWideUserBaseWithTargetedCampaignsDesignedToMeetYourBusinessNeeds;

  /// No description provided for @bCTPayIsLocked.
  ///
  /// In en, this message translates to:
  /// **'BCTPay Is Locked'**
  String get bCTPayIsLocked;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @backImage.
  ///
  /// In en, this message translates to:
  /// **'Back Image'**
  String get backImage;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @balanceBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You Will Go To The Accounts List For Checking Balance By Pressing Balance Button.'**
  String get balanceBtnDescription;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @bankCode.
  ///
  /// In en, this message translates to:
  /// **'Bank Code'**
  String get bankCode;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get bankName;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get bankTransfer;

  /// No description provided for @banksAndWallets.
  ///
  /// In en, this message translates to:
  /// **'Banks & Wallets'**
  String get banksAndWallets;

  /// No description provided for @bctPayFee.
  ///
  /// In en, this message translates to:
  /// **'BCTPay Fee'**
  String get bctPayFee;

  /// No description provided for @beneficiaryDetail.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Detail'**
  String get beneficiaryDetail;

  /// No description provided for @beneficiaryList.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary List'**
  String get beneficiaryList;

  /// No description provided for @beneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Name'**
  String get beneficiaryName;

  /// No description provided for @bill.
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get bill;

  /// No description provided for @billers.
  ///
  /// In en, this message translates to:
  /// **'Billers'**
  String get billers;

  /// No description provided for @billsNSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Bills & Subscriptions'**
  String get billsNSubscriptions;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @cantAddMoreAccountsForThisBankYouHaveReachedTheLimit.
  ///
  /// In en, this message translates to:
  /// **'Can\'t Add More Accounts For This Bank. You\'ve Reached The Limit.'**
  String get cantAddMoreAccountsForThisBankYouHaveReachedTheLimit;

  /// No description provided for @cantResendOTPAgainMsg.
  ///
  /// In en, this message translates to:
  /// **'You can’t resend the OTP again. Please restart the process from the beginning.'**
  String get cantResendOTPAgainMsg;

  /// No description provided for @capture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get capture;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @checkBalance.
  ///
  /// In en, this message translates to:
  /// **'Check Balance'**
  String get checkBalance;

  /// No description provided for @checkBalanceBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Check Wallet Balance As Well As Bank Account Balance Or You Can Manage Your Accounts Like You Can Add, Active, Inactive, Set Primary Account Or You Can Delete Account.'**
  String get checkBalanceBtnDescription;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotifications;

  /// No description provided for @clientId.
  ///
  /// In en, this message translates to:
  /// **'Client ID'**
  String get clientId;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @closeQuery.
  ///
  /// In en, this message translates to:
  /// **'Close Query'**
  String get closeQuery;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmContactDialogDesc.
  ///
  /// In en, this message translates to:
  /// **'Please Confirm The Contact Number'**
  String get confirmContactDialogDesc;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @congratulationsYourAccountHasBeenSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Account Has Been Successfully Created. A Verification Link Has Been Sent To Your Email. Please Check Your Inbox And Verify Your Account.'**
  String get congratulationsYourAccountHasBeenSuccessfullyCreated;

  /// No description provided for @congratulationsYourAccountHasBeenSuccessfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your Account Has Been Successfully Updated.'**
  String get congratulationsYourAccountHasBeenSuccessfullyUpdated;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @contactPermission.
  ///
  /// In en, this message translates to:
  /// **'Contact Permission'**
  String get contactPermission;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @continue1.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue1;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get countryCode;

  /// No description provided for @couponTnc.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get couponTnc;

  /// No description provided for @coupons.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons;

  /// No description provided for @customerId.
  ///
  /// In en, this message translates to:
  /// **'Customer ID'**
  String get customerId;

  /// No description provided for @cylinder.
  ///
  /// In en, this message translates to:
  /// **'Cylinder'**
  String get cylinder;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @dataBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore Purchasing Data Packages Before Your Visit To Potentially Benefit From Discounted Rates.'**
  String get dataBtnDescription;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @debitedFrom.
  ///
  /// In en, this message translates to:
  /// **'Debited From'**
  String get debitedFrom;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @developerModeDialogDiscription.
  ///
  /// In en, this message translates to:
  /// **'Developer Mode Is Enabled. Please Disable It To Access The BCTPay App.'**
  String get developerModeDialogDiscription;

  /// No description provided for @dialogTitleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get dialogTitleSuccess;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t Receive Code?'**
  String get didntReceiveCode;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @discountInvoice.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discountInvoice;

  /// No description provided for @doYouHaveAPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Do You Have A Promo Code?'**
  String get doYouHaveAPromoCode;

  /// No description provided for @doYouReallyWantToDeleteThisAccount.
  ///
  /// In en, this message translates to:
  /// **'Do You Really Want To Delete This Account?'**
  String get doYouReallyWantToDeleteThisAccount;

  /// No description provided for @doYouReallyWantToExitTheApp.
  ///
  /// In en, this message translates to:
  /// **'Do You Really Want To Exit The App?'**
  String get doYouReallyWantToExitTheApp;

  /// No description provided for @doYouReallyWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Do You Really Want To Logout?'**
  String get doYouReallyWantToLogout;

  /// No description provided for @doYouReallyWantToUpdateProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Do You Really Want To Update Profile Image?'**
  String get doYouReallyWantToUpdateProfileImage;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get dob;

  /// No description provided for @docIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Document ID Number'**
  String get docIdNumber;

  /// No description provided for @docType.
  ///
  /// In en, this message translates to:
  /// **'Doc Type'**
  String get docType;

  /// No description provided for @documentType.
  ///
  /// In en, this message translates to:
  /// **'Document Type'**
  String get documentType;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dontWorryItHappensPleaseEnterTheAdressAssociatedWithYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Worry, It Happens! Please Enter The Address Associated With Your Account.'**
  String get dontWorryItHappensPleaseEnterTheAdressAssociatedWithYourAccount;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @drawerBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Get List Of Settings In The Side Menu.'**
  String get drawerBtnDescription;

  /// No description provided for @drivingLicence.
  ///
  /// In en, this message translates to:
  /// **'Driving Licence'**
  String get drivingLicence;

  /// No description provided for @dth.
  ///
  /// In en, this message translates to:
  /// **'DTH'**
  String get dth;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @dueOn.
  ///
  /// In en, this message translates to:
  /// **'Due On'**
  String get dueOn;

  /// No description provided for @easiestWayToManage.
  ///
  /// In en, this message translates to:
  /// **'Easiest Way To Manage Your Finances'**
  String get easiestWayToManage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricity;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enjoy.
  ///
  /// In en, this message translates to:
  /// **'Enjoy'**
  String get enjoy;

  /// No description provided for @enterAccountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Holder Name'**
  String get enterAccountHolderName;

  /// No description provided for @enterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Account Number'**
  String get enterAccountNumber;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get enterAddress;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @enterBankCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Bank Code'**
  String get enterBankCode;

  /// No description provided for @enterBankName.
  ///
  /// In en, this message translates to:
  /// **'Enter Bank Name'**
  String get enterBankName;

  /// No description provided for @enterBeneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Enter Beneficiary Name'**
  String get enterBeneficiaryName;

  /// No description provided for @enterCity.
  ///
  /// In en, this message translates to:
  /// **'Enter City'**
  String get enterCity;

  /// No description provided for @enterClientId.
  ///
  /// In en, this message translates to:
  /// **'Enter Client ID'**
  String get enterClientId;

  /// No description provided for @enterConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm New Password'**
  String get enterConfirmNewPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm Password'**
  String get enterConfirmPassword;

  /// No description provided for @enterCountry.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get enterCountry;

  /// No description provided for @enterDOB.
  ///
  /// In en, this message translates to:
  /// **'Enter DOB'**
  String get enterDOB;

  /// No description provided for @enterDocId.
  ///
  /// In en, this message translates to:
  /// **'Enter Document ID Number'**
  String get enterDocId;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Email Address'**
  String get enterEmailAddress;

  /// No description provided for @enterInstitutionCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Institution Code'**
  String get enterInstitutionCode;

  /// No description provided for @enterInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Enter Institution Name'**
  String get enterInstitutionName;

  /// No description provided for @enterLandmark.
  ///
  /// In en, this message translates to:
  /// **'Enter Landmark'**
  String get enterLandmark;

  /// No description provided for @enterLine1.
  ///
  /// In en, this message translates to:
  /// **'Enter Line1'**
  String get enterLine1;

  /// No description provided for @enterLine2.
  ///
  /// In en, this message translates to:
  /// **'Enter Line2'**
  String get enterLine2;

  /// No description provided for @enterMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Message'**
  String get enterMessage;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enterMobileNumber;

  /// No description provided for @enterMomoId.
  ///
  /// In en, this message translates to:
  /// **'Enter MOMO ID'**
  String get enterMomoId;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enterOldPassword;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get enterPassword;

  /// No description provided for @enterPaymentNote.
  ///
  /// In en, this message translates to:
  /// **'Enter Payment Note'**
  String get enterPaymentNote;

  /// No description provided for @enterPaymentNoteRequestToPay.
  ///
  /// In en, this message translates to:
  /// **'Enter Payment Note'**
  String get enterPaymentNoteRequestToPay;

  /// No description provided for @enterPhoneScreenLockPatternPINPasswordOrFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Screen Lock Pattern, PIN, Password Or Fingerprint'**
  String get enterPhoneScreenLockPatternPINPasswordOrFingerprint;

  /// No description provided for @enterPinCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Pincode'**
  String get enterPinCode;

  /// No description provided for @enterTxnId.
  ///
  /// In en, this message translates to:
  /// **'Enter Transaction ID'**
  String get enterTxnId;

  /// No description provided for @enterWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Wallet Phone Number'**
  String get enterWalletPhoneNumber;

  /// No description provided for @enterYourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your First Name'**
  String get enterYourFirstName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterYourFullName;

  /// No description provided for @enterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Last Name'**
  String get enterYourLastName;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @failedTransactions.
  ///
  /// In en, this message translates to:
  /// **'Failed transactions'**
  String get failedTransactions;

  /// No description provided for @failedDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failedDialogTitle;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @faqScreenDesc.
  ///
  /// In en, this message translates to:
  /// **'At BCTPay we expect at a day\'s start is you, better and happier than yesterday. We have got you covered—share your concern or check our frequently asked questions listed below.'**
  String get faqScreenDesc;

  /// No description provided for @faqScreenHeading.
  ///
  /// In en, this message translates to:
  /// **'We’re here to help you with anything and everything on BCTPay'**
  String get faqScreenHeading;

  /// No description provided for @faster.
  ///
  /// In en, this message translates to:
  /// **'Faster'**
  String get faster;

  /// No description provided for @feeDetails.
  ///
  /// In en, this message translates to:
  /// **'Fee Details'**
  String get feeDetails;

  /// No description provided for @fees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get fees;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @fileDownloaded.
  ///
  /// In en, this message translates to:
  /// **'File Downloaded'**
  String get fileDownloaded;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @forYou.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get forYou;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @frontImage.
  ///
  /// In en, this message translates to:
  /// **'Front Image'**
  String get frontImage;

  /// No description provided for @full.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get full;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @giftCard.
  ///
  /// In en, this message translates to:
  /// **'Gift Card'**
  String get giftCard;

  /// No description provided for @giftCardBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose The Specific Gift Card Brand And Desired Value Based On Your Needs And Preferences.'**
  String get giftCardBtnDescription;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @grossTotal.
  ///
  /// In en, this message translates to:
  /// **'Gross Total'**
  String get grossTotal;

  /// No description provided for @hasBeenSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Has Been Sent Successfully.'**
  String get hasBeenSentSuccessfully;

  /// No description provided for @helloThereSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Hello There! Sign In To Continue.'**
  String get helloThereSignInToContinue;

  /// No description provided for @helpNSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpNSupport;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @historyBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You Will Go To The Transaction History List By Pressing History Button.'**
  String get historyBtnDescription;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @homeBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You Will Go To The Dashboard By Pressing Home Button.'**
  String get homeBtnDescription;

  /// No description provided for @howMuchYouWantToSend.
  ///
  /// In en, this message translates to:
  /// **'How Much You Want To Send?'**
  String get howMuchYouWantToSend;

  /// No description provided for @howMuchYouWantToSendSubscription.
  ///
  /// In en, this message translates to:
  /// **'How Much You Want To Send?'**
  String get howMuchYouWantToSendSubscription;

  /// No description provided for @idVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In Order To Completed Your KYC, Please Upload A Copy Of Your Identity Document'**
  String get idVerificationDesc;

  /// No description provided for @identityVerification.
  ///
  /// In en, this message translates to:
  /// **'Identity Verification'**
  String get identityVerification;

  /// No description provided for @ifNotChosenYoullNeedToManuallyEnterYourCardDetailsInTheNextStep.
  ///
  /// In en, this message translates to:
  /// **'If Not Chosen, You\'ll Need To Manually Enter Your Card Details In The Next Step'**
  String get ifNotChosenYoullNeedToManuallyEnterYourCardDetailsInTheNextStep;

  /// No description provided for @importQRCode.
  ///
  /// In en, this message translates to:
  /// **'Import QR Code'**
  String get importQRCode;

  /// No description provided for @inActive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inActive;

  /// No description provided for @includesALetterDigitAndSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Includes A Letter, Digit, And Special Character'**
  String get includesALetterDigitAndSpecialCharacter;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @initiated.
  ///
  /// In en, this message translates to:
  /// **'Initiated'**
  String get initiated;

  /// No description provided for @institutionCode.
  ///
  /// In en, this message translates to:
  /// **'Institution Code'**
  String get institutionCode;

  /// No description provided for @institutionName.
  ///
  /// In en, this message translates to:
  /// **'Institution Name'**
  String get institutionName;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @invoiceAlreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Invoice Already Paid. View Payment Details'**
  String get invoiceAlreadyPaid;

  /// No description provided for @invoiceDate.
  ///
  /// In en, this message translates to:
  /// **'Invoice Date'**
  String get invoiceDate;

  /// No description provided for @invoiceDetail.
  ///
  /// In en, this message translates to:
  /// **'Invoice Detail'**
  String get invoiceDetail;

  /// No description provided for @invoiceGeneratedBy.
  ///
  /// In en, this message translates to:
  /// **'Invoice Generated By'**
  String get invoiceGeneratedBy;

  /// No description provided for @invoiceItems.
  ///
  /// In en, this message translates to:
  /// **'Invoice Items'**
  String get invoiceItems;

  /// No description provided for @invoiceNote.
  ///
  /// In en, this message translates to:
  /// **'Invoice Note'**
  String get invoiceNote;

  /// No description provided for @invoiceTNC.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get invoiceTNC;

  /// No description provided for @issuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued On'**
  String get issuedOn;

  /// No description provided for @joinedUsBefore.
  ///
  /// In en, this message translates to:
  /// **'Joined Us Before?'**
  String get joinedUsBefore;

  /// No description provided for @kyc.
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get kyc;

  /// No description provided for @kycDetails.
  ///
  /// In en, this message translates to:
  /// **'KYC Details'**
  String get kycDetails;

  /// No description provided for @kycDocuments.
  ///
  /// In en, this message translates to:
  /// **'KYC Documents'**
  String get kycDocuments;

  /// No description provided for @kycHistory.
  ///
  /// In en, this message translates to:
  /// **'KYC History'**
  String get kycHistory;

  /// No description provided for @kycNotApprovedDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Your KYC Is Not Approved Yet, Please Update Your KYC To Make Transactions.'**
  String get kycNotApprovedDialogMessage;

  /// No description provided for @kycPending.
  ///
  /// In en, this message translates to:
  /// **'KYC Pending'**
  String get kycPending;

  /// No description provided for @kycStatus.
  ///
  /// In en, this message translates to:
  /// **'KYC Status'**
  String get kycStatus;

  /// No description provided for @kycType.
  ///
  /// In en, this message translates to:
  /// **'KYC Type'**
  String get kycType;

  /// No description provided for @landmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get landmark;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @lateFee.
  ///
  /// In en, this message translates to:
  /// **'Late Fee'**
  String get lateFee;

  /// No description provided for @leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon.
  ///
  /// In en, this message translates to:
  /// **'Leave Us A Message About Your Questions Or Inquiries And Someone From Our Team Will Be In Touch Soon.'**
  String
      get leaveUsAMessageAboutYourQuestionsOrInquiriesAndSomeoneFromOurTeamWillBeInTouchSoon;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @line1.
  ///
  /// In en, this message translates to:
  /// **'Line1'**
  String get line1;

  /// No description provided for @line2.
  ///
  /// In en, this message translates to:
  /// **'Line2'**
  String get line2;

  /// No description provided for @linkedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Linked Accounts'**
  String get linkedAccounts;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @makeOnline.
  ///
  /// In en, this message translates to:
  /// **'Make Online'**
  String get makeOnline;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @maxLimitIs.
  ///
  /// In en, this message translates to:
  /// **'Max Limit Is {amount}'**
  String maxLimitIs(Object amount);

  /// No description provided for @maximumTransferLimitIs.
  ///
  /// In en, this message translates to:
  /// **'Maximum Transfer Limit Is {amount}'**
  String maximumTransferLimitIs(Object amount);

  /// No description provided for @meetYourBusiness.
  ///
  /// In en, this message translates to:
  /// **'Meet Your Business Needs'**
  String get meetYourBusiness;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @minimumOrderValueIs.
  ///
  /// In en, this message translates to:
  /// **'Minimum Order Value Is'**
  String get minimumOrderValueIs;

  /// No description provided for @minimumTransferLimitIs.
  ///
  /// In en, this message translates to:
  /// **'Minimum Transfer Limit Is {amount}'**
  String minimumTransferLimitIs(Object amount);

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No.'**
  String get mobileNo;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @mobileNumberDoesntExist.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number Doesn\'t Exist'**
  String get mobileNumberDoesntExist;

  /// No description provided for @mobileOperators.
  ///
  /// In en, this message translates to:
  /// **'Mobile Operators'**
  String get mobileOperators;

  /// No description provided for @mobileRecharge.
  ///
  /// In en, this message translates to:
  /// **'Mobile Recharge'**
  String get mobileRecharge;

  /// No description provided for @momoId.
  ///
  /// In en, this message translates to:
  /// **'MOMO ID'**
  String get momoId;

  /// No description provided for @mtnMoMo.
  ///
  /// In en, this message translates to:
  /// **'MTN MoMo'**
  String get mtnMoMo;

  /// No description provided for @myBills.
  ///
  /// In en, this message translates to:
  /// **'My Bills'**
  String get myBills;

  /// No description provided for @myContact.
  ///
  /// In en, this message translates to:
  /// **'My Contact'**
  String get myContact;

  /// No description provided for @myQRCode.
  ///
  /// In en, this message translates to:
  /// **'My QR Code'**
  String get myQRCode;

  /// No description provided for @mySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'My Subscriptions'**
  String get mySubscriptions;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get name;

  /// No description provided for @newContact.
  ///
  /// In en, this message translates to:
  /// **'New Contact'**
  String get newContact;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @newPrimary.
  ///
  /// In en, this message translates to:
  /// **'New Primary'**
  String get newPrimary;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'No Account'**
  String get noAccount;

  /// No description provided for @noBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'No beneficiary available'**
  String get noBeneficiary;

  /// No description provided for @noContacts.
  ///
  /// In en, this message translates to:
  /// **'No Contacts'**
  String get noContacts;

  /// No description provided for @noCountry.
  ///
  /// In en, this message translates to:
  /// **'No Country'**
  String get noCountry;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @noDocumentTypeAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Document Type Available'**
  String get noDocumentTypeAvailable;

  /// No description provided for @noKycHistory.
  ///
  /// In en, this message translates to:
  /// **'No KYC History'**
  String get noKycHistory;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotifications;

  /// No description provided for @noPermissionToUpdateText.
  ///
  /// In en, this message translates to:
  /// **'Looking Like You Don\'t Have Permission To Update Or You Have Not Added Mandatory Data'**
  String get noPermissionToUpdateText;

  /// No description provided for @noPlans.
  ///
  /// In en, this message translates to:
  /// **'No Plans'**
  String get noPlans;

  /// No description provided for @noPrimaryAccount.
  ///
  /// In en, this message translates to:
  /// **'No Primary Account'**
  String get noPrimaryAccount;

  /// No description provided for @noProviders.
  ///
  /// In en, this message translates to:
  /// **'No Providers'**
  String get noProviders;

  /// No description provided for @noQuery.
  ///
  /// In en, this message translates to:
  /// **'No Query'**
  String get noQuery;

  /// No description provided for @noQueryMessage.
  ///
  /// In en, this message translates to:
  /// **'No tickets found. Need assistance? Raise a ticket and we\'ll be happy to help! '**
  String get noQueryMessage;

  /// No description provided for @noRegions.
  ///
  /// In en, this message translates to:
  /// **'No Regions'**
  String get noRegions;

  /// No description provided for @noRequest.
  ///
  /// In en, this message translates to:
  /// **'No Request'**
  String get noRequest;

  /// No description provided for @noThanks.
  ///
  /// In en, this message translates to:
  /// **'No Thanks'**
  String get noThanks;

  /// No description provided for @noTransaction.
  ///
  /// In en, this message translates to:
  /// **'No Transaction'**
  String get noTransaction;

  /// No description provided for @noValidityFound.
  ///
  /// In en, this message translates to:
  /// **'No Validity Found'**
  String get noValidityFound;

  /// No description provided for @noWallet.
  ///
  /// In en, this message translates to:
  /// **'No Wallet'**
  String get noWallet;

  /// No description provided for @notAMember.
  ///
  /// In en, this message translates to:
  /// **'Not A Member?'**
  String get notAMember;

  /// No description provided for @notActive.
  ///
  /// In en, this message translates to:
  /// **'Not Active'**
  String get notActive;

  /// No description provided for @notAllowed.
  ///
  /// In en, this message translates to:
  /// **'Not Allowed'**
  String get notAllowed;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @notVerified.
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get notVerified;

  /// No description provided for @noteDocFormates.
  ///
  /// In en, this message translates to:
  /// **'Note: Supported Document Formats Are PNG, JPG, JPEG.'**
  String get noteDocFormates;

  /// No description provided for @notePlatformFeeWillBeImposedOnSenderForThisTransaction.
  ///
  /// In en, this message translates to:
  /// **'Note: Platform Fee Will Be Imposed On Sender For This Transaction.'**
  String get notePlatformFeeWillBeImposedOnSenderForThisTransaction;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You Will Go To The Notifications List By Pressing Notifications Button.'**
  String get notificationsBtnDescription;

  /// No description provided for @ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Oh No! The OTP Timed Out. Please Request A New Code And Try Again.'**
  String get ohNoTheOTPTimedOutPleaseRequestANewCodeAndTryAgain;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @oldPrimary.
  ///
  /// In en, this message translates to:
  /// **'Old Primary'**
  String get oldPrimary;

  /// No description provided for @oneTime.
  ///
  /// In en, this message translates to:
  /// **'One time'**
  String get oneTime;

  /// No description provided for @oopsNoInternet.
  ///
  /// In en, this message translates to:
  /// **'Oops! No Internet.'**
  String get oopsNoInternet;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @openAccount.
  ///
  /// In en, this message translates to:
  /// **'Open Account'**
  String get openAccount;

  /// No description provided for @openAppSetting.
  ///
  /// In en, this message translates to:
  /// **'Open App Setting'**
  String get openAppSetting;

  /// No description provided for @openXpressAccount.
  ///
  /// In en, this message translates to:
  /// **'Open Ecobank Xpress Account'**
  String get openXpressAccount;

  /// No description provided for @openXpressAccountViewTitle.
  ///
  /// In en, this message translates to:
  /// **'Open An Ecobank Xpress Account Instantly With BCTPay'**
  String get openXpressAccountViewTitle;

  /// No description provided for @orangeMoney.
  ///
  /// In en, this message translates to:
  /// **'Orange Money'**
  String get orangeMoney;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @ownedBy.
  ///
  /// In en, this message translates to:
  /// **'Owned By'**
  String get ownedBy;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @paidTo.
  ///
  /// In en, this message translates to:
  /// **'Paid To'**
  String get paidTo;

  /// No description provided for @panCard.
  ///
  /// In en, this message translates to:
  /// **'PAN Card'**
  String get panCard;

  /// No description provided for @partial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get partial;

  /// No description provided for @partiallyPaid.
  ///
  /// In en, this message translates to:
  /// **'Partially Paid'**
  String get partiallyPaid;

  /// No description provided for @passport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordIsNotMatching.
  ///
  /// In en, this message translates to:
  /// **'Password Is Not Matching'**
  String get passwordIsNotMatching;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @payWith.
  ///
  /// In en, this message translates to:
  /// **'Pay With'**
  String get payWith;

  /// No description provided for @payable.
  ///
  /// In en, this message translates to:
  /// **'Payable'**
  String get payable;

  /// No description provided for @payableAmount.
  ///
  /// In en, this message translates to:
  /// **'Payable Amount'**
  String get payableAmount;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentDate.
  ///
  /// In en, this message translates to:
  /// **'Payment Date'**
  String get paymentDate;

  /// No description provided for @paymentDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Payment Date And Time'**
  String get paymentDateAndTime;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentN.
  ///
  /// In en, this message translates to:
  /// **'Payment &'**
  String get paymentN;

  /// No description provided for @paymentNote.
  ///
  /// In en, this message translates to:
  /// **'Payment Note'**
  String get paymentNote;

  /// No description provided for @paymentNoteRequestToPay.
  ///
  /// In en, this message translates to:
  /// **'Payment Note'**
  String get paymentNoteRequestToPay;

  /// No description provided for @paymentRequests.
  ///
  /// In en, this message translates to:
  /// **'Payment Requests'**
  String get paymentRequests;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment Success!'**
  String get paymentSuccess;

  /// No description provided for @paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment Type'**
  String get paymentType;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number: '**
  String get phoneNumber;

  /// No description provided for @pinCode.
  ///
  /// In en, this message translates to:
  /// **'Pincode'**
  String get pinCode;

  /// No description provided for @planDetails.
  ///
  /// In en, this message translates to:
  /// **'Plan Details'**
  String get planDetails;

  /// No description provided for @pleaseAcceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Please Accept Terms & Conditions'**
  String get pleaseAcceptTermsAndConditions;

  /// No description provided for @pleaseAddAtleastOneactiveAccount.
  ///
  /// In en, this message translates to:
  /// **'Please Add Atleast One Active Account'**
  String get pleaseAddAtleastOneactiveAccount;

  /// No description provided for @pleaseCheckYourNetworkConnection.
  ///
  /// In en, this message translates to:
  /// **'Please Check Your Network Connection.'**
  String get pleaseCheckYourNetworkConnection;

  /// No description provided for @pleaseEnterAccountHolderName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Account Holder Name'**
  String get pleaseEnterAccountHolderName;

  /// No description provided for @pleaseEnterAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Account Number'**
  String get pleaseEnterAccountNumber;

  /// No description provided for @pleaseEnterBeneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Beneficiary Name'**
  String get pleaseEnterBeneficiaryName;

  /// No description provided for @pleaseEnterClientID.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Client ID'**
  String get pleaseEnterClientID;

  /// No description provided for @pleaseEnterInstitutionCode.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Institution Code'**
  String get pleaseEnterInstitutionCode;

  /// No description provided for @pleaseEnterLandmark.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Landmark'**
  String get pleaseEnterLandmark;

  /// No description provided for @pleaseEnterLine1.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Line1'**
  String get pleaseEnterLine1;

  /// No description provided for @pleaseEnterLine2.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Line2'**
  String get pleaseEnterLine2;

  /// No description provided for @pleaseEnterMessage.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Message'**
  String get pleaseEnterMessage;

  /// No description provided for @pleaseEnterOTP.
  ///
  /// In en, this message translates to:
  /// **'Please Enter OTP'**
  String get pleaseEnterOTP;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @pleaseEnterValidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Mobile Number'**
  String get pleaseEnterValidMobileNumber;

  /// No description provided for @pleaseEnterValidValue.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Value'**
  String get pleaseEnterValidValue;

  /// No description provided for @pleaseEnterValidWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Wallet Phone Number'**
  String get pleaseEnterValidWalletPhoneNumber;

  /// No description provided for @pleaseEnterWalletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Wallet Phone Number'**
  String get pleaseEnterWalletPhoneNumber;

  /// No description provided for @pleaseEnterYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Address'**
  String get pleaseEnterYourAddress;

  /// No description provided for @pleaseEnterYourCity.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your City'**
  String get pleaseEnterYourCity;

  /// No description provided for @pleaseEnterYourConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Confirm New Password'**
  String get pleaseEnterYourConfirmNewPassword;

  /// No description provided for @pleaseEnterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Confirm Password'**
  String get pleaseEnterYourConfirmPassword;

  /// No description provided for @pleaseEnterYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Country'**
  String get pleaseEnterYourCountry;

  /// No description provided for @pleaseEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Email Address'**
  String get pleaseEnterYourEmailAddress;

  /// No description provided for @pleaseEnterYourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your First Name'**
  String get pleaseEnterYourFirstName;

  /// No description provided for @pleaseEnterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Full Name'**
  String get pleaseEnterYourFullName;

  /// No description provided for @pleaseEnterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Last Name'**
  String get pleaseEnterYourLastName;

  /// No description provided for @pleaseEnterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Mobile Number'**
  String get pleaseEnterYourMobileNumber;

  /// No description provided for @pleaseEnterYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your New Password'**
  String get pleaseEnterYourNewPassword;

  /// No description provided for @pleaseEnterYourOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Old Password'**
  String get pleaseEnterYourOldPassword;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Your Password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseEnterYourValidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Email Address'**
  String get pleaseEnterYourValidEmailAddress;

  /// No description provided for @pleaseLoginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please Login To Continue'**
  String get pleaseLoginToContinue;

  /// No description provided for @pleaseSelectAPlanWhichIsUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Please Select A Plan Which Is Unpaid Or Partially Paid'**
  String get pleaseSelectAPlanWhichIsUnpaid;

  /// No description provided for @pleaseSelectAllMandatoryField.
  ///
  /// In en, this message translates to:
  /// **'Please Select All Mandatory Field'**
  String get pleaseSelectAllMandatoryField;

  /// No description provided for @pleaseSelectBackImage.
  ///
  /// In en, this message translates to:
  /// **'Please Select Back Image'**
  String get pleaseSelectBackImage;

  /// No description provided for @pleaseSelectCountryPhoneCode.
  ///
  /// In en, this message translates to:
  /// **'Please Select Country Phone Code'**
  String get pleaseSelectCountryPhoneCode;

  /// No description provided for @pleaseSelectFrontImage.
  ///
  /// In en, this message translates to:
  /// **'Please Select Front Image'**
  String get pleaseSelectFrontImage;

  /// No description provided for @pleaseSelectInstitutionName.
  ///
  /// In en, this message translates to:
  /// **'Please Select Institution Name'**
  String get pleaseSelectInstitutionName;

  /// No description provided for @pleaseSelectValidDate.
  ///
  /// In en, this message translates to:
  /// **'Please Select Valid Date'**
  String get pleaseSelectValidDate;

  /// No description provided for @pleaseSelectYourState.
  ///
  /// In en, this message translates to:
  /// **'Please Select Your State'**
  String get pleaseSelectYourState;

  /// No description provided for @pleaseSignUpToContinue.
  ///
  /// In en, this message translates to:
  /// **'Please Sign Up To Continue'**
  String get pleaseSignUpToContinue;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Powered By BCTPay'**
  String get poweredBy;

  /// No description provided for @prev.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prev;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get primary;

  /// No description provided for @primaryAccountHistory.
  ///
  /// In en, this message translates to:
  /// **'Primary Account History'**
  String get primaryAccountHistory;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @proceedToPay.
  ///
  /// In en, this message translates to:
  /// **'Proceed To Pay'**
  String get proceedToPay;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @productTax.
  ///
  /// In en, this message translates to:
  /// **'Product TAX'**
  String get productTax;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile Details'**
  String get profileDetails;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @qrPayment.
  ///
  /// In en, this message translates to:
  /// **'QR Payment'**
  String get qrPayment;

  /// No description provided for @qrscan.
  ///
  /// In en, this message translates to:
  /// **'QR Scan'**
  String get qrscan;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @queries.
  ///
  /// In en, this message translates to:
  /// **'Queries'**
  String get queries;

  /// No description provided for @queryClosedYouCantReply.
  ///
  /// In en, this message translates to:
  /// **'Query Closed, You Can\'t Reply'**
  String get queryClosedYouCantReply;

  /// No description provided for @queryHistory.
  ///
  /// In en, this message translates to:
  /// **'Query History'**
  String get queryHistory;

  /// No description provided for @queryType.
  ///
  /// In en, this message translates to:
  /// **'Query Type'**
  String get queryType;

  /// No description provided for @reNew.
  ///
  /// In en, this message translates to:
  /// **'Renew'**
  String get reNew;

  /// No description provided for @readAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Read All Notifications'**
  String get readAllNotifications;

  /// No description provided for @recapture.
  ///
  /// In en, this message translates to:
  /// **'Recapture'**
  String get recapture;

  /// No description provided for @receivableAccount.
  ///
  /// In en, this message translates to:
  /// **'Receivable Account'**
  String get receivableAccount;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @receivedBy.
  ///
  /// In en, this message translates to:
  /// **'Received By'**
  String get receivedBy;

  /// No description provided for @receivedInto.
  ///
  /// In en, this message translates to:
  /// **'Received Into'**
  String get receivedInto;

  /// No description provided for @receiverDetails.
  ///
  /// In en, this message translates to:
  /// **'Receiver Details'**
  String get receiverDetails;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @recharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get recharge;

  /// No description provided for @rechargeBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Recharge Any Mobile By Entering Mobile Number Or By Choosing Contact From Your Contact List.'**
  String get rechargeBtnDescription;

  /// No description provided for @rechargehasBeenSuccessfullyDone.
  ///
  /// In en, this message translates to:
  /// **'Recharge Successful!'**
  String get rechargehasBeenSuccessfullyDone;

  /// No description provided for @recoverPassword.
  ///
  /// In en, this message translates to:
  /// **'Recover Password'**
  String get recoverPassword;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @referenceID.
  ///
  /// In en, this message translates to:
  /// **'Reference ID'**
  String get referenceID;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @requestAgain.
  ///
  /// In en, this message translates to:
  /// **'Request Again'**
  String get requestAgain;

  /// No description provided for @requestAmount.
  ///
  /// In en, this message translates to:
  /// **'Request Amount'**
  String get requestAmount;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Detail'**
  String get requestDetails;

  /// No description provided for @requestOTP.
  ///
  /// In en, this message translates to:
  /// **'Request OTP'**
  String get requestOTP;

  /// No description provided for @requestPayment.
  ///
  /// In en, this message translates to:
  /// **'Request Payment'**
  String get requestPayment;

  /// No description provided for @requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request Permission'**
  String get requestPermission;

  /// No description provided for @requestTo.
  ///
  /// In en, this message translates to:
  /// **'Request To'**
  String get requestTo;

  /// No description provided for @requestToPay.
  ///
  /// In en, this message translates to:
  /// **'Request To Pay'**
  String get requestToPay;

  /// No description provided for @requestingFrom.
  ///
  /// In en, this message translates to:
  /// **'Requesting From'**
  String get requestingFrom;

  /// No description provided for @rescan.
  ///
  /// In en, this message translates to:
  /// **'Rescan'**
  String get rescan;

  /// No description provided for @resendVerificationLink.
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Link'**
  String get resendVerificationLink;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @roaming.
  ///
  /// In en, this message translates to:
  /// **'Roaming'**
  String get roaming;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @scanBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Codes And Make Transactions.'**
  String get scanBtnDescription;

  /// No description provided for @scanPayUsingBCTPayApp.
  ///
  /// In en, this message translates to:
  /// **'Scan & Pay Using The BCTPay App'**
  String get scanPayUsingBCTPayApp;

  /// No description provided for @scanQR.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQR;

  /// No description provided for @scanTheQRCodeToViewInvoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Scan The QR Code To View Invoice Details'**
  String get scanTheQRCodeToViewInvoiceDetails;

  /// No description provided for @scanTheQRCodeToViewSubscriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Scan The QR Code To View Subscription Details'**
  String get scanTheQRCodeToViewSubscriptionDetails;

  /// No description provided for @scanToPayWithBCTPayApp.
  ///
  /// In en, this message translates to:
  /// **'Scan To Pay With The BCTPay App'**
  String get scanToPayWithBCTPayApp;

  /// No description provided for @scanToVerifyThisPayment.
  ///
  /// In en, this message translates to:
  /// **'Scan To Verify This Payment'**
  String get scanToVerifyThisPayment;

  /// No description provided for @scratchHere.
  ///
  /// In en, this message translates to:
  /// **'Scratch Here'**
  String get scratchHere;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search Country'**
  String get searchCountry;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here...'**
  String get searchHere;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @seeQueryHistory.
  ///
  /// In en, this message translates to:
  /// **'See Query History'**
  String get seeQueryHistory;

  /// No description provided for @selectAccount.
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectAccount;

  /// No description provided for @selectAccountToReceiveInto.
  ///
  /// In en, this message translates to:
  /// **'Select Account To Receive Into'**
  String get selectAccountToReceiveInto;

  /// No description provided for @selectBankAccountToTransferFrom.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Account To Transfer From'**
  String get selectBankAccountToTransferFrom;

  /// No description provided for @selectBankAccountToTransferTo.
  ///
  /// In en, this message translates to:
  /// **'Select Bank Account To Transfer To'**
  String get selectBankAccountToTransferTo;

  /// No description provided for @selectCard.
  ///
  /// In en, this message translates to:
  /// **'Select Card'**
  String get selectCard;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectState.
  ///
  /// In en, this message translates to:
  /// **'Select State'**
  String get selectState;

  /// No description provided for @selectValidity.
  ///
  /// In en, this message translates to:
  /// **'Select Validity'**
  String get selectValidity;

  /// No description provided for @selectYourDocumentType.
  ///
  /// In en, this message translates to:
  /// **'Select Your Document Type'**
  String get selectYourDocumentType;

  /// No description provided for @selfTransfer.
  ///
  /// In en, this message translates to:
  /// **'Self Transfer'**
  String get selfTransfer;

  /// No description provided for @selfieVerification.
  ///
  /// In en, this message translates to:
  /// **'Selfie Verification'**
  String get selfieVerification;

  /// No description provided for @selfieVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'In Order To Completed Your KYC, Please Capture Your Selfie'**
  String get selfieVerificationDesc;

  /// No description provided for @selfieVerificationPurpose.
  ///
  /// In en, this message translates to:
  /// **'The Selfie Is Being Checked For Accuracy. If It\'s Not Correct, You Should Either Recapture It Or Proceed With The Existing Image.'**
  String get selfieVerificationPurpose;

  /// No description provided for @selfieVerificationTnC.
  ///
  /// In en, this message translates to:
  /// **'Hold Your Phone At Eye Level, Look Directly Into The Camera, And Press The Capture Button To Take A Photo.'**
  String get selfieVerificationTnC;

  /// No description provided for @sendAMsg.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get sendAMsg;

  /// No description provided for @sendMoney.
  ///
  /// In en, this message translates to:
  /// **'Send Money'**
  String get sendMoney;

  /// No description provided for @sendMoneyBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'You Can Make Transactions To Your Added Beneficiaries And You Can Also Manage Beneficiaries.'**
  String get sendMoneyBtnDescription;

  /// No description provided for @senderDetails.
  ///
  /// In en, this message translates to:
  /// **'Sender Details'**
  String get senderDetails;

  /// No description provided for @senderName.
  ///
  /// In en, this message translates to:
  /// **'Sender Name'**
  String get senderName;

  /// No description provided for @sendingAmount.
  ///
  /// In en, this message translates to:
  /// **'Sending Amount'**
  String get sendingAmount;

  /// No description provided for @sendingTo.
  ///
  /// In en, this message translates to:
  /// **'Sending To'**
  String get sendingTo;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @sentFrom.
  ///
  /// In en, this message translates to:
  /// **'Sent From'**
  String get sentFrom;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get serverError;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @setActive.
  ///
  /// In en, this message translates to:
  /// **'Set Active'**
  String get setActive;

  /// No description provided for @setAsPrimaryAccount.
  ///
  /// In en, this message translates to:
  /// **'Set As Primary Account'**
  String get setAsPrimaryAccount;

  /// No description provided for @setInActive.
  ///
  /// In en, this message translates to:
  /// **'Set Inactive'**
  String get setInActive;

  /// No description provided for @setPrimary.
  ///
  /// In en, this message translates to:
  /// **'Set Primary'**
  String get setPrimary;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLess;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @sideMenu.
  ///
  /// In en, this message translates to:
  /// **'Side Menu'**
  String get sideMenu;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signupTnc.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get signupTnc;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @stillStuckHelpUsAMailAway.
  ///
  /// In en, this message translates to:
  /// **'Still stuck? Help us a mail away'**
  String get stillStuckHelpUsAMailAway;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @subscriberID.
  ///
  /// In en, this message translates to:
  /// **'Subscriber ID'**
  String get subscriberID;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @subscriptionCreatedBy.
  ///
  /// In en, this message translates to:
  /// **'Subscription Created By'**
  String get subscriptionCreatedBy;

  /// No description provided for @subscriptionDetails.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscriptionDetails;

  /// No description provided for @subscriptionPlans.
  ///
  /// In en, this message translates to:
  /// **'Subscription Plans'**
  String get subscriptionPlans;

  /// No description provided for @subscriptionType.
  ///
  /// In en, this message translates to:
  /// **'Subscription Type'**
  String get subscriptionType;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @takeASelfie.
  ///
  /// In en, this message translates to:
  /// **'Take A Selfie'**
  String get takeASelfie;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get tax;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @thisFieldShouldNotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'This Field Shouldn\'t Be Empty'**
  String get thisFieldShouldNotBeEmpty;

  /// No description provided for @thisFuctionalityWillAvailableSoon.
  ///
  /// In en, this message translates to:
  /// **'This Fuctionality Will Available Soon'**
  String get thisFuctionalityWillAvailableSoon;

  /// No description provided for @ticketCount.
  ///
  /// In en, this message translates to:
  /// **'Ticket count'**
  String get ticketCount;

  /// No description provided for @tnc.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get tnc;

  /// No description provided for @toSelfAccount.
  ///
  /// In en, this message translates to:
  /// **'To Self Account'**
  String get toSelfAccount;

  /// No description provided for @toSelfAccountBtnDescription.
  ///
  /// In en, this message translates to:
  /// **'Transfer Money To Your Self Accounts Even You Can Manage Your Accounts From Here.'**
  String get toSelfAccountBtnDescription;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @topUp.
  ///
  /// In en, this message translates to:
  /// **'Top-Up'**
  String get topUp;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @totalPay.
  ///
  /// In en, this message translates to:
  /// **'Total Pay'**
  String get totalPay;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get totalPayment;

  /// No description provided for @totalProductPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Product Price'**
  String get totalProductPrice;

  /// No description provided for @totalTaxAmount.
  ///
  /// In en, this message translates to:
  /// **'Total TAX Amount'**
  String get totalTaxAmount;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// No description provided for @transactionFee.
  ///
  /// In en, this message translates to:
  /// **'Transaction Fee: '**
  String get transactionFee;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @transactionStatus.
  ///
  /// In en, this message translates to:
  /// **'Transaction Status'**
  String get transactionStatus;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @transferDetails.
  ///
  /// In en, this message translates to:
  /// **'Transfer Details'**
  String get transferDetails;

  /// No description provided for @transferFrom.
  ///
  /// In en, this message translates to:
  /// **'Transfer From'**
  String get transferFrom;

  /// No description provided for @transferMoneyTo.
  ///
  /// In en, this message translates to:
  /// **'Transfer Money To'**
  String get transferMoneyTo;

  /// No description provided for @transferNow.
  ///
  /// In en, this message translates to:
  /// **'Transfer Now'**
  String get transferNow;

  /// No description provided for @transferTo.
  ///
  /// In en, this message translates to:
  /// **'Transfer To'**
  String get transferTo;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again..'**
  String get tryAgain;

  /// No description provided for @txnStatusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get txnStatusSuccess;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unlockBCTPay.
  ///
  /// In en, this message translates to:
  /// **'Unlock BCTPay'**
  String get unlockBCTPay;

  /// No description provided for @unlockNow.
  ///
  /// In en, this message translates to:
  /// **'Unlock Now'**
  String get unlockNow;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Update Bank Account'**
  String get updateBankAccount;

  /// No description provided for @updateBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Update Beneficiary'**
  String get updateBeneficiary;

  /// No description provided for @updateKyc.
  ///
  /// In en, this message translates to:
  /// **'Update KYC'**
  String get updateKyc;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @uploadBackImageOfDoc.
  ///
  /// In en, this message translates to:
  /// **'Upload Back Image Of Document'**
  String get uploadBackImageOfDoc;

  /// No description provided for @uploadFollowingDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Following Documents'**
  String get uploadFollowingDocuments;

  /// No description provided for @uploadFrontImageOfDoc.
  ///
  /// In en, this message translates to:
  /// **'Upload Front Image Of Document'**
  String get uploadFrontImageOfDoc;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @uploadYourAddressDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Your Address Document'**
  String get uploadYourAddressDocument;

  /// No description provided for @upto.
  ///
  /// In en, this message translates to:
  /// **'Upto'**
  String get upto;

  /// No description provided for @valid.
  ///
  /// In en, this message translates to:
  /// **'Valid'**
  String get valid;

  /// No description provided for @validFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid From'**
  String get validFrom;

  /// No description provided for @validTill.
  ///
  /// In en, this message translates to:
  /// **'Valid Till'**
  String get validTill;

  /// No description provided for @validity.
  ///
  /// In en, this message translates to:
  /// **'Validity'**
  String get validity;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @viewAccount.
  ///
  /// In en, this message translates to:
  /// **'View Account'**
  String get viewAccount;

  /// No description provided for @viewPlan.
  ///
  /// In en, this message translates to:
  /// **'View Plan'**
  String get viewPlan;

  /// No description provided for @voterIdCard.
  ///
  /// In en, this message translates to:
  /// **'Voter ID Card'**
  String get voterIdCard;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @walletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get walletBalance;

  /// No description provided for @walletPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Wallet Phone Number'**
  String get walletPhoneNumber;

  /// No description provided for @beneficiaryMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Mobile Number'**
  String get beneficiaryMobileNumber;

  /// No description provided for @senderAccountNumber.
  ///
  /// In en, this message translates to:
  /// **'Sender\'s account number'**
  String get senderAccountNumber;

  /// No description provided for @amountToSend.
  ///
  /// In en, this message translates to:
  /// **'Amount to send'**
  String get amountToSend;

  /// No description provided for @enterNarration.
  ///
  /// In en, this message translates to:
  /// **'Enter narration'**
  String get enterNarration;

  /// No description provided for @saveAsBeneficiary.
  ///
  /// In en, this message translates to:
  /// **'Save as Beneficiary'**
  String get saveAsBeneficiary;

  /// No description provided for @selectBank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// No description provided for @ngnBalance.
  ///
  /// In en, this message translates to:
  /// **'NGN BALANCE'**
  String get ngnBalance;

  /// No description provided for @sendByBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Send by Bank Transfer'**
  String get sendByBankTransfer;

  /// No description provided for @transactionSummary.
  ///
  /// In en, this message translates to:
  /// **'Transaction Summary'**
  String get transactionSummary;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get accountName;

  /// No description provided for @walletLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get walletLabel;

  /// No description provided for @narration.
  ///
  /// In en, this message translates to:
  /// **'Narration'**
  String get narration;

  /// No description provided for @transferFee.
  ///
  /// In en, this message translates to:
  /// **'Transfer fee'**
  String get transferFee;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @enterYourPin.
  ///
  /// In en, this message translates to:
  /// **'Enter Your PIN'**
  String get enterYourPin;

  /// No description provided for @enterYourPinDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN to confirm payment'**
  String get enterYourPinDesc;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @paymentSent.
  ///
  /// In en, this message translates to:
  /// **'Payment Sent'**
  String get paymentSent;

  /// No description provided for @response.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get response;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get reference;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get warning;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @weHaveSentTheCodeVerificationToYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'We Have Sent The Code Verification To Your Email Address'**
  String get weHaveSentTheCodeVerificationToYourEmailAddress;

  /// No description provided for @weHaveSentTheCodeVerificationToYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'We Have Sent The Code Verification To Your Mobile Number'**
  String get weHaveSentTheCodeVerificationToYourMobileNumber;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @yoCanUpdateYourProfileFromHere.
  ///
  /// In en, this message translates to:
  /// **'You Can Update Your Profile From Here.'**
  String get yoCanUpdateYourProfileFromHere;

  /// No description provided for @youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy.
  ///
  /// In en, this message translates to:
  /// **'Pay Online From Any Card Or Account. Simply Scan The QR Code To Get Started.'**
  String
      get youCanDoAnyOnlinePaymentFromAnyCardOrAccountJustScanTheQRCodeNEnjoy;

  /// No description provided for @youCanGetUpto.
  ///
  /// In en, this message translates to:
  /// **'You Can Get Upto'**
  String get youCanGetUpto;

  /// No description provided for @youCanNotTransferAmountToYourselfSelectOtherAccountToProceed.
  ///
  /// In en, this message translates to:
  /// **'You Can Not Transfer Amount To Yourself. Select Other Account To Proceed.'**
  String get youCanNotTransferAmountToYourselfSelectOtherAccountToProceed;

  /// No description provided for @youCantAddMoreThanDocs.
  ///
  /// In en, this message translates to:
  /// **'You Can\'t Add More Than {count} Docs.'**
  String youCantAddMoreThanDocs(Object count);

  /// No description provided for @youCantRetryYet.
  ///
  /// In en, this message translates to:
  /// **'You Can\'t Retry Yet!'**
  String get youCantRetryYet;

  /// No description provided for @your.
  ///
  /// In en, this message translates to:
  /// **'Your'**
  String get your;

  /// No description provided for @yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your Goals Help Us Provide The Best Recommendations For Your Success.'**
  String get yourGoalsWillHelpUsToFormulateTheRightRecommendationsForSuccess;

  /// No description provided for @yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword.
  ///
  /// In en, this message translates to:
  /// **'Your New Password Must Be Different From Previously Used Password.'**
  String get yourNewPasswordMustBeDifferentFromPreviouslyUsedPassword;

  /// No description provided for @yourPasswordHasBeenChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your Password Has Been Changed Successfully.'**
  String get yourPasswordHasBeenChangedSuccessfully;

  /// No description provided for @yourPasswordHasBeenResetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your Password Has Been Reset Successfully.'**
  String get yourPasswordHasBeenResetSuccessfully;

  /// No description provided for @yourPaymentHasBeenSuccessfullyDone.
  ///
  /// In en, this message translates to:
  /// **'Your Payment Of {amount} Has Been Sent Successfully.'**
  String yourPaymentHasBeenSuccessfullyDone(Object amount);

  /// No description provided for @yourPaymentOf.
  ///
  /// In en, this message translates to:
  /// **'Your Payment Of'**
  String get yourPaymentOf;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
