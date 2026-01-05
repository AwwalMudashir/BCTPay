import 'package:bctpay/globals/index.dart';

class MyKYCStatusView extends StatelessWidget {
  const MyKYCStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    kycBloc.add(GetKYCDetailEvent());
    return BlocConsumer(
        bloc: kycBloc,
        listener: (context, state) {
          if (state is GetKYCDetailState) {
            if (state.value.code == HTTPResponseStatusCodes.sessionExpireCode) {
              sessionExpired(
                  state.value.message ?? state.value.error ?? "", context);
            }
          }
        },
        builder: (context, state) {
          if (state is GetKYCDetailState) {
            var kycStatus = state.value.data?.kycStatus ?? KYCStatus.pending;
            return KYCStatusView(
              kycStatus: kycStatus,
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class KYCStatusView extends StatelessWidget {
  final KYCStatus kycStatus;
  const KYCStatusView({super.key, required this.kycStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: getKYCStatusColor(kycStatus)),
      child: Text(
        kycStatus.value ?? appLocalizations(context).kycPending,
        style: textTheme(context)
            .bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
