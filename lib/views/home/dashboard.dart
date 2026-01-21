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
      title: 'Send',
    ),
    _QuickAction(
      route: AppRoutes.receiveMoney,
      icon: Icons.call_received_rounded,
      title: 'Receive',
    ),
    _QuickAction(
      route: AppRoutes.generatePaymentLink,
      icon: Icons.link_rounded,
      title: 'Payment',
    ),
    _QuickAction(
      route: AppRoutes.accountsList,
      icon: Icons.account_balance_wallet_rounded,
      title: 'Accounts',
    ),
  ];

  // State variables
  String? _userName;
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
    return SafeArea(
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
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          )
        ],
      ),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transaction History",
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
                child: const Text("View All"),
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
                "No transactions yet",
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
  final String title;

  const _QuickAction({
    required this.icon,
    required this.route,
    required this.title,
  });
}

class _TransactionCard extends StatelessWidget {
  final TransactionHistoryItem transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isCredit = transaction.isCredit;
    final amountColor = isCredit ? Colors.teal : Colors.red;
    final status = transaction.status.toUpperCase();
    final statusColor = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transaction icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.call_received : Icons.north_east,
              color: amountColor,
              size: 24,
            ),
          ),

          const SizedBox(width: 16),

          // Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and amount row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        transaction.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      transaction.formattedAmount,
                      textAlign: TextAlign.right,
                      style: textTheme.titleMedium?.copyWith(
                        color: amountColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Date
                Text(
                  transaction.tranDate,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 6),

                // Type and Reference
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Type: ${transaction.transactionType}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            "Ref: ",
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              transaction.tranRefNo.isNotEmpty
                                  ? transaction.tranRefNo
                                  : "N/A",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status.isNotEmpty ? status : "STATUS",
                    style: textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Color _getStatusColor(String status) {
    switch (status) {
      case "SUCCESS":
      case "COMPLETED":
        return Colors.teal;
      case "PENDING":
        return Colors.orange;
      case "FAILED":
      case "ERROR":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Header Components
class _HeaderTopRow extends StatelessWidget {
  const _HeaderTopRow();

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.findAncestorStateOfType<_DashboardState>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white24),
            color: Colors.white.withValues(alpha: 0.1),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white24,
                child: dashboardState._userName?.isNotEmpty ?? false
                    ? Text(
                        dashboardState._userName!.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )
                    : const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  "Hi, ${dashboardState._userName?.trim().isNotEmpty == true ? dashboardState._userName! : "User"}",
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
                  return Text(
                    "${dashboardState._walletCurrency ?? ''} ${formatter.format(dashboardState._walletBalance ?? 0)}".trim(),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),

        const SizedBox(height: 6),

        // Account info
        if (dashboardState._walletAccountName != null || dashboardState._walletAccountNo != null)
          Text(
            "${dashboardState._walletAccountName ?? ""} ${dashboardState._walletAccountNo ?? ""}".trim(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
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
          action.title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
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
