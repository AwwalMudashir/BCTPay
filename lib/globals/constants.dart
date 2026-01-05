import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///Themes
const Color? backgroundColor = null; // Color(0xff003366);
const Color themeColorHeader = Color(0xff021629);
const Color themeYellowColor = Color(0xffca8a04);
const Color themeGreyColor = Color(0xff87809D);
const Color themeLogoColorOrange = Color(0xffff7800);
const Color themeLogoColorBlue = Color(0xff023467);
const Color tileColor = Colors.white;
const Color dropdownColor = Color.fromARGB(255, 221, 216, 216);

List<bool> isSelected = [true, false];

BoxDecoration shadowDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
          blurRadius: 10, spreadRadius: 2, color: Colors.grey.withValues(alpha: 0.5))
    ]);

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(10),
  ),
);

///Global variables
final String projectName = dotenv.env["projectName"] ?? "BCTPay";
double height = 400;
double width = 200;
TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
Object? args(BuildContext context) => ModalRoute.of(context)!.settings.arguments;
Size size(BuildContext context) => MediaQuery.of(context).size;
bool isDarkMode(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
const int cacheHeight = 50;
const int cacheWidth = 50;
const double textFieldSuffixScale = 5;

const List<Locale> supportedLocales =
    AppLocalizations.supportedLocales; //[Locale("en"), Locale("fr")];
String selectedLanguage = "fr";
CountryData? selectedCountry;
Locale selectedLocale = Locale.fromSubtags(
    languageCode: selectedLanguage,
    countryCode: selectedCountry?.countryCode ?? "NG");
AppLocalizations appLocalizations(BuildContext context) => AppLocalizations.of(context)!;

List<LocalizationsDelegate> localizationsDelegates = [
  RefreshLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  AppLocalizations.delegate,
];

//api-keys
final String wlID = dotenv.env["WL_ID"] ?? "";

///urls
const String _defaultBaseUrl = 'https://corestack.app:8008/mmcp/api/v1/';
final String baseUrl = _defaultBaseUrl;
final String baseUrlTransaction = _defaultBaseUrl;
final String baseUrlPublic = _defaultBaseUrl;
final String merchantCode = dotenv.env["merchantCode"] ?? "BCTPAY";
final String baseUrlCustomer = "$baseUrl/api/customer";
final String baseUrlCustomerTxn = "$baseUrlTransaction/api/customertransaction";
final String baseUrlCustomerTxnPublic = "$baseUrlTransaction/api/public";
final String baseUrlCountryFlag = dotenv.env["baseUrlCountryFlag"] ?? "";
final String baseUrlProfileImage = dotenv.env["baseUrlProfileImage"] ?? "";
final String baseUrlKYCImage = dotenv.env["baseUrlKYCImage"] ?? "";
final String baseUrlDocFiles = dotenv.env["baseUrlDocFiles"] ?? "";
final String baseUrlBankLogo = dotenv.env["baseUrlBankLogo"] ?? "";
final String baseUrlBanner = dotenv.env["baseUrlBanner"] ?? "";
final String baseUrlBannerImage = dotenv.env["baseUrlBannerImage"] ?? "";

const String orangeMoneyReturnUrl = "https://plg.console.bctpay.io/returnurl";
const String orangeMoneyCancelUrl = "https://plg.console.bctpay.io/cancelurl";
String cardTxnReturnUrl(String paymentId) =>
    "https://plg.bctpay.app/eft_payment_status?paymentId=$paymentId";

const String securityWebUrl = "https://plg.bctpay.app/customer_security";
const String termsAndConditionsUrl =
    "https://plg.bctpay.app/customer_terms_conditions";
const String privacyPolicyWebUrl = "https://plg.bctpay.app/customer_policy";

///keys
final String encryptionKey = dotenv.env["encryptionKey"] ?? "";

var profileBloc = ApisBloc(ApisBlocInitialState());
var bankAccountListBloc = ApisBloc(ApisBlocInitialState());
var customerSettingBloc = ApisBloc(ApisBlocInitialState())
  ..add(CustomerSettingEvent());
var beneficiaryListBloc = ApisBloc(ApisBlocInitialState());
var kycBloc = ApisBloc(ApisBlocInitialState());
var banksListBloc = ApisBloc(ApisBlocInitialState());
var notificationsListBloc = ApisBloc(ApisBlocInitialState());
var getProfileDetailFromLocalBloc =
    SharedPrefBloc(const SharedPrefInitialState());
final NetworkBloc networkBloc = NetworkBloc()..add(CheckConnection());
LocalizationBloc localizationBloc =
    LocalizationBloc(ChangeLocaleState(selectedLocale));
SelectionBloc selectCountryBloc = SelectionBloc(SelectionBlocInitialState());
SelectionBloc selectThemeBloc = SelectionBloc(SelectThemeState(ThemeMode.dark));
var countryListBloc = ApisBloc(ApisBlocInitialState());
var transactionHistoryBloc = ApisBloc(ApisBlocInitialState());
var verifyOrangeWalletBloc = ApisBloc(ApisBlocInitialState());
