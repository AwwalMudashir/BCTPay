import 'package:bctpay/globals/index.dart';

class ReceiveMoneyScreen extends StatefulWidget {
  const ReceiveMoneyScreen({super.key});

  @override
  State<ReceiveMoneyScreen> createState() => _ReceiveMoneyScreenState();
}

class _ReceiveMoneyScreenState extends State<ReceiveMoneyScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrController;
  bool _scanning = false;
  bool _loading = false;
  WalletNameByQrResponse? _scanResult;

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = appLocalizations(context);
    final textTheme = Theme.of(context).textTheme;
    final hasResult = _scanResult != null;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: themeLogoColorBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          t.receiveMoneyTitle,
          style: textTheme.titleMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.scanQrToReceive,
              style: textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _card(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: QRView(
                        key: qrKey,
                        overlay: QrScannerOverlayShape(
                          borderColor: themeLogoColorBlue,
                          borderRadius: 16,
                          borderLength: 40,
                          borderWidth: 8,
                          cutOutSize: MediaQuery.of(context).size.width * 0.7,
                        ),
                        onQRViewCreated: (ctrl) {
                          _qrController = ctrl;
                          ctrl.resumeCamera();
                          ctrl.scannedDataStream.listen(_onScan);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loading ? null : _resumeScan,
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    label: Text(t.scan),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeLogoColorBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (hasResult) _detailsCard(textTheme, t, _scanResult!),
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Loader(),
              ),
            if (!hasResult && !_loading)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  t.receiveSubtitle,
                  style:
                      textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _resumeScan() {
    _qrController?.resumeCamera();
    setState(() {
      _scanResult = null;
    });
  }

  void _onScan(Barcode barcode) async {
    if (_scanning) return;
    final code = barcode.code ?? "";
    if (code.isEmpty) return;
    print("[SCAN] scanned qr=$code");
    _scanning = true;
    _qrController?.pauseCamera();
    setState(() => _loading = true);
    try {
      final res = await getWalletNameByQr(code);
      if (!mounted) return;
      setState(() {
        _scanResult = res;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
      showFailedDialog(e.toString(), context);
    } finally {
      _scanning = false;
    }
  }

  Widget _detailsCard(
      TextTheme textTheme, AppLocalizations t, WalletNameByQrResponse res) {
    final amountCtrl = TextEditingController();
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.receiveDetails,
            style:
                textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          _infoRow(textTheme, t.accountName, res.accountName),
          _infoRow(textTheme, t.accountNumber, res.accountNo),
          _infoRow(textTheme, t.accountType, res.accountType),
          _infoRow(textTheme, t.currency, res.ccyCode),
          const SizedBox(height: 12),
          TextField(
            controller: amountCtrl,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: t.amountToReceive,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.sendBankSuccess,
                  arguments: {
                    "bank": res.accountName,
                    "accountNumber": res.accountNo,
                    "accountName": res.accountName,
                    "amount": amountCtrl.text.isNotEmpty
                        ? amountCtrl.text
                        : "${res.ccyCode} 0.00",
                    "currency": res.ccyCode,
                    "walletLabel": res.accountType,
                    "note": "",
                    "responseCode": res.responseCode,
                    "responseMessage": res.responseMessage,
                    "refNo": "",
                    "status": res.responseMessage,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeLogoColorBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(t.confirmAndReceive),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(TextTheme textTheme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyMedium),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }
}
