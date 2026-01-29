import 'package:bctpay/data/repository/transaction_repo/wallet/get_balance_api.dart';
import 'package:bctpay/data/models/transactions/transaction_history_response.dart';
import 'package:bctpay/globals/index.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Quick action buttons data
  final List<_QuickAction> _quickActions = const [
    _QuickAction(
      route: AppRoutes.sendOptions,
      icon: Icons.send_rounded,
      titleKey: 'send',
    ),
    _QuickAction(
      route: AppRoutes.receiveMoney,
      icon: Icons.call_received_rounded,
      titleKey: 'received',
    ),
    _QuickAction(
      route: AppRoutes.generatePaymentLink,
      icon: Icons.link_rounded,
      titleKey: 'payment',
    ),
    _QuickAction(
      route: AppRoutes.accountsList,
      icon: Icons.account_balance_wallet_rounded,
      titleKey: 'linkedAccounts',
    ),
  ];

  // State variables
  String? _userName;
  String? _profilePic;
  double? _walletBalance;
  String? _walletAccountName;
  String? _walletAccountNo;
  String? _walletCurrency;
  bool _balanceLoading = true;
  List<TransactionHistoryItem> _transactions = [];
  bool _transactionsLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadWalletBalance();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header section with gradient background
            SliverToBoxAdapter(child: _buildHeader()),

            // Transaction history section
            SliverToBoxAdapter(child: _buildTransactionSection()),

            // Transaction list
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0C427A), Color(0xFF02244F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User greeting and notifications row
            _HeaderTopRow(),

            const SizedBox(height: 32),

            // Balance section
            _BalanceSection(),

            const SizedBox(height: 32),

            // Quick action buttons
            _QuickActionsRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations(context).transactionHistoryTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: themeLogoColorBlue,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.transactionhistory),
                style: TextButton.styleFrom(
                  foregroundColor: themeLogoColorBlue,
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Text(appLocalizations(context).seeAll),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Loading or empty state
          if (_transactionsLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(),
              ),
            )
          else if (_transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                appLocalizations(context).noTransaction,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    if (_transactionsLoading || _transactions.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final transaction = _transactions[index];
          final isLast = index == _transactions.length - 1;

          return Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, isLast ? 32 : 12),
            child: _TransactionCard(transaction: transaction),
          );
        },
        childCount: _transactions.length,
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
              // Avoid forcing logout due to notification fetch failures
              showToast(state.value.message);
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
    SharedPreferenceHelper.getProfilePic().then((value) {
      if (!mounted) return;
      setState(() {
        _profilePic = value.isNotEmpty ? value : null;
      });
    });
  }

  Future<void> _loadWalletBalance() async {
    try {
      final balance = await getWalletBalance();
      if (!mounted) return;
      setState(() {
        _walletBalance = balance.lcyBalance;
        _walletAccountName = balance.accountName;
        _walletAccountNo = balance.accountNo;
        _walletCurrency = balance.lcy.isNotEmpty
            ? balance.lcy
            : (balance.ccyCode.isNotEmpty ? balance.ccyCode : balance.ccy);
        _balanceLoading = false;
      });
    } on SessionExpiredException catch (e) {
      if (!mounted) return;
      // Inform user and redirect to login for re-authentication
      sessionExpired(e.message, context);
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _balanceLoading = false;
      });
    }
  }

  Future<void> _loadTransactions() async {
    try {
      final history = await getTransactionHistory(pageSize: 10, pageNumber: 1);
      if (!mounted) return;
      setState(() {
        _transactions = history.items;
        _transactionsLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _transactionsLoading = false;
      });
    }
  }

}

class _ActionButton extends StatelessWidget {
  final _QuickAction action;
  final String label;

  const _ActionButton({required this.action, required this.label});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, action.route),
            borderRadius: BorderRadius.circular(32),
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
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )
      ],
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String route;
  final String titleKey;

  const _QuickAction({
    required this.icon,
    required this.route,
    required this.titleKey,
  });
}

class _TransactionCard extends StatelessWidget {
  final TransactionHistoryItem transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isCredit = transaction.isCredit;
    final amountColor = isCredit ? const Color(0xFF00A389) : const Color(0xFFE53935);
    final status = transaction.status.toUpperCase();
    final statusColor = _getStatusColor(status);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)), // Modern thin border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell( // Added ripple effect for better UX
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            final dashboardState = context.findAncestorStateOfType<_DashboardState>();
            Navigator.pushNamed(
              context,
              AppRoutes.transactionPreview,
              arguments: {
                'transaction': transaction,
                'currency': dashboardState?._walletCurrency ?? 'GNF',
              },
            );
          }, 
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Transaction Icon with subtle background gradient or solid
                _buildIcon(isCredit, amountColor),

                const SizedBox(width: 16),

                // 2. Transaction Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              transaction.title,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1C1E),
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // show currency near amount; default to wallet currency or GNF
                          Builder(builder: (ctx) {
                            final dashboardState = ctx.findAncestorStateOfType<_DashboardState>();
                            final currency = (dashboardState?._walletCurrency ?? 'GNF').toUpperCase();
                            final formatter = NumberFormat('#,##0.00');
                            final amt = (isCredit ? '+' : '-') + formatter.format(transaction.amount.abs());
                            final display = currency == 'GNF' ? '$amt GNF' : (currency.isNotEmpty ? '$currency $amt' : amt);
                            return Text(
                              display,
                              style: textTheme.titleMedium?.copyWith(
                                color: amountColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            );
                          }),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      Text(
                        transaction.tranDate,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 12),
                      
                      // 3. Metadata Row (Responsive using Wrap)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _buildStatusBadge(status, statusColor, context),
                          Text(
                            "•",
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          Text(
                            transaction.transactionType,
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "ID: ${transaction.tranRefNo.isNotEmpty ? transaction.tranRefNo : 'N/A'}",
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade400,
                              fontFamily: 'monospace', // Gives it a "reference code" feel
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isCredit, Color color) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14), // Squircle look
      ),
      child: Center(
        child: Icon(
          isCredit ? Icons.add_rounded : Icons.remove_rounded,
          color: color,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, Color color, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100), // Pill shape
      ),
      child: Text(
        status.isNotEmpty ? status : "UNKNOWN",
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static Color _getStatusColor(String status) {
    switch (status) {
      case "SUCCESS":
      case "COMPLETED":
        return const Color(0xFF00A389);
      case "PENDING":
        return Colors.orange.shade700;
      case "FAILED":
      case "ERROR":
        return const Color(0xFFE53935);
      default:
        return Colors.blueGrey;
    }
  }
}

// Header Components
class _HeaderTopRow extends StatelessWidget {
  const _HeaderTopRow();

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.findAncestorStateOfType<_DashboardState>()!;

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white24),
                color: Colors.white.withValues(alpha: 0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white24,
                    backgroundImage: dashboardState._profilePic != null && dashboardState._profilePic!.isNotEmpty
                        ? NetworkImage(baseUrlProfileImage + dashboardState._profilePic!) as ImageProvider
                        : null,
                    child: (dashboardState._profilePic == null || dashboardState._profilePic!.isEmpty)
                        ? (dashboardState._userName?.isNotEmpty == true
                            ? Text(
                                dashboardState._userName!.split(' ').first.substring(0, 1).toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              )
                            : const Icon(Icons.person, color: Colors.white, size: 20))
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      "Hi ${dashboardState._userName != null && dashboardState._userName!.trim().isNotEmpty ? dashboardState._userName!.split(' ').first : 'User'}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.notifications,
              arguments: NotificationScreen(showAppbar: true),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
                border: Border.all(color: Colors.white24),
              ),
              child: Stack(
                children: [
                  const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                  _NotificationBadge(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection();

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.findAncestorStateOfType<_DashboardState>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Balance label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations(context).walletBalance,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white70,
              size: 20,
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Balance amount
        dashboardState._balanceLoading
            ? const SizedBox(
                height: 36,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                : Builder(
                    builder: (context) {
                      final formatter = NumberFormat('#,##0.00');
                      final currency = (dashboardState._walletCurrency ?? '').toUpperCase();
                      final amountStr = formatter.format(dashboardState._walletBalance ?? 0);
                      final display = currency == 'GNF'
                          ? "$amountStr GNF"
                          : (currency.isNotEmpty ? "$currency $amountStr" : amountStr);
                      return Text(
                        display,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),

        const SizedBox(height: 6),

        // Account info intentionally hidden per design
      ],
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.findAncestorStateOfType<_DashboardState>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dashboardState._quickActions.map((action) {
        return _QuickActionButton(action: action);
      }).toList(),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, action.route),
          borderRadius: BorderRadius.circular(32),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: Icon(
              action.icon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getLocalizedTitle(context, action.titleKey),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  String _getLocalizedTitle(BuildContext context, String titleKey) {
    switch (titleKey) {
      case 'send':
        return appLocalizations(context).send;
      case 'received':
        return appLocalizations(context).received;
      case 'payment':
        return appLocalizations(context).payment;
      case 'linkedAccounts':
        return appLocalizations(context).linkedAccounts;
      default:
        return titleKey;
    }
  }
}

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: notificationsListBloc,
      listener: (context, state) {
        if (state is GetNotificationsListState) {
          if (state.value.code == HTTPResponseStatusCodes.sessionExpireCode) {
            showToast(state.value.message);
          }
        }
      },
      builder: (context, state) {
        if (state is GetNotificationsListState) {
          final notificationListData = state.value.data;
          final unreadNotificationCount = notificationListData?.unreadnotificationscount ?? 0;
          if (unreadNotificationCount == 0) {
            return const SizedBox.shrink();
          }
          return Positioned(
            right: 0,
            top: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 12, bottom: 0),
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadNotificationCount.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
