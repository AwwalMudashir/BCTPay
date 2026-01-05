import 'package:bctpay/lib.dart';

Widget buildInvoiceQRScreenshot(
    {required BuildContext context, required Invoice? invoice}) {
  return LocalizationsPortal(
    context: context,
    child: InvoiceQRShareView(invoice: invoice),
  );
}

class InvoiceQRShareView extends StatelessWidget {
  final Invoice? invoice;
  const InvoiceQRShareView({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDarkMode(context) ? themeLogoColorBlue : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InvoiceListItem(invoiceData: InvoiceData(invoiceDetails: invoice)),
          10.height,
          QRCodeViewWidget(
            qrCodeString: invoice?.paymentLink ?? "",
            logo: invoice?.merchantData?.companyLogo?.isNotEmpty ?? false
                ? "$baseUrlProfileImage${invoice?.merchantData?.companyLogo}"
                : null,
          ),
          10.height,
          Text(
            invoice?.merchantData?.businessCategoryName ?? "",
            style: textTheme(context).displayLarge,
          ),
          40.height,
          Text(
            appLocalizations(context).scanTheQRCodeToViewInvoiceDetails,
            style: textTheme(context)
                .headlineLarge
                ?.copyWith(color: themeLogoColorOrange),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
