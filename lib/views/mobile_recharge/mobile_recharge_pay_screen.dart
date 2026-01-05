import 'package:bctpay/globals/index.dart';

class MobileRechargePayScreen extends StatefulWidget {
  final Plan? plan;
  final Contact? contact;

  const MobileRechargePayScreen({super.key, this.plan, this.contact});

  @override
  State<MobileRechargePayScreen> createState() =>
      _MobileRechargePayScreenState();
}

class _MobileRechargePayScreenState extends State<MobileRechargePayScreen> {
  List paymentMethods = [
    PaymentMethod(name: "Mobile Money", image: "momo"),
    PaymentMethod(name: "Orange Pay", image: "orange"),
    PaymentMethod(name: "Eco Bank", image: "ecobank"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as MobileRechargePayScreen;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: appLocalizations(context).pay),
      body: SafeArea(
        child: Container(
          height: height,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ContactListItem(contact: args.contact!, onTap: null),
              ChangePlanListItem(plan: args.plan!),
              const Spacer(),
              CustomBtn(
                text: appLocalizations(context).proceedToPay,
                onTap: () {
                  showSelectAccountSheet(args);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPayWithDialog(MobileRechargePayScreen args) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Image.asset(
                Assets.assetsImagesPayWithDialog,
                width: 121,
                height: 121,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(appLocalizations(context).payWith,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: themeYellowColor,
                      )),
                  SizedBox(
                    height: 80,
                    width: 250,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) => PaymentMethodListItem(
                          onTap: () {
                            Navigator.pop(context);
                            showSelectAccountSheet(args);
                          },
                          paymentMethod: paymentMethods[index]),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showSelectAccountSheet(args);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 40,
                        color: themeGreyColor,
                      ))
                ],
              ),
            ));
  }

  void showSelectAccountSheet(MobileRechargePayScreen args) {
    Navigator.pushNamed(context, AppRoutes.mobileRechargeSelectAccount,
        arguments: MobileRechargeSelectAccount(
          contact: args.contact,
          plan: args.plan,
        ));
  }
}
