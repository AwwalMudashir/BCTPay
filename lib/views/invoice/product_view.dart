import 'package:bctpay/lib.dart';

class ProductView extends StatelessWidget {
  final ProductInfo? productInfo;

  const ProductView({super.key, required this.productInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isDarkMode(context) ? themeColorHeader : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productInfo?.productNameEn ?? "",
              style: textTheme(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            5.height,
            ProductRow(
              subtitle: "${appLocalizations(context).price} : ",
              value: formatCurrency(
                  productInfo?.productPrice?.toStringAsFixed(2) ?? "0.00"),
            ),
            ProductRow(
                subtitle: "${appLocalizations(context).quantity} : ",
                value: productInfo?.productQuantity.toString() ?? "0"),
            if ((productInfo?.productTax.isNotEmpty ?? false) &&
                ((double.tryParse(productInfo?.productTax ?? "0") ?? 0) > 0))
              ProductRow(
                  subtitle: "${appLocalizations(context).productTax} : ",
                  value: "${productInfo?.productTax ?? "0"} %"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${appLocalizations(context).totalProductPrice} : ",
                  style: textTheme(context)
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
                Text(
                  formatCurrency(
                      productInfo?.totalProductPrice?.toStringAsFixed(2) ??
                          "0.00"),
                  style: textTheme(context).bodyLarge?.copyWith(
                        color: themeLogoColorOrange,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
