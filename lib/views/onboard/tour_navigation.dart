import 'package:bctpay/globals/index.dart';

/// Singleton class to manage GlobalKeys for tour navigation
/// This ensures each key is created only once and reused across the app
class TourNavigationKeys {
  static final TourNavigationKeys _instance = TourNavigationKeys._internal();

  factory TourNavigationKeys() {
    return _instance;
  }

  TourNavigationKeys._internal();

  GlobalKey<State<StatefulWidget>>? _homeBtnKey;
  GlobalKey<State<StatefulWidget>>? _balanceBtnKey;
  GlobalKey<State<StatefulWidget>>? _historyBtnKey;
  GlobalKey<State<StatefulWidget>>? _notificationsBtnKey;
  GlobalKey<State<StatefulWidget>>? _drawerBtnKey;
  GlobalKey<State<StatefulWidget>>? _scanBtnKey;
  GlobalKey<State<StatefulWidget>>? _sendMoneyBtnKey;
  GlobalKey<State<StatefulWidget>>? _requestToPayBtnKey;
  GlobalKey<State<StatefulWidget>>? _toSelfAccountBtnKey;
  GlobalKey<State<StatefulWidget>>? _rechargeBtnKey;
  GlobalKey<State<StatefulWidget>>? _dataBtnKey;
  GlobalKey<State<StatefulWidget>>? _giftCardBtnKey;

  GlobalKey<State<StatefulWidget>>? get homeBtnKey => _homeBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get balanceBtnKey => _balanceBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get historyBtnKey => _historyBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get notificationsBtnKey => _notificationsBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get drawerBtnKey => _drawerBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get scanBtnKey => _scanBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get sendMoneyBtnKey => _sendMoneyBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get requestToPayBtnKey => _requestToPayBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get toSelfAccountBtnKey => _toSelfAccountBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get rechargeBtnKey => _rechargeBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get dataBtnKey => _dataBtnKey ??= GlobalKey();
  GlobalKey<State<StatefulWidget>>? get giftCardBtnKey => _giftCardBtnKey ??= GlobalKey();

  /// Reset all keys - useful when tour needs to be shown again
  void reset() {
    _homeBtnKey = null;
    _balanceBtnKey = null;
    _historyBtnKey = null;
    _notificationsBtnKey = null;
    _drawerBtnKey = null;
    _scanBtnKey = null;
    _sendMoneyBtnKey = null;
    _requestToPayBtnKey = null;
    _toSelfAccountBtnKey = null;
    _rechargeBtnKey = null;
    _dataBtnKey = null;
    _giftCardBtnKey = null;
  }
}

// Global accessor instance
final tourNavigationKeys = TourNavigationKeys();

// Backward compatibility - expose keys as top-level getters
GlobalKey<State<StatefulWidget>>? get homeBtnKey => tourNavigationKeys.homeBtnKey;
GlobalKey<State<StatefulWidget>>? get balanceBtnKey => tourNavigationKeys.balanceBtnKey;
GlobalKey<State<StatefulWidget>>? get historyBtnKey => tourNavigationKeys.historyBtnKey;
GlobalKey<State<StatefulWidget>>? get notificationsBtnKey => tourNavigationKeys.notificationsBtnKey;
GlobalKey<State<StatefulWidget>>? get drawerBtnKey => tourNavigationKeys.drawerBtnKey;
GlobalKey<State<StatefulWidget>>? get scanBtnKey => tourNavigationKeys.scanBtnKey;
GlobalKey<State<StatefulWidget>>? get sendMoneyBtnKey => tourNavigationKeys.sendMoneyBtnKey;
GlobalKey<State<StatefulWidget>>? get requestToPayBtnKey => tourNavigationKeys.requestToPayBtnKey;
GlobalKey<State<StatefulWidget>>? get toSelfAccountBtnKey => tourNavigationKeys.toSelfAccountBtnKey;
GlobalKey<State<StatefulWidget>>? get rechargeBtnKey => tourNavigationKeys.rechargeBtnKey;
GlobalKey<State<StatefulWidget>>? get dataBtnKey => tourNavigationKeys.dataBtnKey;
GlobalKey<State<StatefulWidget>>? get giftCardBtnKey => tourNavigationKeys.giftCardBtnKey;

List<TargetFocus> targets = [];

TargetContent targetContent(
    {required String title,
    required String description,
    ContentAlign align = ContentAlign.bottom}) {
  return TargetContent(
      align: align,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              description,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ));
}

class TourNavigationController {
  static void addTargets(BuildContext context) {
    targets = [
      TargetFocus(
        identify: "home",
        keyTarget: homeBtnKey,
        contents: [
          targetContent(
            align: ContentAlign.top,
            title: appLocalizations(context).home,
            description: appLocalizations(context).homeBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "balance",
        keyTarget: balanceBtnKey,
        contents: [
          targetContent(
            align: ContentAlign.top,
            title: appLocalizations(context).balance,
            description: appLocalizations(context).balanceBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "history",
        keyTarget: historyBtnKey,
        contents: [
          targetContent(
            align: ContentAlign.top,
            title: appLocalizations(context).transactions,
            description: appLocalizations(context).historyBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "notifications",
        keyTarget: notificationsBtnKey,
        contents: [
          targetContent(
            align: ContentAlign.top,
            title: appLocalizations(context).notifications,
            description: appLocalizations(context).notificationsBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "drawer",
        keyTarget: drawerBtnKey,
        contents: [
          targetContent(
            align: ContentAlign.bottom,
            title: appLocalizations(context).sideMenu,
            description: appLocalizations(context).drawerBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "scan",
        keyTarget: scanBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).scan,
            description: appLocalizations(context).scanBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "send money",
        keyTarget: sendMoneyBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).sendMoney,
            description: appLocalizations(context).sendMoneyBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "request to pay",
        keyTarget: requestToPayBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).requestToPay,
            description: appLocalizations(context).checkBalanceBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "to self account",
        keyTarget: toSelfAccountBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).toSelfAccount,
            description: appLocalizations(context).toSelfAccountBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "recharge",
        keyTarget: rechargeBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).recharge,
            description: appLocalizations(context).rechargeBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "data",
        keyTarget: dataBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).data,
            description: appLocalizations(context).dataBtnDescription,
          ),
        ],
      ),
      TargetFocus(
        identify: "giftCard",
        keyTarget: giftCardBtnKey,
        contents: [
          targetContent(
            title: appLocalizations(context).giftCard,
            description: appLocalizations(context).giftCardBtnDescription,
          ),
        ],
      ),
    ];
  }

  static void showTutorial(BuildContext context) {
    TutorialCoachMark tutorial = TutorialCoachMark(
        targets: targets,
        colorShadow: themeLogoColorOrange,
        onFinish: () {
          SharedPreferenceHelper.setIsTourNavigationShowed(true);
        },
        onClickTargetWithTapPosition: (target, tapDetails) {},
        onClickTarget: (target) {},
        onSkip: () {
          SharedPreferenceHelper.setIsTourNavigationShowed(true);
          return true;
        });
    WidgetsBinding.instance
        .addPostFrameCallback((timestemp) => tutorial.show(context: context));
  }

  static void init(BuildContext context) {
    addTargets(context);
    showTutorial(context);
  }
}
