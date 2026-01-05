import 'package:bctpay/globals/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String? url;
  final String? title;
  final bool isAvailable;
  final bool isInvoicePay;
  final bool isSubscriptionPay;
  final bool isPaymentLinkPay;

  const CustomWebView({
    super.key,
    this.url,
    this.title,
    this.isAvailable = true,
    this.isInvoicePay = false,
    this.isSubscriptionPay = false,
    this.isPaymentLinkPay = false,
  });

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  var controller = WebViewController();

  var loadingBloc = SelectionBloc(SelectBoolState(true));

  @override
  void didChangeDependencies() {
    var args = ModalRoute.of(context)!.settings.arguments as CustomWebView;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            loadingBloc.add(SelectBoolEvent(true));
            debugPrint(url);

            /// need to check in case of orange txn
            // switch (url) {
            //   case orangeMoneyReturnUrl:
            //     orangeMoneyConfig(url);
            //     break;
            //   case orangeMoneyCancelUrl:
            //     showFailedDialog(appLocalizations(context).cancel, context);
            //     break;
            //   case cardTxnReturnUrl:
            //     break;
            // }
          },
          onPageFinished: (String url) {
            debugPrint(url);

            if (url.contains(orangeMoneyReturnUrl)) {
              //Orange money txn success
              orangeMoneyConfig(url);
            } else if (url.contains(orangeMoneyCancelUrl)) {
              //Orange money txn cancelled
              showFailedDialog(appLocalizations(context).cancel, context);
            } else if (url.contains(cardTxnReturnUrl(""))) {
              //Card txn success
              cardTxnConfig(url);
            } else {}
            loadingBloc.add(SelectBoolEvent(false));
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.toString());
          },
        ),
      )
      ..loadRequest(Uri.parse(args.url ?? 'https://flutter.dev'));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as CustomWebView;
    return Scaffold(
      appBar: CustomAppBar(title: args.title ?? ""),
      body: args.isAvailable
          ? BlocBuilder(
              bloc: loadingBloc,
              builder: (context, loadingState) {
                if (loadingState is SelectBoolState) {
                  return ModalProgressHUD(
                    progressIndicator: const Loader(),
                    inAsyncCall: loadingState.value,
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  );
                }
                return const Loader();
              })
          : Center(
              child: Text(
                  appLocalizations(context).thisFuctionalityWillAvailableSoon)),
    );
  }

  void orangeMoneyConfig(String url) {
    var orderId = url.split("/").last;
    // print(orderId);
    loadingBloc.add(SelectBoolEvent(true));
    getOrangeMoneyTxnStatus(orderId: orderId).then(handleResponse);
  }

  void cardTxnConfig(String url) {
    var orderId = url.split("=").last;
    loadingBloc.add(SelectBoolEvent(true));
    Future.delayed(Duration(seconds: 60)).then((v) {
      if (!mounted) return;
      var args = ModalRoute.of(context)!.settings.arguments as CustomWebView;
      args.isInvoicePay
          ? checkoutEFTInvoiceTxn(orderId: orderId).then(handleResponse)
          : args.isSubscriptionPay
              ? checkoutEFTSubscriptionTxn(orderId: orderId)
                  .then(handleResponse)
              : args.isPaymentLinkPay
                  ? checkoutEFTTicketTxn(orderId: orderId).then(handleResponse)
                  : checkoutEFTTxn(orderId: orderId).then(handleResponse);
    });
  }

  FutureOr handleResponse(InitiateTransactionResponse response) {
    loadingBloc.add(SelectBoolEvent(false));
    if (response.code == 200) {
      //SUCCESSFUL for card payment
      //SUCCESS for orange
      if (response.data?.transactionStepWithSender == "SUCCESS" ||
          response.data?.transactionStepWithSender == "SUCCESSFUL") {
        showSuccessTxnDialog(response, context);
      } else {
        showFailedDialog(response.message, context, onTap: () {
          Navigator.popUntil(
            context,
            (route) => route.settings.name == AppRoutes.transactiondetail,
          );
        });
      }
    } else if (response.code == HTTPResponseStatusCodes.sessionExpireCode) {
      sessionExpired(response.message, context);
    } else {
      showFailedDialog(response.message, context, onTap: () {
        Navigator.popUntil(
          context,
          (route) => route.settings.name == AppRoutes.transactiondetail,
        );
      });
    }
  }
}
