import 'package:bctpay/lib.dart';

class AccountDetail extends StatefulWidget {
  final BankAccount? account;

  const AccountDetail({super.key, this.account});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final deleteCustomerAccountBloc = ApisBloc(ApisBlocInitialState());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfileDetailFromLocalBloc.add(SharedPrefGetUserDetailEvent());
      kycBloc.add(GetKYCDetailEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF6F7F9);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: themeLogoColorBlue,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(appLocalizations(context).accountDetail),
        centerTitle: true,
      ),
      body: BlocConsumer(
        bloc: deleteCustomerAccountBloc,
        listener: (context, state) {
          if (state is DeleteCustomerAccountState) {
            final code = state.value.code;
            final msg = state.value.message ?? state.value.error ?? "";
            if (code == 200) {
              showSuccessDialog(msg, context, dismissOnTouchOutside: false,
                  onOkBtnPressed: () {
                saveLoginDataAndClearAllAndNavigateToLogin(context);
              });
            } else if (code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(msg, context);
            } else {
              showFailedDialog(msg, context);
            }
          }
        },
        builder: (context, state) {
          final loading = state is ApisBlocLoadingState;
          return ModalProgressHUD(
            inAsyncCall: loading,
            progressIndicator: const Loader(),
            child: BlocBuilder(
              bloc: getProfileDetailFromLocalBloc,
              builder: (context, userState) {
                if (userState is! SharedPrefGetUserDetailState) {
                  return const Center(child: Loader());
                }
                final user = userState.user;
                final textTheme = Theme.of(context).textTheme;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Column(
                    children: [
                      _topCard(context, user, textTheme),
                      const SizedBox(height: 14),
                      _menuCard(context, user),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _topCard(BuildContext context, UserModel user, TextTheme textTheme) {
    final infoStyle =
        textTheme.bodySmall?.copyWith(color: Colors.black87, height: 1.35);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePicView(dimension: 56),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.userName,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.alternate_email_rounded,
                            size: 16, color: Colors.black54),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            user.email,
                            style: infoStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const ProfileQRCodeBtn(enableBorder: true),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.phone_iphone_rounded,
                  size: 16, color: Colors.black54),
              const SizedBox(width: 6),
              Text(
                user.phone,
                style: infoStyle,
              ),
              const SizedBox(width: 16),
              const Icon(Icons.location_on_outlined,
                  size: 16, color: Colors.black54),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  user.countryName,
                  style: infoStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuCard(BuildContext context, UserModel user) {
    final items = [
      _MenuEntry(
        icon: Icons.edit_outlined,
        label: appLocalizations(context).editProfile,
        onTap: () => Navigator.pushNamed(context, AppRoutes.updateProfile),
      ),
      _MenuEntry(
        icon: Icons.folder_shared_outlined,
        label: appLocalizations(context).kycDocuments,
        trailing: const MyKYCStatusView(),
        onTap: () => Navigator.pushNamed(context, AppRoutes.kycTakeASelfie),
      ),
      _MenuEntry(
        icon: Icons.account_balance_wallet_outlined,
        label: appLocalizations(context).banksAndWallets,
        onTap: () => Navigator.pushNamed(context, AppRoutes.accountsList,
            arguments: AccountsListScreen(
              showAppbar: true,
              titleText: appLocalizations(context).banksAndWallets,
            )),
      ),
      _MenuEntry(
        icon: Icons.lock_outline_rounded,
        label: appLocalizations(context).changePassword,
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.changePassword),
      ),
      _MenuEntry(
        icon: Icons.delete_outline_rounded,
        label: appLocalizations(context).deleteAccount,
        destructive: true,
        onTap: () {
          showCustomDialog(
            appLocalizations(context).doYouReallyWantToDeleteThisAccount,
            context,
            title: appLocalizations(context).warning,
            dialogType: DialogType.warning,
            onYesTap: () {
              deleteCustomerAccountBloc.add(DeleteCustomerAccountEvent());
              Navigator.pop(context);
            },
          );
        },
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _menuTile(context, items[i]),
            if (i != items.length - 1)
              Divider(height: 1, color: Colors.grey.shade200),
          ]
        ],
      ),
    );
  }

  Widget _menuTile(BuildContext context, _MenuEntry entry) {
    final textTheme = Theme.of(context).textTheme;
    final iconBg = entry.destructive
        ? const Color(0xFFFFF0F0)
        : themeLogoColorBlue.withValues(alpha: 0.12);
    final iconColor =
        entry.destructive ? Colors.redAccent : themeLogoColorBlue;
    final textColor = entry.destructive ? Colors.redAccent : Colors.black87;
    return InkWell(
      onTap: entry.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: iconBg,
              child: Icon(entry.icon, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                entry.label,
                style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700, color: textColor),
              ),
            ),
            if (entry.trailing != null) entry.trailing!,
            const Icon(Icons.chevron_right_rounded,
                size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _MenuEntry {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool destructive;

  _MenuEntry({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.destructive = false,
  });
}
