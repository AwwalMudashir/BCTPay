import 'package:bctpay/globals/index.dart';

class MyQrScreen extends StatefulWidget {
  const MyQrScreen({super.key});

  @override
  State<MyQrScreen> createState() => _MyQrScreenState();
}

class _MyQrScreenState extends State<MyQrScreen> {
  bool _loading = true;
  String _qrData = "";
  String _error = "";

  @override
  void initState() {
    super.initState();
    _loadQr();
  }

  Future<void> _loadQr() async {
    setState(() {
      _loading = true;
      _error = "";
    });
    try {
      final res = await fetchMyQr();
      if (!mounted) return;
      setState(() {
        _qrData = res.qrCode;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = appLocalizations(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: themeLogoColorBlue,
        elevation: 0,
        title: Text(
          t.myQrTitle,
          style: textTheme.titleMedium
              ?.copyWith(color: themeLogoColorBlue, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadQr,
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // 4% of screen width
          child: _loading
              ? const Loader()
              : _error.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade400, size: MediaQuery.of(context).size.width * 0.08), // Responsive size
                        const SizedBox(height: 8),
                        Text(
                          _error,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _loadQr,
                          child: Text(t.tryAgain),
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header section above QR code
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          child: Column(
                            children: [
                              // Icon and title
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: themeLogoColorBlue.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.qr_code_2_rounded,
                                      color: themeLogoColorBlue,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "My QR Code",
                                    style: textTheme.titleMedium?.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Share this QR code to receive payments instantly",
                                textAlign: TextAlign.center,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey.shade700,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Anyone can scan this code to send money to your account",
                                textAlign: TextAlign.center,
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // QR Code section
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          child: QrImageView(
                            data: _qrData.isNotEmpty ? _qrData : "—",
                            size: 220,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Action buttons
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Quick Actions",
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _qrData.isEmpty
                                          ? null
                                          : () {
                                              Clipboard.setData(
                                                  ClipboardData(text: _qrData));
                                              showToast(t.addressCopied);
                                            },
                                      icon: Icon(Icons.copy_outlined, size: MediaQuery.of(context).size.width * 0.045), // Responsive size
                                      label: Text(t.copyAddress),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: themeLogoColorBlue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: _qrData.isEmpty
                                          ? null
                                          : () {
                                              // Using deprecated Share.share for now - will be updated in future
                                              // ignore: deprecated_member_use
                                              Share.share(_qrData);
                                            },
                                      icon: const Icon(Icons.share_outlined,
                                          color: themeLogoColorBlue),
                                      label: Text(
                                        t.shareAddress,
                                        style: const TextStyle(color: themeLogoColorBlue),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(color: themeLogoColorBlue),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
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
    );
  }
}
