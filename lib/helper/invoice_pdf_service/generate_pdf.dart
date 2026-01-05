// // import 'package:bctpay/globals/index.dart';
// import 'dart:io';

// import 'package:bctpay/globals/functions/currency_formatter.dart';
// import 'package:bctpay/globals/functions/date_time_formatter.dart';
// import 'package:bctpay/helper/invoice_pdf_service/save_download_pdf.dart';
// import 'package:bctpay/models/invoice_detail_response.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

// import '../../models/profile_response_model.dart';

// class GeneratePdf {
//   static Future<File> generate(ctx, InvoiceDetailData invoice) async {
//     var myTheme = ThemeData.withFont(
//       base:
//           Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Regular.ttf")),
//       bold: Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Bold.ttf")),
//       italic:
//           Font.ttf(await rootBundle.load("assets/fonts/OpenSans-Italic.ttf")),
//       boldItalic: Font.ttf(
//           await rootBundle.load("assets/fonts/OpenSans-BoldItalic.ttf")),
//     );

//     var pdf = Document(
//       theme: myTheme,
//     );
//     //final pdf = Document();

//     pdf.addPage(MultiPage(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       pageFormat: PdfPageFormat.a4,
//       margin: const EdgeInsets.symmetric(
//           horizontal: 2 * PdfPageFormat.mm, vertical: 1 * PdfPageFormat.cm),
//       header: (context) {
//         return SizedBox(height: 0);
//       },
//       build: (context) => [
//         //SizedBox(height: 1 * PdfPageFormat.cm),
//         buildHeader(invoice),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         buildSubHeader(ctx, invoice),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         buildInvoice(invoice),
//         SizedBox(height: 1 * PdfPageFormat.mm),
//         Divider(),
//         SizedBox(height: 1 * PdfPageFormat.mm),
//         buildTotal(invoice),
//         SizedBox(height: 1 * PdfPageFormat.cm),
//         buildQr(invoice),
//         /*  SizedBox(height: 2 * PdfPageFormat.cm),
//         buildNotes(invoice),*/
//       ],
//     ));

//     return SaveDownloadPdf.saveDocument(
//         name: "${invoice.invoiceData.invoiceNumber}.pdf", pdf: pdf);
//   }

//   // get total
//   static double getTotal(InvoiceData invoice) {
//     double netTotal = 0.0;
//     for (var e in invoice.productInfo) {
//       netTotal += e.productPrice ?? 0.0;
//     }
//     return netTotal;
//   }

//   // get VAT
//   static double getVAT(InvoiceData invoice) {
//     double vat = 0.0;
//     for (var e in invoice.productInfo) {
//       vat += (e.productPrice * e.productQuantity * double.parse(e.productTax)) /
//           100;
//     }
//     return vat;
//   }

//   static Widget buildHeader(InvoiceDetailData invoice) {
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       Image(MemoryImage(Uint8List(0)), height: 70, width: 70),

//       ///TODO: image
//       Column(
//         children: [
//           Container(
//             height: 80,
//             width: 80,
//             child: BarcodeWidget(
//               barcode: Barcode.qrCode(),
//               data: invoice.invoiceData.invoiceqrCode,
//             ),
//           ),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           Text(
//             invoice.invoiceData.invoiceNumber,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: const PdfColor.fromInt(0xff021629),
//                 fontStyle: FontStyle.italic),
//           ),
//         ],
//       ),
//     ]);
//   }

//   static Widget buildSubHeader(context, InvoiceDetailData invoice) => Container(
//         // width: Utility.getWidth(context),
//         padding: const EdgeInsets.all(8),
//         alignment: Alignment.center,
//         color: const PdfColor.fromInt(0xffc7c7cb),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             buildCustomerAddress(invoice.customer),
//             buildSupplierAddress(invoice.supplier),
//           ],
//         ),
//       );

//   static Widget buildSupplierAddress(Supplier supplier) => Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(supplier.title),
//           Text(supplier.name),
//           Text(supplier.email),
//           Text(supplier.phone),
//           Text(supplier.address),
//         ],
//       );

//   static Widget buildCustomerAddress(Customer customer) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(customer.title),
//           Text(customer.businessName ?? ""),
//           Text(customer.name),
//           Text((customer.phone.isNotEmpty ? customer.phone : "")),
//           // if (customer.vatNumber?.isNotEmpty ?? false)
//           Text((customer.vatNumber?.isNotEmpty ?? false)
//               ? customer.vatNumber ?? ""
//               : ""),
//           //if (customer.address.isNotEmpty)
//           Text(customer.address.isNotEmpty ? customer.address : ""),
//         ],
//       );

//   static Widget buildInvoice(InvoiceDetailData invoice) {
//     final headers = [
//       invoice.invoiceData.productDetailsText,
//       invoice.invoiceData.referenceNoText,
//       invoice.invoiceData.qtyText,
//       invoice.invoiceData.priceText,
//       invoice.invoiceData.taxText,
//       invoice.invoiceData.amountText
//     ];
//     final data = invoice.invoiceData.productInfo.map((item) {
//       //final total = item.unitPrice * item.quantity * (1.0 + item.tax);

//       return [
//         item.name,
//         item.referenceNumber,
//         '${item.quantity}',
//         (formatCurrency(item.unitPrice.toStringAsFixed(2))),
//         '${item.tax} %',
//         (formatCurrency((item.amount ?? 0.0).toStringAsFixed(2))),
//         //(formatCurrency(total.toStringAsFixed(2))),
//       ];
//     }).toList();

//     return TableHelper.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: const BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }

//   static Widget buildTotal(Invoice invoice) {
//     return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text("${invoice.info.netTotalText}:",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: const PdfColor.fromInt(0xff021629),
//             )),
//         SizedBox(height: 2 * PdfPageFormat.mm),
//         Text("${invoice.info.vatTotalText}:",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: const PdfColor.fromInt(0xff021629),
//             )),
//         SizedBox(height: 2 * PdfPageFormat.mm),
//         Text("${invoice.info.totalText}:",
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: const PdfColor.fromInt(0xffff7800))),
//       ]),
//       SizedBox(width: 2 * PdfPageFormat.cm),
//       Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//         Text(formatCurrency(getTotal(invoice).toStringAsFixed(2))),
//         SizedBox(height: 2 * PdfPageFormat.mm),
//         Text(formatCurrency(getVAT(invoice).toStringAsFixed(2))),
//         SizedBox(height: 2 * PdfPageFormat.mm),
//         Text(
//             formatCurrency(
//                 (getTotal(invoice) + getVAT(invoice)).toStringAsFixed(2)),
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: const PdfColor.fromInt(0xffff7800))),
//       ]),
//     ]);
//   }

//   static Widget buildQr(InvoiceDetailData invoice) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         /*Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "PAYMENT DETAILS",
//               style: TextStyle(fontWeight: FontWeight.bold,
//                   color: const PdfColor.fromInt(0xff021629)),
//             ),
//             SizedBox(height: 1 * PdfPageFormat.mm),
//             Text("Bank/Sort Code: 1234567"),
//             SizedBox(height: 1 * PdfPageFormat.mm),
//             Text("Account Number: 123456678"),
//             SizedBox(height: 1 * PdfPageFormat.mm),
//             Text("Payment Reference: CSE-00335")
//           ]
//         ),*/
//         Column(children: [
//           Text(
//             invoice.invoiceData.invoiveNote,
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: const PdfColor.fromInt(0xff021629),
//                 fontStyle: FontStyle.italic),
//           ),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           if (invoice.invoiceData.invoiveNote.isNotEmpty)
//             Text(invoice.invoiceData.invoiveNote),
//         ]),
//         Row(children: [
//           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//             Text(
//               invoice.invoiceData.invoiceDate.formattedDateTime(),
//             ),
//             Text(
//               invoice.info.date,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ]),
//           SizedBox(width: 1 * PdfPageFormat.cm),
//           Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//             Text("${invoice.info.dueDateText} #"),
//             Text(
//               invoice.info.dueDate,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ]),
//         ]),
//       ],
//     );
//   }
// }
