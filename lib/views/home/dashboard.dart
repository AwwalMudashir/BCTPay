import 'package:bctpay/data/repository/transaction_repo/wallet/get_balance_api.dart';
import 'package:bctpay/globals/index.dart';

class _QuickAction {
  final String label;
  final IconData icon;
  final String route;

  const _QuickAction({
    required this.label,
    required this.icon,
    required this.route,
  });
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<_StaticTransaction> _staticTransactions = const [
    _StaticTransaction(
        title: "Receive USDT",
        subtitle: "P2P Transfer - 04 May 2025",
        amount: "+\$200.00",
        isCredit: true),
    _StaticTransaction(
        title: "Sent BTC",
        subtitle: "P2P Transfer - 04 May 2025",
        amount: "-\$100.00",
        isCredit: false),
    _StaticTransaction(
        title: "Receive USDT",
        subtitle: "P2P Transfer - 04 May 2025",
        amount: "+\$200.00",
        isCredit: true),
    _StaticTransaction(
        title: "Sent BTC",
        subtitle: "P2P Transfer - 04 May 2025",
        amount: "-\$100.00",
        isCredit: false),
    _StaticTransaction(
        title: "Receive USDT",
        subtitle: "P2P Transfer - 04 May 2025",
        amount: "+\$200.00",
        isCredit: true),
  ];
  final List<_QuickAction> _quickActions = const [
    _QuickAction(
      route: AppRoutes.sendOptions,
      label: "Send",
      icon: Icons.send_rounded,
    ),
    _QuickAction(
      route: AppRoutes.requestToPay,
      label: "Receive",
      icon: Icons.call_received_rounded,
    ),
    _QuickAction(
      route: AppRoutes.qrscan,
      label: "Payment",
      icon: Icons.qr_code_2_rounded,
    ),
    _QuickAction(
      route: AppRoutes.accountsList,
      label: "Account",
      icon: Icons.account_balance_wallet_rounded,
    ),
  ];

  String? _userName;
  double? _walletBalance;
  String? _walletAccountName;
  String? _walletAccountNo;
  bool _balanceLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadWalletBalance();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handlePermission();
      toorNavConfig(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: AnimationLimiter(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                _buildTransactionsSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final gradient = LinearGradient(
        colors: [const Color(0xFF0C427A), const Color(0xFF02244F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: (_userName?.isNotEmpty ?? false)
                        ? Text(
                            _userName!.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        : const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi,",
                        style: textTheme.bodySmall
                            ?.copyWith(color: Colors.white70, fontSize: 12),
                      ),
                      Text(
                        _userName?.trim().isNotEmpty == true
                            ? _userName!
                            : "User",
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.notifications,
                    arguments: NotificationScreen(showAppbar: true),
                  );
                },
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                    ),
                    _badge()
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            appLocalizations(context).walletBalance,
            style: textTheme.bodySmall
                ?.copyWith(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          _balanceLoading
              ? const SizedBox(
                  height: 32,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  formatCurrency(_walletBalance?.toString() ?? "0"),
                  style: textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
          const SizedBox(height: 6),
          if (_walletAccountName != null || _walletAccountNo != null)
            Text(
              "${_walletAccountName ?? ""} ${_walletAccountNo ?? ""}".trim(),
              style: textTheme.bodySmall
                  ?.copyWith(color: Colors.white70, fontSize: 12),
            ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _quickActions
                .map((action) => _ActionButton(
                      action: action,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations(context).recentTransactions,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.transactionhistory);
                },
                child: const Text("View All"),
              )
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _staticTransactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _TransactionTile(
                transaction: _staticTransactions[index],
              );
            },
          )
        ],
      ),
    );
  }

  void toorNavConfig(BuildContext context) {
    SharedPreferenceHelper.getIsTourNavigationShowed().then((isShowed) {
      if (isShowed) {
      } else {
        if (!context.mounted) return;
        TourNavigationController.init(context);
      }
    });
  }

  Future<void> handlePermission() async {
    Permission cameraPermission = Permission.camera;
    Permission contactsPermission = Permission.contacts;
    Permission notificationPermission = Permission.notification;
    [cameraPermission, contactsPermission, notificationPermission].request();
  }

  Widget _badge() {
    var textTheme = Theme.of(context).textTheme;
    return BlocConsumer(
        bloc: notificationsListBloc,
        listener: (context, state) {
          if (state is GetNotificationsListState) {
            if (state.value.code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(state.value.message, context);
            }
          }
        },
        builder: (context, state) {
          if (state is GetNotificationsListState) {
            var notificationListData = state.value.data;
            var unreadNotificationCount =
                notificationListData?.unreadnotificationscount ?? 0;
            if (unreadNotificationCount == 0) {
              return const SizedBox.shrink();
            }
            return Positioned(
              child: Container(
                  margin: const EdgeInsets.only(left: 15, bottom: 0),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.8),
                      shape: BoxShape.circle),
                  child: Text(
                    unreadNotificationCount.toString(),
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            );
          }
          return const SizedBox.shrink();
        });
  }

  void _loadUserInfo() {
    SharedPreferenceHelper.getUserName().then((value) {
      if (!mounted) return;
      setState(() {
        _userName = value;
      });
    });
  }

  Future<void> _loadWalletBalance() async {
    try {
      final balance = await getWalletBalance();
      if (!mounted) return;
      setState(() {
        _walletBalance = balance.balance;
        _walletAccountName = balance.accountName;
        _walletAccountNo = balance.accountNo;
        _balanceLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _balanceLoading = false;
      });
    }
  }
}

class _ActionButton extends StatelessWidget {
  final _QuickAction action;

  const _ActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, action.route),
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Icon(
              action.icon,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          action.label,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final _StaticTransaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final amountColor = transaction.isCredit ? Colors.teal : Colors.red;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: (transaction.isCredit ? Colors.teal : Colors.red)
                    .withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                transaction.isCredit ? Icons.call_received : Icons.north_east,
                color: amountColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transaction.subtitle,
                    style: textTheme.bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              transaction.amount,
              style: textTheme.titleMedium?.copyWith(
                color: amountColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticTransaction {
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;

  const _StaticTransaction(
      {required this.title,
      required this.subtitle,
      required this.amount,
      required this.isCredit});
}
